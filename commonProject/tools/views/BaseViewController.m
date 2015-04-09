//
//  BaseViewController.m
//  commonProject
//
//  Created by JEREI on 15-4-8.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize navisHiddenLeftitle;
@synthesize navTiltle;
@synthesize navrigthTitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigatorHeadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 初始化头部导航标题
-(void)initNavigatorHeadView{
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        //        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    }
    if(navisHiddenLeftitle == NO)
    {
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"navBack.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,40, 40);//52, 4
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    }
    
    if(![navTiltle isEqualToString:@""] || navTiltle != nil)
    {
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 72, 33)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor orangeColor];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.text=navTiltle;
    self.navigationItem.titleView = titleLabel;
    }
    
    
    if(![navrigthTitle isEqualToString:@""] || navrigthTitle != nil)
    {
    UIButton *rigthBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rigthBtn setImage:[UIImage imageNamed:@"navBack.png"] forState:UIControlStateNormal];
    [rigthBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [rigthBtn setTitle:navrigthTitle forState:UIControlStateNormal];
    [rigthBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    rigthBtn.frame=CGRectMake(0, 0,40, 40);//52, 42
    UIBarButtonItem *rigthButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
    self.navigationItem.rightBarButtonItem = rigthButtonItem;
    }

    
}

#pragma mark 返回
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
