//
//  CommonFile.h
//  asiastarbus
//
//  通用文件处理工具类
//
//  Created by jerei on 14-8-6.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFile : NSObject

+(NSString*) settingPath;

+(NSString*) cachePath;

+(BOOL) clearCache:(NSError**)error;

+(NSString*) fileAtBundleResource:(NSString*)file;

+(BOOL) fileExist:(NSString*)file;

+(BOOL) fileExistAtCache:(NSString*)file;

+(NSString*) cachedFile:(NSString*)file;

+(BOOL) writeToFile:(NSString*)fileWithPath withData:(NSData*)data;

+(BOOL)deleteFile:(NSString*)fileWithPath;

+(NSString*) documentPathWith:(NSString*)cmp;

@end
