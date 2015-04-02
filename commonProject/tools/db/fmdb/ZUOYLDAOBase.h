//
//  ZUOYLDAOBase.h
//  asiastarbus
//
//  Created by apple on 14-8-14.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

/*
 
1.本类中使用了FMDatabaseQueue，支持多线程操作
 
2.所有的对象中要有identity属性的会以identity属性作为主键
 
3.
 
 */


#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
#import "FMDatabase.h"

#define LKSQLText @"text"
#define LKSQLInt @"integer"
#define LKSQLDouble @"real"
#define LKSQLBlob @"blob"
#define LKSQLNull @"null"
#define LKSQLIntPrimaryKey @"integer primary key"

@interface ZUOYLModelBase : NSObject
@property(strong,nonatomic)NSString* primaryKey;//主键名称 跟据此名称update 和delete
@property int rowid;  //数据库的 rowid
+(NSDictionary*)getPropertys; //换回 该类的所有属性
@end

@interface ZUOYLDAOBase : NSObject

-(id)initWithDbqueue:(FMDatabaseQueue*)queue;
@property(strong,nonatomic)FMDatabaseQueue* bindingQueue;
@property(strong,nonatomic)NSMutableDictionary* propertys;  //绑定的model属性集合
@property(strong,nonatomic)NSMutableArray* columeNames; //列名
@property(strong,nonatomic)NSMutableArray* columeTypes; //列类型

+(const NSString*)getTableName;  //返回表名  所有 Dao 都必须重载此方法
+(Class)getBindingModelClass;    //返回绑定的Model Class

-(void)addColume:(NSString*)name type:(NSString*)type;
-(void)addColumePrimary:(NSString *)name type:(NSString *)type;
-(NSString*)getParameterString;   //返回 create table parameter 语句
-(void)createTable;
-(void)searchAll:(void(^)(NSArray*))callback; //默认返回 15条数据
-(void)searchWhere:(NSString*)where callback:(void(^)(NSArray*))block; //默认返回 15条数据   where 条件 要自己写  比如 where =  @"rowid = 2"
//基本sql语句
-(void)searchWhere:(NSString*)where orderBy:(NSString*)columeName offset:(int)offset count:(int)count callback:(void(^)(NSArray*))block;
//把 model 插入到 数据库
-(void)insertToDB:(ZUOYLModelBase*)model callback:(void(^)(BOOL))block;
-(void)replaceArrayToDB:(NSArray*)array callback:(void (^)(BOOL))block;
-(void)updateToDB:(ZUOYLModelBase*)model callback:(void(^)(BOOL))block;
-(void)deleteToDB:(ZUOYLModelBase*)model callback:(void(^)(BOOL))block;
-(void)isExistsModel:(ZUOYLModelBase*)model callback:(void(^)(BOOL))block;

-(void)deleteToDBcallback:(void (^)(BOOL))block;

+(NSString*)toDBType:(NSString*)type; //把Object-c 类型 转换为sqlite 类型
@end

@interface NSString(LKisEmpty)
-(BOOL)isEmptyWithTrim;
-(NSString*)stringWithTrim;
@end

@interface ZUOYLTempHelper : NSObject
+(NSString*) getDocumentPath;
+(NSString*) getDirectoryForDocuments:(NSString*) dir;
+(NSString*) getPathForDocuments:(NSString*)filename;
+(NSString*) getPathForDocuments:(NSString *)filename inDir:(NSString*)dir;
+(BOOL) isFileExists:(NSString*)filepath;
@end