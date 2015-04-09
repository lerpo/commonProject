//
//  CommStr.h
//  asiastarbus
//
//  通用字符处理工具类
//
//  Created by jerei on 14-8-5.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#define DEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")

#define DEFAULT_DATE_FORMAT (@"yyyy-MM-dd")

#define DEFAULT_TIME_FORMAT (@"HH:mm:ss'Z'")


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonStr : NSObject

+(BOOL) isEmpty:(NSString*)text;

+(BOOL) boolValue:(NSDictionary*)dict forKey:(id)key;

+(float) floatValue:(NSDictionary*)dict forKey:(id)key;

+(NSInteger) intValue:(NSDictionary*)dict forKey:(id)key;

+(NSString*) stringValue:(NSDictionary*)dict forKey:(id)key;

+(NSArray*) arrayValue:(NSDictionary*)dict forKey:(id)key;

+(id) noneNullValue:(NSDictionary*)dict forKey:(id)key;

+(NSDictionary*) dictionaryValue:(NSDictionary*)dict forKey:(id)key;

+(BOOL) stringEquals:(NSString*)str1 to:(NSString*)str2;

+(BOOL) caseEquals:(NSString*)str1 to:(NSString*)str2;

+(NSString*) refineUrl:(NSString*)url;

+(BOOL) isURLString:(NSString*)text;

+(BOOL) startWith:(NSString*)prefix forString:(NSString*)text;

+(BOOL) endWith:(NSString*)suffix forString:(NSString*)text;

+(NSDate *)stringToDate:(NSString *)string withFormat:(NSString*)fmt;

+(NSString*) dateToString:(NSDate*)date withFormat:(NSString*)fmt;

+(NSString*) idToString:(id)obj;

+(BOOL)  booleanToBool:(id)bobj;

+(NSString *)createMD5:(NSString *)signString;

+(NSString *)createPostURL:(NSString *) url_address;

+(NSString *)createPostParams:(NSMutableDictionary *)params;

+(NSString *)getCurrentDate;

+(BOOL)validateEmail:(NSString*)email;

+(BOOL)isValidateEmail:(NSString *)email;

+(BOOL)isValidateString:(NSString *)myString;

+(UIColor *) colorWithHexString: (NSString *) stringToConvert;

+(NSString *) uuid;

+(NSString *)getDateFormLongSince1970:(NSString *)secs;//获取number ms以前的时间

+(NSString *)getDetailDateFormLongSince1970:(NSString *)secs;

+(NSString *)getDateFormDate:(NSDate *)date;
@end
