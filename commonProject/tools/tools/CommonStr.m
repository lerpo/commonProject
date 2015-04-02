//
//  CommStr.m
//  asiastarbus
//
//  通用字符处理工具类
//
//  Created by jerei on 14-8-5.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "CommonStr.h"

@implementation CommonStr

+(BOOL) isEmpty:(NSString*)text
{
    if (text == nil) {
        return YES;
    }
    if ([text length] == 0 ) {
        return YES;
    }
    return NO;
}

+(NSString*) idToString:(id)obj
{
    if ( obj == nil ) {
        return nil;
    }
    
    if ( [obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    if ( [obj isKindOfClass:[NSString class]]) {
        return (NSString*)obj;
    }else if ( [obj isKindOfClass:[NSArray class]] ){
        NSMutableString* ntf = [NSMutableString string];
        for (id t in obj ) {
            [ntf appendString:[self idToString:t]];
            [ntf appendString:@","];
        }
        return ntf;
    }else {
        if( CFGetTypeID((CFTypeRef)obj) == CFBooleanGetTypeID() ){
            return [NSString stringWithFormat:@"%@", (CFBooleanGetValue((CFBooleanRef)obj) == true ? @"true" : @"false") ];
        }
        if ( sizeof(obj) == sizeof(BOOL) ) {
            //return (BOOL)obj == YES ? @"true" : @"false";
        }
        if( [obj respondsToSelector:@selector(stringValue)] ){
            return [obj stringValue];
        }
        return [obj description];
    }
}

+(BOOL) boolValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if ( [bl isKindOfClass:[NSString class]]) {
        NSString* cstr = [bl lowercaseString];
        if ( [cstr isEqualToString:@"yes"] || [cstr isEqualToString:@"true"]) {
            return YES;
        }
        return [cstr boolValue];
    }
    if ( CFBooleanGetValue((CFBooleanRef)bl) ) {
        return YES;
    }
    return NO;
}

+(float) floatValue:(NSDictionary*)dict forKey:(id)key{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return 0.0f;
    }
    return [bl floatValue];
}

+(NSInteger) intValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return 0;
    }
    return [bl integerValue];
}

+(NSString*) stringValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return [self idToString:bl];
}

+(NSArray*) arrayValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ( [bl isKindOfClass:[NSArray class]]) {
        return (NSArray*)bl;
    }
    return nil;
}

+(NSDictionary*) dictionaryValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return (NSDictionary*)bl;
}

+(id) noneNullValue:(NSDictionary*)dict forKey:(id)key
{
    id bl = [dict objectForKey:key];
    if ( bl == nil || [bl isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return bl;
}

+(BOOL) stringEquals:(NSString*)str1 to:(NSString*)str2
{
    if ( str1 == nil || str2 == nil ) {
        return NO;
    }
    return [str1 compare:str2 options:NSCaseInsensitiveSearch] == NSOrderedSame;
}

+(BOOL) caseEquals:(NSString*)str1 to:(NSString*)str2
{
    return (str1 == nil || str2 == nil) ? NO : [str1 isEqualToString:str2];
}

+(BOOL) startWith:(NSString*)prefix forString:(NSString*)text;
{
    if ( text != nil && prefix != nil ){
        if ( [prefix length] > [text length] ) {
            return NO;
        }
        
        NSString* prestr = [text substringToIndex:[prefix length]];
        if ( [self stringEquals:prestr to:prefix] ) {
            return YES;
        }
        
    }
    return NO;
}

+(BOOL) endWith:(NSString*)suffix forString:(NSString*)text
{
    if ( text != nil && suffix != nil ){
        if ( [suffix length] > [text length] ) {
            return NO;
        }
        NSInteger len = [text length] - [suffix length];
        NSString* sufstr = [text substringFromIndex:len];
        if ( [self caseEquals:sufstr to:suffix] ) {
            return YES;
        }
        
    }
    return NO;
}

+(BOOL) isURLString:(NSString*)text
{
    if ( [text length] > 6 ) {
        NSString* prefix = [text substringToIndex:6];
        if ( [self stringEquals:prefix to:@"http:/"] || [self stringEquals:prefix to:@"https:"] ) {
            return YES;
        } else if ( [self stringEquals:prefix to:@"local:" ] ){
            return YES;
        }
    }
    if ( [self startWith:@"/" forString:text] ){
        return YES;
    }
    return NO;
}

+(NSString*) refineUrl:(NSString*)url
{
    return url;
}

+(BOOL)  booleanToBool:(id)bobj
{
    if ( bobj == nil ) {
        return NO;
    }
    if ( [bobj isKindOfClass:[NSString class]] ) {
        return [bobj caseInsensitiveCompare:@"yes"] == 0 || [bobj caseInsensitiveCompare:@"true"] == 0;
    }else if ( [bobj respondsToSelector:@selector(boolValue)] ){
        return [bobj boolValue];
    }else {
        return CFBooleanGetValue((CFBooleanRef)bobj);
    }
    
    return NO;
}

+(NSDate *)stringToDate:(NSString *)string withFormat:(NSString*)fmt{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    //#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")
    NSString* format = fmt == nil ? DEFAULT_DATE_TIME_FORMAT : fmt;
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

+(NSString*) dateToString:(NSDate*)date withFormat:(NSString*)fmt
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    //#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd'T'HH:mm:ss'Z'")
    NSString* format = fmt == nil ? DEFAULT_DATE_FORMAT : fmt;
    [formatter setDateFormat:format];
    NSString* dateStr = [formatter stringFromDate:date];
    return dateStr;
}
/*
//创建MD5
+(NSString *)createMD5:(NSString *)signString
{
    
    const char*cStr =[signString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return[NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ];
     
}
*/
+(NSString *)createPostURL:(NSString *) url_address
{
    return [NSString stringWithFormat:@"%@%@",BASE_URL,url_address];
}

+(NSString *)createPostParams:(NSMutableDictionary *)params
{
    NSString *postString=@"";
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if([postString length]>1)
    {
        postString=[postString substringToIndex:[postString length]-1];
    }
    return postString;
}

//获取当前日期
+(NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

//通过区分字符串
+(BOOL)validateEmail:(NSString*)email
{
    if((0 != [email rangeOfString:@"@"].length) &&
       (0 != [email rangeOfString:@"."].length))
    {
        NSCharacterSet* tmpInvalidCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        NSMutableCharacterSet* tmpInvalidMutableCharSet = [tmpInvalidCharSet mutableCopy] ;
        [tmpInvalidMutableCharSet removeCharactersInString:@"_-"];
        
        
        NSRange range1 = [email rangeOfString:@"@"
                                      options:NSCaseInsensitiveSearch];
        
        //取得用户名部分
        NSString* userNameString = [email substringToIndex:range1.location];
        NSArray* userNameArray   = [userNameString componentsSeparatedByString:@"."];
        
        for(NSString* string in userNameArray)
        {
            NSRange rangeOfInavlidChars = [string rangeOfCharacterFromSet: tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length != 0 || [string isEqualToString:@""])
                return NO;
        }
        
        //取得域名部分
        NSString *domainString = [email substringFromIndex:range1.location+1];
        NSArray *domainArray   = [domainString componentsSeparatedByString:@"."];
        
        for(NSString *string in domainArray)
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:tmpInvalidMutableCharSet];
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        
        return YES;
    }
    else {
        return NO;
    }
}

//利用正则表达式验证邮箱
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//验证是否包含特殊字符(除：_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 以外的字符)
+(BOOL)isValidateString:(NSString *)myString
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange userNameRange = [myString rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        //NSLog(@"包含特殊字符");
        return FALSE;
    }else{
        return TRUE;
    }
    
}

//6位色值转换RGB
+(UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+(NSString *) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+(NSString *)getDateFormLongSince1970:(NSString *)secs{
    long long sec = [secs longLongValue];
//   NSDate *date =  [NSDate dateWithTimeIntervalSinceReferenceDate:sec];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec/1000];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getDetailDateFormLongSince1970:(NSString *)secs{
    long long sec = [secs longLongValue];
    //   NSDate *date =  [NSDate dateWithTimeIntervalSinceReferenceDate:sec];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:sec/1000];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}


+(NSString *)getDateFormDate:(NSDate *)date{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}
@end
