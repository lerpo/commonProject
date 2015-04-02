//
//  commonAction.m
//  asiastarbus
//
//  Created by apple on 14-8-20.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "commonAction.h"
#import "iToast.h"
@implementation commonAction
+ (void)showToast:(NSString *)contents
{
    iToast *toast = [iToast makeToast:contents];
    [toast setToastPosition:kToastPositionBottom];
    [toast setToastDuration:kToastDurationNormal];
    [toast show];
}
@end
