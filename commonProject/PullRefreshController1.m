//
//  PullRefreshController.m
//  commonProject
//
//  Created by JEREI on 15-4-2.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "PullRefreshController1.h"

#import "ScreenConfig.h"
@implementation PullRefreshController1
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initNav];
    
   
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
}
-(void)initNav{
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        //        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"navBack.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,40, 40);//52, 42
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 72, 33)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor orangeColor];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.text=@"下拉刷新";
    
    self.navigationItem.titleView = titleLabel;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *identifier = @"cell";
     cell = (PullRefreshCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[PullRefreshCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.lable = fakeData[indexPath.row];
    
        return cell;
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
