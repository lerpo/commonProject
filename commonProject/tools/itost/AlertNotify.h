//
//  AlertNotify.h
//  commonProject
//
//  Created by JEREI on 15-4-13.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertNotify : UIView
+(void)ShowSuccess:(NSString *)message;
+(void)ShowFaild:(NSString *)message;
+(void)ShowTitle:(NSString *)title withDetail:(NSString *)detail;
+(void)ShowLoading:(NSString *)message forView:(UIView *)view;
+(void)Stoploading;
@end
