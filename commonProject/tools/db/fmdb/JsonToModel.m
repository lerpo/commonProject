//
//  JsonToModel.m
//  Json2ModelDemo
//
//  Created by Cailiang on 14-7-24.
//  Copyright (c) 2014年 Home. All rights reserved.
//

#import "JsonToModel.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, JsonToModelDataType)
{
    JsonToModelDataTypeObject    = 0,
    JsonToModelDataTypeBOOL      = 1,
    JsonToModelDataTypeInteger   = 2,
    JsonToModelDataTypeFloat     = 3,
    JsonToModelDataTypeDouble    = 4,
    JsonToModelDataTypeLong      = 5,
};

@implementation JsonToModel

+ (NSDictionary *)dictionaryFromObject:(id)object
{
    if (object == nil) {
        return nil;
    }
    
    NSMutableDictionary *propertyAndValues = [[NSMutableDictionary alloc] init];
    
    @try {
        NSString *className = NSStringFromClass([object class]);
        id classObject = objc_getClass([className UTF8String]);
        
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(classObject, &count);
        
        for (int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            id propertyValue = nil;
            id valueObject = [object valueForKey:propertyName];
            if ([valueObject isKindOfClass:[NSDictionary class]])
            {
                propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
            } else if ([valueObject isKindOfClass:[NSArray class]])
            {
                propertyValue = [NSArray arrayWithArray:valueObject];
            } else
            {
                propertyValue = [NSString stringWithFormat:@"%@",[object valueForKey:propertyName]];
            }
            
            [propertyAndValues setObject:propertyValue forKey:propertyName];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        return [propertyAndValues copy];
    }
}

+ (NSArray *)propertiesFromObject:(id)object
{
    if (object == nil) {
        return nil;
    }
    
    NSMutableArray *propertiesArray = [[NSMutableArray alloc] init];
    
    @try {
        NSString *className = NSStringFromClass([object class]);
        id classObject = objc_getClass([className UTF8String]);
        
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(classObject, &count);
        
        for (int i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            [propertiesArray addObject:propertyName];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        return [propertiesArray copy];
    }
}

+ (id)objectFromDictionary:(NSDictionary *)dictionary className:(NSString *)name
{
    if (dictionary == nil || name == nil || name.length == 0) {
        return nil;
    }
    
    id object = [[NSClassFromString(name) alloc]init];
    
    @try {
        id classObject = objc_getClass([name UTF8String]);
        
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(classObject, &count);
        Ivar * ivars = class_copyIvarList(classObject, nil);
        
        for (int i = 0; i < count; i ++)
        {
            NSString *memberName = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
            const char *type = ivar_getTypeEncoding(ivars[i]);
            NSString *dataType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
            
//            NSLog(@"Data %@ type: %@",memberName,dataType);
            
            JsonToModelDataType rtype = JsonToModelDataTypeObject;
            if ([dataType hasPrefix:@"c"])
            {
                // BOOL
                rtype = JsonToModelDataTypeBOOL;
            } else if ([dataType hasPrefix:@"i"])
            {
                // int
                rtype = JsonToModelDataTypeInteger;
            } else if ([dataType hasPrefix:@"f"])
            {
                // float
                rtype = JsonToModelDataTypeFloat;
            } else if ([dataType hasPrefix:@"d"])
            {
                // double
                rtype = JsonToModelDataTypeDouble;
            } else if ([dataType hasPrefix:@"l"])
            {
                // long
                rtype = JsonToModelDataTypeLong;
            }
            
            for (int j = 0; j < count; j ++)
            {
                objc_property_t property = properties[j];
                NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                if ([propertyName isEqualToString:@"identity"]) {
                    propertyName = @"id";
                }
                BOOL YESORNO = NO;
                if ([memberName isEqualToString:@"identity"] && [propertyName isEqualToString:@"id"]) {
                    YESORNO = YES;
                }else if ([memberName isEqualToString:propertyName]){
                    YESORNO = YES;
                }
//                NSRange range = [memberName rangeOfString:propertyName];
                if (!YESORNO) {
                    continue;
                } else if (![memberName isEqualToString:propertyName]&&![propertyName isEqualToString:@"id"]) {
                    continue;
                } else {
                    id propertyValue = [dictionary objectForKey:propertyName];
                    if (propertyValue == [NSNull alloc]) {
                        NSLog(@"NULL YES");
                        switch (rtype) {
                            case JsonToModelDataTypeBOOL:
                            {
//                                BOOL temp = [[NSString stringWithFormat:@"%@",propertyValue] boolValue];
                                propertyValue = [NSNumber numberWithBool:NO];
                            }
                                break;
                            case JsonToModelDataTypeInteger:
                            {
//                                int temp = [[NSString stringWithFormat:@"%@",propertyValue] intValue];
                                propertyValue = [NSNumber numberWithInt:0];
                            }
                                break;
                            case JsonToModelDataTypeFloat:
                            {
//                                float temp = [[NSString stringWithFormat:@"%@",propertyValue] floatValue];
                                propertyValue = [NSNumber numberWithFloat:0.0];
                            }
                                break;
                            case JsonToModelDataTypeDouble:
                            {
//                                double temp = [[NSString stringWithFormat:@"%@",propertyValue] doubleValue];
                                propertyValue = [NSNumber numberWithDouble:0.0];
                            }
                                break;
                            case JsonToModelDataTypeLong:
                            {
//                                long long temp = [[NSString stringWithFormat:@"%@",propertyValue] longLongValue];
                                propertyValue = [NSNumber numberWithLongLong:0];
                            }
                            case JsonToModelDataTypeObject:
                                break;
                                
                            default:
                                break;
                        }
                    }else{
                        switch (rtype) {
                            case JsonToModelDataTypeBOOL:
                            {
                                BOOL temp = [[NSString stringWithFormat:@"%@",propertyValue] boolValue];
                                propertyValue = [NSNumber numberWithBool:temp];
                            }
                                break;
                            case JsonToModelDataTypeInteger:
                            {
                                int temp = [[NSString stringWithFormat:@"%@",propertyValue] intValue];
                                propertyValue = [NSNumber numberWithInt:temp];
                            }
                                break;
                            case JsonToModelDataTypeFloat:
                            {
                                float temp = [[NSString stringWithFormat:@"%@",propertyValue] floatValue];
                                propertyValue = [NSNumber numberWithFloat:temp];
                            }
                                break;
                            case JsonToModelDataTypeDouble:
                            {
                                double temp = [[NSString stringWithFormat:@"%@",propertyValue] doubleValue];
                                propertyValue = [NSNumber numberWithDouble:temp];
                            }
                                break;
                            case JsonToModelDataTypeLong:
                            {
                                long long temp = [[NSString stringWithFormat:@"%@",propertyValue] longLongValue];
                                propertyValue = [NSNumber numberWithLongLong:temp];
                            }
                            case JsonToModelDataTypeObject:
                                break;
                                
                            default:
                                break;
                        }
                        if ([propertyName isEqualToString:@"id"]) {
                            [object setValue:propertyValue forKey:@"identity"];
                        }else{
                            [object setValue:propertyValue forKey:memberName];
                        }
                    }
                   
                    
                    break;
                }
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }@finally {
        return object;
    }
}
+ (NSArray *)objectsFromDictionaryArray:(NSArray *)dictionarys className:(NSString *)name{
    NSMutableArray *objecArrays=[[NSMutableArray alloc]initWithCapacity:0];
    for (int j=0; j<[dictionarys count]; j++) {
        NSDictionary *dictionary = [dictionarys objectAtIndex:j];
       [objecArrays addObject:[self objectFromDictionary:dictionary className:name]];
    }
    return objecArrays;
}
/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionaryData:(NSData *)data className:(NSString *)name{
    if (data !=nil) {
        NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *string=[dir objectForKey:@"resultObject"];
        NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        NSArray *objects=[self objectsFromDictionaryArray:arry className:name];
        return objects;

    }else{
        return [[NSArray alloc]init];
    }

}
/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionaryData:(NSData *)data className:(NSString *)name resourceName:(NSString *)resourceName{
    if (data !=nil) {
        NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *string=[dir objectForKey:resourceName];
        NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        NSArray *objects=[self objectsFromDictionaryArray:arry className:name];
        return objects;
        
    }else{
        return [[NSArray alloc]init];
    }
}

/*
 返回值，获取单例
 */
+ (id)objectFromDictionaryData:(NSData *)data className:(NSString *)name{
    if (data !=nil) {
        NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *string=[dir objectForKey:@"resultObject"];
        NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        id object=[self objectFromDictionary:dictionary className:name];
        return object;
        
    }else{
        return nil;
    }
}

/*
 返回值，获取单例
 */
+ (id)objectFromDictionaryDataDefault:(NSData *)data className:(NSString *)name {
    if (data !=nil) {
//        NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSString *string=[dir objectForKey:@"resultObject"];
//        NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        id object=[self objectFromDictionary:dictionary className:name];
        return object;
        
    }else{
        return nil;
    }
}


/*
 返回值，获取单例
 */
+ (id)objectFromDictionaryDataDefault:(NSData *)data translName:(NSString *)translname className:(NSString *)name {
    if (data !=nil) {
        NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableDictionary *string=[dir objectForKey:translname];
        NSLog(@"test :==%@",string);
//        NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
        id object=[self objectFromDictionary:string className:name];
        return object;

    }else{
        return nil;
    }
}

/*
 判断返回值是否成功
 */
+ (BOOL)ifSuccessFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *string=[dir objectForKey:@"resultCode"];
    if ([string isEqualToString:@"0001"]) {
        return YES;
    }else{
        return NO;
    }
}

/*
 获取后台的返回message
 */
+ (NSString *)getMessageFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *string=[dir objectForKey:@"resultMessage"];
    return string;
}
/*
 获取返回的个数
 */
+ (int)getCountFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    int count=[[dir objectForKey:@"totalCount"] intValue];
    return count;
}
/*
 获取返回的个数
 */
+ (int)getScoreFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    int count=[[dir objectForKey:@"score"] intValue];
    return count;
}

/*
 获取返回的个数
 */
+ (int)getScoreFromDictionary:(NSDictionary *)dictionary{
    
    int count=(int)[dictionary objectForKey:@"score"];
    return count;
}
/*
 返回Dictionary
 */
+ (NSDictionary *)getDictionaryFromDictionaryData:(NSData *)data{
     NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dir;
}
/*
 获取json格式的Array
 */
+ (NSArray *)jsonObjectsFromDictionaryData:(NSData *)data{
    NSMutableDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *string=[dir objectForKey:@"resultObject"];
    NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    return arry;
}



/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionary:(NSDictionary *)dictionary className:(NSString *)name{
    NSString *string=[dictionary objectForKey:@"resultObject"];
    NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *objects=[self objectsFromDictionaryArray:arry className:name];
    return objects;
}

/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionary:(NSDictionary *)dictionary className:(NSString *)name resourceName:(NSString *) resourceName{
    NSString *string=[dictionary objectForKey:resourceName];
    NSData *datas=[string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arry=[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *objects=[self objectsFromDictionaryArray:arry className:name];
    return objects;
}

/*
 判断返回值是否成功
 */
+ (BOOL)ifSuccessFromDictionary:(NSDictionary *)dictionary{
    NSString *string=[dictionary objectForKey:@"resultCode"];
    if ([string isEqualToString:@"0001"]) {
        return YES;
    }else{
        return NO;
    }
}

/*
 获取后台的返回message
 */
+ (NSString *)getMessageFromDictionary:(NSDictionary *)dictionary{
    NSString *string=[dictionary objectForKey:@"resultMessage"];
    return string;
}
/*
 获取返回的个数
 */
+ (int)getCountFromDictionary:(NSDictionary *)dictionary{

    int count=(int)[dictionary objectForKey:@"totalCount"];
    return count;
}

//对象转json
+(NSString *)getJsonStringFromOne:(id)obj{
    NSData *jsonData =   [self getJSON:obj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
+(NSString *)getJsonStringFromArray:(NSArray *)array{
    NSMutableString *string = [[NSMutableString alloc]init];
    [string appendString:@"["];
    for (int i=0; i<[array count]; i++) {
        [string appendString:[self getJsonStringFromOne:[array objectAtIndex:i]]];
        if (i< [array count]-1) {
            [string appendString:@","];
        }
    }
    [string appendString:@"]"];
    return string;
}

+ (NSDictionary*)getObjectData:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if(value == nil)
        {
            value = @"";
        }
        else
        {
            value = [self getObjectInternal:value];
//            NSString *namelowser = [self replaceLower:propName];
            NSString *namelowser = propName;

            if ([namelowser isEqualToString:@"identity"]) {
                namelowser  = @"id";
            }
            [dic setObject:value forKey:namelowser];
        }
        
    }
    return dic;
}
+(NSString *)replaceLower:(NSString *)str{
    NSMutableString *ms=[[NSMutableString alloc]init];
    char c[50];
    strcpy(c,(char *)[str UTF8String]);
    
    for (int i = 0; c != nil && i < str.length; i++) {
        if (c[i] < 97 && c[i] > 57) {
            [ms appendFormat:[NSString stringWithFormat:@"_%c",c[i]]];
        } else {
            [ms appendFormat:[NSString stringWithFormat:@"%c",c[i]]];
        }
    }
    
    str=[ms lowercaseString];
    
    return str;
}
+ (void)print:(id)obj
{
    NSLog(@"%@", [self getObjectData:obj]);
}


+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error
{
    return [NSJSONSerialization dataWithJSONObject:[self getObjectData:obj] options:options error:error];
}

+ (id)getObjectInternal:(id)obj
{
    if([obj isKindOfClass:[NSString class]]
       || [obj isKindOfClass:[NSNumber class]]
       || [obj isKindOfClass:[NSNull class]])
    {
        return obj;
    }
    
    if([obj isKindOfClass:[NSArray class]])
    {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for(int i = 0;i < objarr.count; i++)
        {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if([obj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for(NSString *key in objdic.allKeys)
        {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}

@end
