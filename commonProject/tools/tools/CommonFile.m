//
//  CommonFile.m
//  asiastarbus
//
//  通用文件处理工具类
//
//  Created by jerei on 14-8-6.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "CommonFile.h"

@implementation CommonFile

+(NSString*) settingPath
{
    ////Make a new director
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@".settings"];
    
    BOOL folder = NO;
    BOOL exist = [fileManager fileExistsAtPath:documentsDirectory isDirectory:&folder];
    if ( exist == YES && folder == YES ) {
        return [documentsDirectory stringByAppendingPathComponent:@"measets.ini"];
    }else{
        NSError* error = nil;
        [fileManager createDirectoryAtPath:documentsDirectory
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if( error != nil ){
            NSLog(@"Can not create directory %@.  Error is %@.", documentsDirectory,
                  [error description]);
            return nil;
        }
        return documentsDirectory;
    }
    /***
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectoryPath = [paths objectAtIndex:0];
     NSString *secondaryDirectoryPath = [documentsDirectoryPath stringByAppendingPathComponent:@"secondary"];
     NSString *databaseFile = [secondaryDirectoryPath stringByAppendingPathComponent:@"database.db"];
     
     NSFileManager *fileManager = [NSFileManager defaultManager];
     [fileManager removeItemAtPath:databaseFile error:NULL];
     ***/
}

+(BOOL) fileExist:(NSString*)file
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:file];
}

+(NSString*) fileAtBundleResource:(NSString*)file
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:file];
}

+(BOOL) fileExistAtCache:(NSString*)file
{
    return [self fileExist:[self cachedFile:file]];
}

+(NSString*) cachedFile:(NSString*)file
{
    NSString* fileAtCache = [NSString stringWithFormat:@"%@%@",[self cachePath], file];
    return fileAtCache;
}

+(BOOL) writeToFile:(NSString*)fileWithPath withData:(NSData*)data
{
    BOOL folder = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString* fileName = [fileWithPath lastPathComponent];
    NSInteger toIndex = [fileWithPath length] - [fileName length];
    NSString* path = [fileWithPath substringToIndex:toIndex];
    BOOL exist = [fileManager fileExistsAtPath:path isDirectory:&folder];
    if (  exist != YES ) {
        NSError* error = nil;
        [fileManager createDirectoryAtPath:path
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if( error != nil ){
            NSLog(@"Can not create directory %@.  Error is %@.", path,
                  [error description]);
            return NO;
        }
    }
    if ( data != nil ) {
        return [data writeToFile:fileWithPath atomically:YES];
    }
    return NO;
}

+(NSString*) documentPathWith:(NSString*)cmp
{
    ////Make a new director
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:cmp];
    
    BOOL folder = NO;
    BOOL exist = [fileManager fileExistsAtPath:documentsDirectory isDirectory:&folder];
    if (  exist == YES && folder == YES ) {
        return documentsDirectory;
    }else{
        NSError* error = nil;
        [fileManager createDirectoryAtPath:documentsDirectory
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if( error != nil ){
            NSLog(@"Can not create directory %@.  Error is %@.", documentsDirectory,
                  [error description]);
            return nil;
        }
        return documentsDirectory;
    }
}

+(NSString*) cachePath
{
    ////Make a new director
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@".caches"];
    
    BOOL folder = NO;
    BOOL exist = [fileManager fileExistsAtPath:documentsDirectory isDirectory:&folder];
    if (  exist == YES && folder == YES ) {
        return documentsDirectory;
    }else{
        NSError* error = nil;
        [fileManager createDirectoryAtPath:documentsDirectory
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if( error != nil ){
            NSLog(@"Can not create directory %@.  Error is %@.", documentsDirectory,
                  [error description]);
            return nil;
        }
        return [documentsDirectory stringByAppendingPathComponent:@"measets.ini"];
    }
}

+(BOOL)deleteFile:(NSString*)fileWithPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    BOOL ret = [fileManager removeItemAtPath:fileWithPath error:&error];
    if ( error != nil ) {
        NSLog(@"DeleteFile with an error: %@.", [error description]);
    }
    return ret;
}

+(BOOL) clearCache:(NSError**)error
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@".caches"];
    [fileManager removeItemAtPath:documentsDirectory error:error];
    return YES;
}


@end
