//
//  shareTest.m
//  commonProject
//
//  Created by JEREI on 15-4-13.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "shareTest.h"
#import "shareContentsToOtherApps.h"
#import "UIView+UIViewCategory.h"
@interface shareTest ()

@end

@implementation shareTest

- (void)viewDidLoad {
    self.navTiltle = @"分享功能";
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:btn];
    [btn layout_heigth:100];
    [btn layout_width:100];
    [btn layout_verticalCenter];
    [btn layout_horizontalCenter];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 50;
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareclick) forControlEvents:UIControlEventTouchUpInside];
}


-(void)shareclick
{
    [shareContentsToOtherApps share];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
