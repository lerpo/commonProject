//
//  LoadNotyBorder.m
//  commonProject
//
//  Created by JEREI on 15-4-13.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "LoadNotyBorder.h"
#import "TAlertView.h"
#import "ViewEvent.h"
#import "UIView+UIViewCategory.h"
#import "AlertNotify.h"
@interface LoadNotyBorder ()

@end

@implementation LoadNotyBorder

- (void)viewDidLoad {
     self.navTiltle=  @"加载框，提示框等..功能";
    [super viewDidLoad];
    UILabel *lable = [[UILabel alloc] init];
    [self.view addSubview:lable];
    [lable layout_heigth:40];
    [lable layout_width:200];
    [lable layout_horizontalCenter];
    [lable margin_top:74];
    lable.backgroundColor = [UIColor yellowColor];
    lable.textColor = [UIColor purpleColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.layer.masksToBounds = YES;
    lable.layer.cornerRadius = 10.0;
    lable.text = @"操作成功";
    lable.userInteractionEnabled = YES;
    [ViewEvent setclickListenerOnView:lable withCallback:@selector(click) withTarget:self];
    
    UILabel *lable2 = [[UILabel alloc] init];
    [self.view addSubview:lable2];
    [lable2 layout_heigth:40];
    [lable2 layout_width:200];
    [lable2 tobottomView:lable ofPix:5.0];
    [lable2 alignleftwithview:lable];
    lable2.backgroundColor = [UIColor yellowColor];
    lable2.textColor = [UIColor purpleColor];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.layer.masksToBounds = YES;
    lable2.layer.cornerRadius = 10.0;
    lable2.text = @"操作失败";
    lable2.userInteractionEnabled = YES;
    [ViewEvent setclickListenerOnView:lable2 withCallback:@selector(click2) withTarget:self];
    
    
    UILabel *lable3 = [[UILabel alloc] init];
    [self.view addSubview:lable3];
    [lable3 layout_heigth:40];
    [lable3 layout_width:200];
    [lable3 tobottomView:lable2 ofPix:5.0];
    [lable3 alignleftwithview:lable2];
    lable3.backgroundColor = [UIColor yellowColor];
    lable3.textColor = [UIColor purpleColor];
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.layer.masksToBounds = YES;
    lable3.layer.cornerRadius = 10.0;
    lable3.text = @"普通提示";
    lable3.userInteractionEnabled = YES;
    [ViewEvent setclickListenerOnView:lable3 withCallback:@selector(click3) withTarget:self];
    
    UILabel *lable4 = [[UILabel alloc] init];
    [self.view addSubview:lable4];
    [lable4 layout_heigth:40];
    [lable4 layout_width:200];
    [lable4 tobottomView:lable3 ofPix:5.0];
    [lable4 alignleftwithview:lable3];
    lable4.backgroundColor = [UIColor yellowColor];
    lable4.textColor = [UIColor purpleColor];
    lable4.textAlignment = NSTextAlignmentCenter;
    lable4.layer.masksToBounds = YES;
    lable4.layer.cornerRadius = 10.0;
    lable4.text = @"加载进度提示";
    lable4.userInteractionEnabled = YES;
    [ViewEvent setclickListenerOnView:lable4 withCallback:@selector(click4) withTarget:self];
    
   

}

-(void)click
{
    [AlertNotify ShowSuccess:@"操作成功"];
}

-(void)click2
{
    [AlertNotify ShowFaild:@"操作失败"];
}
-(void)click3
{
    [AlertNotify ShowTitle:@"温馨提醒" withDetail:@"您的余额不足，请充值！"];
}
-(void)click4
{
    [AlertNotify ShowLoading:@"加载中..." forView:self.view];
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(click5) userInfo:nil repeats:NO];
   [[NSRunLoop  currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}
-(void)click5
{
    [AlertNotify Stoploading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
