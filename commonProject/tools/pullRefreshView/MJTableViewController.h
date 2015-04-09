/**
 参数介绍
 @property(nonatomic,strong) UIView *headView;  //头部视图
 @property(nonatomic,strong) UIView *footView;  //尾部视图
 @property(nonatomic,assign) BOOL *isPaging;     //是否分页
 @property(nonatomic,strong) ZUOYLDAOBase *cacheDao; //缓存实体对象
 @property(nonatomic,assign) CGRect frame;
 1 以上参数，赋值则有相应功能不赋值则没有相关功能， 其中分页不需要传递startPage,pageSize 等参数
   只需要设置isPaging 为YES（分页） or NO（不分页） 即可
 2 cacheDao 只要传入相应的dao就会开启缓存功能，不传入任何值则不开启缓存功能。
 
 @request
 @property(nonatomic,assign) float cellHeigth;  //单元格高度
 @property(nonatomic,strong) NSString *requestUrl;//网络请求的路径
 1 此两项是必须配置项
 
使用示例：
 
 //实体化一个下拉刷新列表类
 MJTableViewController ＊tableView = [[MJTableViewController alloc] init];
 tableView.mjTableViewDelegate = self;
 
 //设置下拉列表的宽高大小
 tableView.frame = CGRectMake(0,64, kDeviceWidth, KDeviceHeight-64);
 
 //添加头部视图
 UILabel *topView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth,50)];
 topView.backgroundColor = [UIColor lightGrayColor];
 topView.textColor = [UIColor whiteColor];
 topView.text = @"头部视图";
 topView.font = [UIFont boldSystemFontOfSize:30.0];
 topView.textAlignment = NSTextAlignmentCenter;
 tableView.headView  =topView;
 
 
 //添加尾部视图
 UILabel *tatilView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth,50)];
 tatilView.backgroundColor = [UIColor lightGrayColor];
 tatilView.textColor = [UIColor whiteColor];
 tatilView.text = @"尾部视图";
 tatilView.font = [UIFont boldSystemFontOfSize:30.0];
 tatilView.textAlignment = NSTextAlignmentCenter;
 tableView.footView = tatilView;
 
 //设定单元格的高度
 tableView.cellHeigth = 70;
 
 //1.确定地址nsurl
 NSString *urlString = [NSString stringWithFormat:@"%@%@?",@"http://www.dodojk.com",@"/appbackend/warning/warning_list.jsp"];
 urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 NSString *bodyDatastr = @"company_id=22&user_id=71&health_flg=1&table_name=jk_bp";
 tableView.requestUrl = [NSString stringWithFormat:@"%@%@",urlString,bodyDatastr];
 
 //设定是否分页
 tableView.isPaging = YES;
 
  //设定缓存对象
 FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
 tableView.cacheDao = [[JkHealthyDAO alloc]initWithDbqueue:queue];

 
 
 
 */


#import <UIKit/UIKit.h>
#import "ZUOYLDAOBase.h"
#import "NetWorkOpration.h"
@protocol MJTableViewControllerDelegate <NSObject>

- (UITableViewCell *)tableViewCellInit:(UITableView *)tableView WithIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableViewCellsetDataToself:(UITableViewCell *)tableViewCell WithData:(id)object AndIndexPath:(NSIndexPath *)indexPath;
- (void)tableViewdidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface MJTableViewController : UITableViewController <NetWorkCallbackDelegate>
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
