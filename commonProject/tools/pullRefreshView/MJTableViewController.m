//
//  MJTableViewController.m
//  快速集成下拉刷新
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

/*
 具体用法：查看MJRefresh.h
 */
#import "MJTableViewController.h"
#import "MJRefresh.h"
#import "JkHealthy.h"
#import "JsonToModel.h"
#import "commonJudgeMent.h"

#define HEADERREFRESH 1
#define FOOTERREFRESH 2
#define PAGESIZE 10
#define NOOK 1
#define ISOK 2
NSString *const MJTableViewCellIdentifier = @"Cell";

/**
 *  随机数据
 */
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface MJTableViewController ()
{
    NetWorkOpration *networkopration;
}
/**
 *  存放假数据
 */
@property (strong, nonatomic) NSMutableArray *fakeData;
@end

@implementation MJTableViewController

@synthesize frame;
@synthesize mjTableViewDelegate;
@synthesize headView;
@synthesize footView;
@synthesize cellHeigth;
@synthesize requestUrl;
@synthesize isPaging;
@synthesize cacheDao;
#pragma mark - 初始化
/**
 *  数据的懒加载
 */
- (NSMutableArray *)fakeData
{
    if (!_fakeData) {
        self.fakeData = [NSMutableArray array];
        [self sendRequest];
        
    }
    return _fakeData;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
//    [self.fakeData removeAllObjects];
//    [self.tableView reloadData];
}
#pragma mark 网路请求
-(void)sendRequest
{
    if([commonJudgeMent ifConnectNet])
    {
        
        if(netIsOK == NOOK)  //网络如果第一次正常了，先清空缓存
        {
            [self resetTableView];
            netIsOK = ISOK;
        }

    if(getMoreData == NO && (requestUrl != nil  || ![requestUrl isEqualToString:@""]) )
     {
        NSString *requesturl= @"";
        
             if(isPaging)  //如果分页加载的话
        {
            startPage ++;
            requesturl  = [NSString stringWithFormat:@"%@&start_page=%d&is_page=1&page_size=%d",requestUrl,startPage,PAGESIZE];
        }
     else{
          requesturl  =requestUrl;
         }
       
        NSLog(@"requestUrl:%@",requesturl);
         [networkopration sendGetRequestWithUrl:requesturl]; //请求网络
     }
      else
      {
        NSLog(@"没有请求路径");
        [self refreshTableView];
      }
    }
    else
    {
       if(cacheDao != nil)
       {
         NSMutableArray *cachearray = nil;
         [cacheDao searchAll:^(NSArray *array){
            [cachearray addObjectsFromArray: array];
            
         }];
           if(cachearray == nil)
           {
               [self resetTableView];
           }
           else
           {
               netIsOK = NOOK;
               [self resetTableView];  //先清空所有再加载
               [self addObjectTofadeData:cachearray];
               [self resetTableView];
           }
          
       }
      else
       {
         NSLog(@"没有请求路径");
         [self refreshTableView];
       }
    }
    
    
}

//网络返回结果
-(void)netWorkCallbackResult:(NSData *)data
{
    if(data != nil)
    {
        //                   NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //                    NSLog(@"str :%@",str);
        NSArray *objects=[JsonToModel objectsFromDictionaryData:data className:@"JkHealthy"];
        [self addObjectTofadeData:objects];
        [self refreshTableView];
        
    }
    else if(data == nil)
    {
        NSLog(@"接收到空数据");
    }
  

}
-(void)resetTableView
{
    startPage = 0;
    [self.fakeData removeAllObjects];
    [self.tableView reloadData];
    
}
-(void)addObjectTofadeData:(NSArray *)objects
{
    if([objects count]== PAGESIZE)
    {
         getMoreData = NO;
        [self.fakeData addObjectsFromArray:objects];
    }
    if([objects count] < PAGESIZE && [objects count] > 0)
    {
         getMoreData = YES;
        [self.fakeData addObjectsFromArray:objects];
    }
    if([objects count] > 0  && cacheDao != nil) //如果缓存实体不为空则加缓存
    {
        [cacheDao replaceArrayToDB:objects callback:^(BOOL block){
            
        }];
        
    }
    if(objects == nil || [objects count] == 0)
    {
        if([self.fakeData count] > 0)
        {
          getMoreData = YES;
        }
        else
        {
           getMoreData = NO;
        }
    }
    if(!isPaging)  //不是分页就一次性加载
    {
         getMoreData = YES;
        [self.fakeData addObjectsFromArray:objects];
    }
}

- (void)viewDidLoad
{
    
     [super viewDidLoad];
     networkopration = [NetWorkOpration getInstance];
     networkopration.delegate = self;
    
       [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MJTableViewCellIdentifier];
       if(frame.size.height >0 && frame .size.width > 0)
      {
        self.tableView.frame = frame;
      }
      else
      {
           self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
      }
      if(headView != nil)
      {
       self.tableView.tableHeaderView = headView;
      }
      if(footView != nil)
      {
         self.tableView.tableFooterView = footView;
      }
    
    
       // 2.集成刷新控件
       [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
#warning 自动刷新(一进入程序就下拉刷新)
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"刷新中...";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"加载中...";
}
#pragma mark 头部刷新
- (void)headerRereshing
{
      headerOrfooterRefrash = HEADERREFRESH;
     [self sendRequest];
}
#pragma mark 刷新结果回调
- (void)refreshTableView
{
        // 刷新表格
        [self.tableView reloadData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
       switch (headerOrfooterRefrash) {
        case 1:
          {
           [self.tableView headerEndRefreshing];
          }
            break;
            
        case 2:
          {
            [self.tableView footerEndRefreshing];
          }
            break;
    }
}

#pragma mark 底部刷新
- (void)footerRereshing
{
     headerOrfooterRefrash  = FOOTERREFRESH;
     [self sendRequest];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fakeData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      UITableViewCell *cell = [mjTableViewDelegate tableViewCellInit:tableView WithIndexPath:indexPath];
    
      cell = [mjTableViewDelegate tableViewCellsetDataToself:cell WithData:self.fakeData AndIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeigth > 0 ? cellHeigth : 44;
}
@end
