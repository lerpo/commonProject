 //
//  MJTableViewController.h
//  快速集成下拉刷新
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
#import "ZUOYLDAOBase.h"
@protocol MJTableViewControllerDelegate <NSObject>

- (UITableViewCell *)tableViewCellInit:(UITableView *)tableView WithIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableViewCellsetDataToself:(UITableViewCell *)tableViewCell WithData:(id)object AndIndexPath:(NSIndexPath *)indexPath;
- (void)tableViewdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface MJTableViewController : UITableViewController
{
    NSMutableArray *fakeData;
    int headerOrfooterRefrash;
    int startPage;
    BOOL getMoreData;
    int netIsOK;
}

- (void)setupRefresh;
- (void)headerRereshing;

@property(nonatomic,assign) CGRect frame;
@property(nonatomic,strong) id<MJTableViewControllerDelegate> mjTableViewDelegate;
@property(nonatomic,strong) UIView *headView;  //头部视图
@property(nonatomic,strong) UIView *footView;  //尾部视图
@property(nonatomic,assign) float cellHeigth;  //单元格高度
@property(nonatomic,strong) NSString *requestUrl;//网络请求的路径
@property(nonatomic,assign) BOOL *isPaging;     //是否分页
@property(nonatomic,strong) ZUOYLDAOBase *cacheDao; //缓存实体对象

@end
