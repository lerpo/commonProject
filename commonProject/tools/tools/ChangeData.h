//
//  ChangeData.h
//  ViewDeckExample
//
//  Created by apple on 13-2-5.
//  Copyright (c) 2013年 Adriaenssen BVBA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeData : NSObject

/*
 * 图片转换为字符串
 */
+(NSString *) data2String:(NSData *)_data;

/*
 * 字符串转换为图片
 */
+(NSData *) string2Data:(NSString *)_string;

@end
