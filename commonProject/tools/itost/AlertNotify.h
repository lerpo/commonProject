//
//  AlertNotify.h
//  commonProject
//
//  Created by JEREI on 15-4-13.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertNotify : UIView
+(void)ShowSuccess:(NSString *)message;   //成功消息提示
+(void)ShowFaild:(NSString *)message;     //失败消息提示
+(void)ShowTitle:(NSString *)title withDetail:(NSString *)detail;  //详细提醒信息提示
+(void)ShowLoading:(NSString *)message forView:(UIView *)view;     //加载进度信息提示
+(void)Stoploading;  //停止加载
@end
