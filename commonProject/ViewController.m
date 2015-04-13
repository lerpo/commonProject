//
//  ViewController.m
//  commonProject
//
//  Created by JEREI on 15-4-2.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "ViewController.h"
#import "ScreenConfig.h"
#import "PullRefreshController.h"
#import "MJTableViewController.h"
#import "UitableFeildViewController.h"
#import "EasyLayout.h"
#import "shareTest.h"
#import "LoadNotyBorder.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    self.navTiltle = @"TEST DEMO";
    self.navisHiddenLeftitle = YES;
    [super viewDidLoad];
    [self initView];
}
- (void)initView
{
    listarray = [NSArray arrayWithObjects:@"下拉刷新",@"UITextField",@"EasyLayout",@"分享测试",@"加载 提示框", nil];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KDeviceHeight, kDeviceWidth)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listarray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSString *CellIdentifer = @"cellIndex";
    UITableViewCell *tableViewcell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if(tableViewcell == nil)
    {
        tableViewcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
    }
    tableViewcell.textLabel.textColor = [UIColor blackColor];
    tableViewcell.textLabel.text = listarray[indexPath.row];
    
    return tableViewcell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[[PullRefreshController alloc] init] animated:YES];
        }
            break;
            
        case 1:
        {
            [self.navigationController pushViewController:[[UitableFeildViewController alloc]init] animated:YES];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[[EasyLayout alloc]init] animated:YES];
        }
            break;
        case 3:
        {
            [self.navigationController pushViewController:[[shareTest alloc]init] animated:YES];
        }
            break;
        case 4:
        {
            [self.navigationController pushViewController:[[LoadNotyBorder alloc]init] animated:YES];
        }
            break;
    }
}
@end
