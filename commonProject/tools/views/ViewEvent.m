//
//  ViewEvent.m
//  commonProject
//
//  Created by JEREI on 15-4-13.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "ViewEvent.h"

@implementation ViewEvent

+(void)setclickListenerOnView:(UIView *)view withCallback:(SEL)callbackmethod withTarget:(UIViewController *)vicontroller
{
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc] initWithTarget:vicontroller action:callbackmethod];
    [view addGestureRecognizer:tapGestureTel];

}
@end
