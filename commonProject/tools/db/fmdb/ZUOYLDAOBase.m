//
//  ZUOYLDAOBase.m
//  asiastarbus
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "ZUOYLDAOBase.h"


#import <objc/runtime.h>
@implementation ZUOYLDAOBase
@synthesize columeNames;
@synthesize columeTypes;
@synthesize bindingQueue;
+(const NSString *)getTableName
{
    return @"";
}
+(Class)getBindingModelClass
{
    return [ZUOYLModelBase class];
}
-(id)initWithDbqueue:(FMDatabaseQueue *)queue
{
    self = [self init];
    if(self)
    {
        self.bindingQueue = queue;
        
        columeNames = [NSMutableArray arrayWithCapacity:16];
        columeTypes = [NSMutableArray arrayWithCapacity:16];
        
        //获取绑定的 Model 并 保存 Model 的属性信息
        NSDictionary* dic  = [[self.class getBindingModelClass] getPropertys];
        NSArray* pronames = [dic objectForKey:@"name"];
        NSArray* protypes = [dic objectForKey:@"type"];
        self.propertys = [NSMutableDictionary dictionaryWithObjects:protypes forKeys:pronames];
        for (int i =0; i<pronames.count; i++) {
            [self addColume:[pronames objectAtIndex:i] type:[protypes objectAtIndex:i]];
        }
        
        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
            //就 实例化的时候 创建表
            [self createTable];
//        });
        
    }
    return self;
}
-(void)createTable
{
    
    if([[self.class getTableName] isEmptyWithTrim])
    {
        NSLog(@"LKTableName is None!");
        return;
    }
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSString* createTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",[self.class getTableName],[self getParameterString]];
         [db executeUpdate:createTable];
         
     }];
}
-(void)addColume:(NSString *)name type:(NSString *)type
{
    [columeNames addObject:name];
    [columeTypes addObject:[ZUOYLDAOBase toDBType:type]];
}
-(void)addColumePrimary:(NSString *)name type:(NSString *)type
{
    [columeNames addObject:name];
    [columeTypes addObject:[NSString stringWithFormat:@"%@ primary key",[ZUOYLDAOBase toDBType:type]]];
}
-(NSString *)getParameterString
{
    NSMutableString* pars = [NSMutableString string];
    for (int i=0; i<columeNames.count; i++) {
        if ([[columeNames objectAtIndex:i]isEqualToString:@"identity"]) {
            [pars appendFormat:@"%@ %@ primary key",[columeNames objectAtIndex:i],[columeTypes objectAtIndex:i]];
        }else{
            [pars appendFormat:@"%@ %@",[columeNames objectAtIndex:i],[columeTypes objectAtIndex:i]];
        }
        if(i+1 !=columeNames.count)
        {
            [pars appendString:@","];
        }
    }
    return pars;
}
-(void)searchAll:(void(^)(NSArray*))callback{
    [self searchWhere:nil orderBy:nil offset:0 count:15 callback:callback];
}
-(void)searchWhere:(NSString*)where callback:(void(^)(NSArray*))block{
    [self searchWhere:where orderBy:nil offset:0 count:15 callback:block];
}
-(void)searchWhere:(NSString *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count callback:(void (^)(NSArray *))block
{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSMutableString* query = [NSMutableString stringWithFormat:@"select rowid,* from %@ ",[self.class getTableName]];
         if(where != nil && ![where isEmptyWithTrim])
         {
             [query appendFormat:@" where %@",where];
         }
         if(columeName != nil && ![columeName isEmptyWithTrim])
         {
             [query appendFormat:@" order by %@",columeName];
         }
         [query appendFormat:@" limit %d offset %d ",count,offset];
         FMResultSet* set =[db executeQuery:query];
         NSMutableArray* array = [NSMutableArray arrayWithCapacity:0];
         while ([set next]) {
             ZUOYLModelBase* bindingModel = [[[self.class getBindingModelClass] alloc]init];
             bindingModel.rowid = [set intForColumnIndex:0];
             for (int i=0; i<self.columeNames.count; i++) {
                 NSString* columeName = [self.columeNames objectAtIndex:i];
                 NSString* columeType = [self.propertys objectForKey:columeName];
                 if([@"intfloatdoublelongcharshort" rangeOfString:columeType].location != NSNotFound)
                 {
                     [bindingModel setValue:[NSNumber numberWithDouble:[set doubleForColumn:columeName]] forKey:columeName];
                 }
                 else if([columeType isEqualToString:@"NSString"])
                 {
                     [bindingModel setValue:[set stringForColumn:columeName] forKey:columeName];
                 }
                 else if([columeType isEqualToString:@"UIImage"])
                 {
                     NSString* filename = [set stringForColumn:columeName];
                     if([ZUOYLTempHelper isFileExists:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbimg"]])
                     {
                         UIImage* img = [UIImage imageWithContentsOfFile:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbimg"]];
                         [bindingModel setValue:img forKey:columeName];
                     }
                 }
                 else if([columeType isEqualToString:@"NSDate"])
                 {
                     NSString* datestr = [set stringForColumn:columeName];
                     [bindingModel setValue:[ZUOYLDAOBase dateWithString:datestr] forKey:columeName];
                 }
                 else if([columeType isEqualToString:@"NSData"])
                 {
                     NSString* filename = [set stringForColumn:columeName];
                     if([ZUOYLTempHelper isFileExists:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbdata"]])
                     {
                         NSData* data = [NSData dataWithContentsOfFile:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbdata"]];
                         [bindingModel setValue:data forKey:columeName];
                     }
                 }
                 
             }
             [array addObject:bindingModel];
         }
         block(array);
     }];
}
-(void)replaceArrayToDB:(NSArray*)array callback:(void (^)(BOOL))block{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         [db beginTransaction];
         BOOL isRollBack = NO;
         @try {
             for (int i=0; i<[array count]; i++) {
                 ZUOYLModelBase *model=[array objectAtIndex:i];
                 NSDate* date = [NSDate date];
                 NSMutableString* insertKey = [NSMutableString stringWithCapacity:0];
                 NSMutableString* insertValuesString = [NSMutableString stringWithCapacity:0];
                 NSMutableArray* insertValues = [NSMutableArray arrayWithCapacity:self.columeNames.count];
                 for (int i=0; i<self.columeNames.count; i++) {
                     
                     NSString* proname = [self.columeNames objectAtIndex:i];
                     [insertKey appendFormat:@"%@,", proname];
                     [insertValuesString appendString:@"?,"];
                     id value = [model valueForKey:proname];
                     if([value isKindOfClass:[UIImage class]])
                     {
                         NSString* filename = [NSString stringWithFormat:@"img%f",[date timeIntervalSince1970]];
                         [UIImageJPEGRepresentation(value, 1) writeToFile:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbimg"] atomically:YES];
                         value = filename;
                     }
                     else if([value isKindOfClass:[NSData class]])
                     {
                         NSString* filename = [NSString stringWithFormat:@"data%f",[date timeIntervalSince1970]];
                         [value writeToFile:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbdata"] atomically:YES];
                         value = filename;
                     }
                     else if([value isKindOfClass:[NSDate class]])
                     {
                         value = [ZUOYLDAOBase stringWithDate:value];
                     }
                     [insertValues addObject:value];
                 }
                 [insertKey deleteCharactersInRange:NSMakeRange(insertKey.length - 1, 1)];
                 [insertValuesString deleteCharactersInRange:NSMakeRange(insertValuesString.length - 1, 1)];
                 NSString* insertSQL = [NSString stringWithFormat:@"replace into %@(%@) values(%@)",[self.class getTableName],insertKey,insertValuesString];
                 BOOL execute = [db executeUpdate:insertSQL withArgumentsInArray:insertValues];
                 model.rowid = db.lastInsertRowId;
                 if(block != nil)
                 {
                     block(execute);
                 }
                 if(execute == NO)
                 {
                     NSLog(@"database insert fail %@",NSStringFromClass(model.class));
                 }
                 
             }
         }
         @catch (NSException *exception) {
             isRollBack = YES;
             [db rollback];
         }
         @finally {
             if (!isRollBack) {
                 [db commit];
//                 [db close];
             }
         }
         
    }];

}
-(void)insertToDB:(ZUOYLModelBase*)model callback:(void(^)(BOOL))block{
    
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSDate* date = [NSDate date];
         NSMutableString* insertKey = [NSMutableString stringWithCapacity:0];
         NSMutableString* insertValuesString = [NSMutableString stringWithCapacity:0];
         NSMutableArray* insertValues = [NSMutableArray arrayWithCapacity:self.columeNames.count];
         for (int i=0; i<self.columeNames.count; i++) {
             
             NSString* proname = [self.columeNames objectAtIndex:i];
             [insertKey appendFormat:@"%@,", proname];
             [insertValuesString appendString:@"?,"];
             id value = [model valueForKey:proname];
             if([value isKindOfClass:[UIImage class]])
             {
                 NSString* filename = [NSString stringWithFormat:@"img%f",[date timeIntervalSince1970]];
                 [UIImageJPEGRepresentation(value, 1) writeToFile:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbimg"] atomically:YES];
                 value = filename;
             }
             else if([value isKindOfClass:[NSData class]])
             {
                 NSString* filename = [NSString stringWithFormat:@"data%f",[date timeIntervalSince1970]];
                 [value writeToFile:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbdata"] atomically:YES];
                 value = filename;
             }
             else if([value isKindOfClass:[NSDate class]])
             {
                 value = [ZUOYLDAOBase stringWithDate:value];
             }
             [insertValues addObject:value];
         }
         [insertKey deleteCharactersInRange:NSMakeRange(insertKey.length - 1, 1)];
         [insertValuesString deleteCharactersInRange:NSMakeRange(insertValuesString.length - 1, 1)];
         NSString* insertSQL = [NSString stringWithFormat:@"insert into %@(%@) values(%@)",[self.class getTableName],insertKey,insertValuesString];
         BOOL execute = [db executeUpdate:insertSQL withArgumentsInArray:insertValues];
         model.rowid = db.lastInsertRowId;
         if(block != nil)
         {
             block(execute);
         }
         if(execute == NO)
         {
             NSLog(@"database insert fail %@",NSStringFromClass(model.class));
         }
     }];
}
-(void)updateToDB:(ZUOYLModelBase*)model callback:(void(^)(BOOL))block{
    
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSDate* date = [NSDate date];
         NSMutableString* updateKey = [NSMutableString stringWithCapacity:0];
         NSMutableArray* updateValues = [NSMutableArray arrayWithCapacity:self.columeNames.count];
         for (int i=0; i<self.columeNames.count; i++) {
             
             NSString* proname = [self.columeNames objectAtIndex:i];
             [updateKey appendFormat:@" %@=?,", proname];
             id value = [model valueForKey:proname];
             
             if([value isKindOfClass:[UIImage class]])
             {
                 NSString* filename = [NSString stringWithFormat:@"img%f",[date timeIntervalSince1970]];
                 [UIImageJPEGRepresentation(value, 1) writeToFile:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbimg"] atomically:YES];
                 value = filename;
             }
             else if([value isKindOfClass:[NSData class]])
             {
                 NSString* filename = [NSString stringWithFormat:@"data%f",[date timeIntervalSince1970]];
                 [value writeToFile:[ZUOYLTempHelper getPathForDocuments:filename inDir:@"dbdata"] atomically:YES];
                 value = filename;
             }
             else if([value isKindOfClass:[NSDate class]])
             {
                 value = [ZUOYLDAOBase stringWithDate:value];
             }
             [updateValues addObject:value];
         }
         [updateKey deleteCharactersInRange:NSMakeRange(updateKey.length - 1, 1)];
         NSString* updateSQL;
         if(model.rowid > 0)
         {
             updateSQL = [NSString stringWithFormat:@"update %@ set %@ where rowid=%d",[self.class getTableName],updateKey,model.rowid];
         }
         else
         {
             //如果不通过 rowid 来 更新数据  那 primarykey 一定要有值
             updateSQL = [NSString stringWithFormat:@"update %@ set %@ where %@=?",[self.class getTableName],updateKey,model.primaryKey];
             [updateValues addObject:[model valueForKey:model.primaryKey]];
         }
         BOOL execute = [db executeUpdate:updateSQL withArgumentsInArray:updateValues];
         if(block != nil)
         {
             block(execute);
         }
         if(execute == NO)
         {
             NSLog(@"database update fail %@   ----->rowid: %d",NSStringFromClass(model.class),model.rowid);
         }
     }];
    
    
}

-(void)deleteToDB:(ZUOYLModelBase*)model callback:(void(^)(BOOL))block{
    
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         NSString* delete;
         BOOL result;
         if(model.rowid > 0)
         {
             delete = [NSString stringWithFormat:@"DELETE FROM %@ where rowid=%d",[self.class getTableName],model.rowid];
             result = [db executeUpdate:delete];
         }
         else
         {
             delete = [NSString stringWithFormat:@"DELETE FROM %@ where %@=?",[self.class getTableName],model.primaryKey];
             result = [db executeUpdate:delete,[model valueForKey:model.primaryKey]];
         }
         if(block != nil)
         {
             block(result);
         }
     }];
}
-(void)isExistsModel:(ZUOYLModelBase*)model callback:(void(^)(BOOL))block{
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         //rowid 就不判断了
         NSString* rowCountSql = [NSString stringWithFormat:@"select count(*) from %@ where %@ = '%@'",[self.class getTableName],model.primaryKey,[model valueForKey:model.primaryKey]];
         FMResultSet* resultSet = [db executeQuery:rowCountSql];
         [resultSet next];
         int result =  [resultSet intForColumnIndex:0];
         [resultSet close];
         BOOL exists = (result != 0);
         if(block != nil)
         {
             block(exists);
         }
     }];
}
-(void)deleteToDBcallback:(void (^)(BOOL))block {
    [bindingQueue inDatabase:^(FMDatabase* db)
     {
         BOOL result;
         NSString* delete = [NSString stringWithFormat:@"DELETE FROM %@",[self.class getTableName]];
         result = [db executeUpdate:delete];
         if(block != nil)
         {
             block(result);
         }
     }];
}
const static NSString* normaltypestring = @"floatdoublelongcharshort";
const static NSString* blobtypestring = @"NSDataUIImage";
+(NSString *)toDBType:(NSString *)type
{
    if([type isEqualToString:@"int"])
    {
        return LKSQLInt;
    }
    if ([normaltypestring rangeOfString:type].location != NSNotFound) {
        return LKSQLDouble;
    }
    if ([blobtypestring rangeOfString:type].location != NSNotFound) {
        return LKSQLBlob;
    }
    return LKSQLText;
}
#pragma mark-
+(NSDateFormatter*)getDateFormat
{
    static  NSDateFormatter* formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    return formatter;
}
//把Date 转换成String
+(NSString*)stringWithDate:(NSDate*)date
{
    NSDateFormatter* formatter = [self getDateFormat];
    NSString* datestr = [formatter stringFromDate:date];
    return datestr;
}
+(NSDate *)dateWithString:(NSString *)str
{
    NSDateFormatter* formatter = [self getDateFormat];
    NSDate* date = [formatter dateFromString:str];
    return date;
}
@end
@implementation ZUOYLModelBase
@synthesize primaryKey;
+(NSDictionary *)getPropertys
{
    NSMutableArray* pronames = [NSMutableArray array];
    NSMutableArray* protypes = [NSMutableArray array];
    NSDictionary* props = [NSDictionary dictionaryWithObjectsAndKeys:pronames,@"name",protypes,@"type",nil];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if([propertyName isEqualToString:@"primaryKey"]||[propertyName isEqualToString:@"rowid"])
        {
            continue;
        }
        [pronames addObject:propertyName];
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        /*
         c char
         i int
         l long
         s short
         d double
         f float
         @ id //指针 对象
         ...  BOOL 获取到的表示 方式是 char
         .... ^i 表示  int*  一般都不会用到
         */
        if ([propertyType hasPrefix:@"T@"]) {
            [protypes addObject:[propertyType substringWithRange:NSMakeRange(3, [propertyType rangeOfString:@","].location-4)]];
        }
        else if ([propertyType hasPrefix:@"Ti"])
        {
            [protypes addObject:@"int"];
        }
        else if ([propertyType hasPrefix:@"Tf"])
        {
            [protypes addObject:@"float"];
        }
        else if([propertyType hasPrefix:@"Td"]) {
            [protypes addObject:@"double"];
        }
        else if([propertyType hasPrefix:@"Tl"])
        {
            [protypes addObject:@"long"];
        }
        else if ([propertyType hasPrefix:@"Tc"]) {
            [protypes addObject:@"char"];
        }
        else if([propertyType hasPrefix:@"Ts"])
        {
            [protypes addObject:@"short"];
        }
        
    }
    free(properties);
    if([self superclass] != [NSObject class])
    {
        NSDictionary* propertys = [[self superclass] getPropertys];
        [pronames addObjectsFromArray:[propertys objectForKey:@"name"]];
        [protypes addObjectsFromArray:[propertys objectForKey:@"type"]];
    }
    return props;
}
-(id)valueForKey:(NSString *)key
{
    id value = [super valueForKey:key];
    if(value == nil)
    {
        return @"";
    }
    return value;
}
-(NSString *)description
{
    NSMutableString* sb = [NSMutableString stringWithCapacity:0];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [sb appendFormat:@"%@ : %@",propertyName,[self valueForKey:propertyName]];
    }
    free(properties);
    return sb;
}
@end

@implementation NSString(LKisEmpty)
-(BOOL)isEmptyWithTrim
{
    return [[self stringWithTrim] isEqualToString:@""];
}
-(NSString *)stringWithTrim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end

@implementation ZUOYLTempHelper
+(NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
    //    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
+(NSString *)getDirectoryForDocuments:(NSString *)dir
{
    NSError* error;
    NSString* path = [[self getDocumentPath] stringByAppendingPathComponent:dir];
    
    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
    {
        NSLog(@"create dir error: %@",error.debugDescription);
    }
    return path;
}
+ (NSString *)getPathForDocuments:(NSString *)filename
{
    return [[self getDocumentPath] stringByAppendingPathComponent:filename];
}
+(NSString *)getPathForDocuments:(NSString *)filename inDir:(NSString *)dir
{
    return [[self getDirectoryForDocuments:dir] stringByAppendingPathComponent:filename];
}
+(BOOL)isFileExists:(NSString *)filepath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}
@end