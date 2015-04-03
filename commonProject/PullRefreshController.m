//
//  PullRefreshController.m
//  commonProject
//
//  Created by JEREI on 15-4-2.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "PullRefreshController.h"
#import "commonAction.h"
#import "ScreenConfig.h"
#import "JkHealthy.h"
@implementation PullRefreshController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initNav];
     tableView = [[MJTableViewController alloc] init];
     tableView.mjTableViewDelegate = self;
     tableView.frame = CGRectMake(0,64, kDeviceWidth, KDeviceHeight-64);
    UILabel *topView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth,50)];
    topView.backgroundColor = [UIColor lightGrayColor];
    topView.textColor = [UIColor whiteColor];
    topView.text = @"头部视图";
    topView.font = [UIFont boldSystemFontOfSize:30.0];
    topView.textAlignment = NSTextAlignmentCenter;
    
    UILabel *tatilView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth,50)];
    tatilView.backgroundColor = [UIColor lightGrayColor];
    tatilView.textColor = [UIColor whiteColor];
    tatilView.text = @"尾部视图";
    tatilView.font = [UIFont boldSystemFontOfSize:30.0];
    tatilView.textAlignment = NSTextAlignmentCenter;

    tableView.headView  =topView;
    tableView.footView = tatilView;
    tableView.cellHeigth = 70;
    
    //1.确定地址nsurl
    NSString *urlString = [NSString stringWithFormat:@"%@%@?",@"http://www.dodojk.com",@"/appbackend/warning/warning_list.jsp"];
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *bodyDatastr = @"company_id=22&user_id=71&health_flg=1&table_name=jk_bp";
    tableView.requestUrl = [NSString stringWithFormat:@"%@%@",urlString,bodyDatastr];
    tableView.isPaging = YES;
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
    tableView.cacheDao = [[JkHealthyDAO alloc]initWithDbqueue:queue];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [tableView headerBeginRefreshing];
    [self.view addSubview:tableView.view];
    
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
- (UITableViewCell *)tableViewCellInit:(UITableView *)uitableview WithIndexPath:(NSIndexPath *)indexPath
{
     NSString *MJTableViewCellIdentifier = @"Cell";
      cell = (PullRefreshCell *)[uitableview dequeueReusableCellWithIdentifier:MJTableViewCellIdentifier];
//    if(cell == nil)
//    {
        cell = [[PullRefreshCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MJTableViewCellIdentifier];
//    }
    return cell;

}

- (UITableViewCell *)tableViewCellsetDataToself:(UITableViewCell *)tableViewCell WithData:(id)object AndIndexPath:(NSIndexPath *)indexPath
{
    multiblearray = object;
    JkHealthy *jkhealth = (JkHealthy *)object[indexPath.row];
    PullRefreshCell *cell1 = (PullRefreshCell *)tableViewCell;
    cell1.lable.text = [NSString stringWithFormat:@"%d:%@",jkhealth.identity,jkhealth.catResult];
    cell1.pulltablecelldelegate = self;
    cell1.lable.tag = indexPath.row;
    return cell1;
}
- (void)pulltableViewcellclicked:(UIView *)sender
{
    UILabel *lable = (UILabel *)sender;
    NSLog(@"%ld",lable.tag);
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
