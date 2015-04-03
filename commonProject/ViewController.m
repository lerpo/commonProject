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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initView];
}
- (void)initView
{
    listarray = [NSArray arrayWithObjects:@"下拉刷新", nil];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KDeviceHeight, kDeviceWidth)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initNav{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tb_navbar.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    }
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"navBack.png"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@" " forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0,40, 40);//52, 42
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 72, 33)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor orangeColor];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.text=@"奶粉汇";

    self.navigationItem.titleView = titleLabel;
   
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
            
        default:
            break;
    }
}
@end
