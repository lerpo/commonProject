//
//  ViewEvent.h
//  commonProject
//
//  Created by JEREI on 15-4-13.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewEvent : UIView
+(void)setclickListenerOnView:(UIView *)view withCallback:(SEL)callbackmethod withTarget:(UIViewController *)vicontroller;
@end
