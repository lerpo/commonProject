//
//  AlertNotify.m
//  commonProject
//
//  Created by JEREI on 15-4-13.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "AlertNotify.h"
#import "TAlertView.h"
#import "DejalActivityView.h"
@implementation AlertNotify

#pragma mark 操作成功
+(void)ShowSuccess:(NSString *)message
{
    NSString *alertmessage = @"";
    if(message != nil || ![message isEqualToString:@""])
    {
        alertmessage = message;
    }
    else
    {
        alertmessage = @"操作成功";
    }

    TAlertView *alert = [[TAlertView alloc] initWithTitle:@"√" andMessage:alertmessage];
    alert.timeToClose = 1;
    alert.titleFont = [UIFont boldSystemFontOfSize:25.0];
    alert.buttonsAlign = TAlertViewButtonsAlignHorizontal;
    alert.alertBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    alert.style = TAlertViewStyleSuccess;
    [alert showAsMessage];
}

#pragma mark 操作失败
+(void)ShowFaild:(NSString *)message
{
    NSString *alertmessage = @"";
    if(message != nil || ![message isEqualToString:@""])
    {
        alertmessage = message;
    }
    else
    {
        alertmessage = @"操作失败";
    }
    TAlertView *alert = [[TAlertView alloc] initWithTitle:@"X" andMessage:alertmessage];
    alert.timeToClose = 1;
    alert.titleFont = [UIFont boldSystemFontOfSize:25.0];
    alert.buttonsAlign = TAlertViewButtonsAlignHorizontal;
    alert.alertBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    alert.style = TAlertViewStyleError;
    [alert showAsMessage];
}
+(void)ShowTitle:(NSString *)title withDetail:(NSString *)detail
{
    TAlertView *alert = [[TAlertView alloc] initWithTitle:title andMessage:detail];
    alert.timeToClose = 2;
    alert.titleFont = [UIFont boldSystemFontOfSize:20.0];
    alert.buttonsAlign = TAlertViewButtonsAlignHorizontal;
    alert.alertBackgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    alert.style = TAlertViewStyleInformation;
    [alert showAsMessage];

}

+(void)ShowLoading:(NSString *)message forView:(UIView *)view
{
   [DejalBezelActivityView activityViewForView:view withLabel:message width:100];
    
}
+(void)Stoploading
{
   [DejalKeyboardActivityView removeViewAnimated:YES];
}



@end
