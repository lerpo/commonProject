//
//  JsonToModel.h
//  Json2ModelDemo
//
//  Created by Cailiang on 14-7-24.
//  Copyright (c) 2014年 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonToModel : NSObject
/*
    单个实体转成dictionary
 */
+ (NSDictionary *)dictionaryFromObject:(id)object;
/*
    获取属性
 */
+ (NSArray *)propertiesFromObject:(id)object;
/*
    单列，一个对象的获取
 */
+ (id)objectFromDictionary:(NSDictionary *)dictionary className:(NSString *)name;
/*
    多例，多个对象的获取
 */
+ (NSArray *)objectsFromDictionaryArray:(NSArray *)dictionarys className:(NSString *)name;






//根据返回Data获取所有值
/*
    返回值，获取多例
 */
+ (NSArray *)objectsFromDictionaryData:(NSData *)data className:(NSString *)name;

/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionaryData:(NSData *)data className:(NSString *)name resourceName:(NSString *) resourceName;
/*
 返回值，获取单例
 */
+ (id)objectFromDictionaryData:(NSData *)data className:(NSString *)name;
/*
    判断返回值是否成功
 */
+ (BOOL)ifSuccessFromDictionaryData:(NSData *)data;

/*
    获取后台的返回message
 */
+ (NSString *)getMessageFromDictionaryData:(NSData *)data;
/*
    获取返回的个数
 */
+ (int)getCountFromDictionaryData:(NSData *)data;
/*
    返回Dictionary
 */
+ (NSDictionary *)getDictionaryFromDictionaryData:(NSData *)data;
/*
    获取json格式的Array
 */
+ (NSArray *)jsonObjectsFromDictionaryData:(NSData *)data;

/*
 返回值，获取单例
 */
+ (id)objectFromDictionaryDataDefault:(NSData *)data className:(NSString *)name;


/*
 返回值，获取单例
 */
+ (id)objectFromDictionaryDataDefault:(NSData *)data translName:(NSString *)translname className:(NSString *)name;


//根据返回Dictionary获取所有值

/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionary:(NSDictionary *)dictionary className:(NSString *)name;
/*
 返回值，获取多例
 */
+ (NSArray *)objectsFromDictionary:(NSDictionary *)dictionary className:(NSString *)name resourceName:(NSString *) resourceName;
/*
 判断返回值是否成功
 */
+ (BOOL)ifSuccessFromDictionary:(NSDictionary *)dictionary;

/*
 获取后台的返回message
 */
+ (NSString *)getMessageFromDictionary:(NSDictionary *)dictionary;
/*
 获取返回的个数
 */
+ (int)getCountFromDictionary:(NSDictionary *)dictionary;

/*
 获取返回的个数
 */
+ (int)getScoreFromDictionary:(NSDictionary *)dictionary;

/*
 获取返回的个数
 */
+ (int)getScoreFromDictionaryData:(NSData *)data;

//对象转json

+ (NSDictionary*)getObjectData:(id)obj;

//将getObjectData方法返回的NSDictionary转化成JSON
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;

//直接通过NSLog输出getObjectData方法返回的NSDictionary
+ (void)print:(id)obj;

+(NSString *)getJsonStringFromOne:(id)obj;
+(NSString *)getJsonStringFromArray:(NSArray *)array;
+(NSString *)replaceLower:(NSString *)str;

@end
