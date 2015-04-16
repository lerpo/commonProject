/**
 //图片轮显使用说明：
 
  ImageReScrollView *scrollView = [[ImageReScrollView alloc] init];
  scrollView.frame = CGRectMake(0, 100, 300, 200);
  scrollView.imageLoadUrl = @"http://www.meiyibaby.cn/appbackend/home/banner.jsp?sid=25";
  [scrollView initPostView];
  [self.view addSubview:scrollView.view];
 
   @property(nonatomic,assign) CGRect frame;          //轮显框大小及位置
   @property(nonatomic,strong) NSString *imageLoadUrl;//轮显图片路径
 */
#import <UIKit/UIKit.h>
#import "WcmCmsPicRound.h"
#import "NetWorkOpration.h"


@interface ImageReScrollView : UIViewController<UIScrollViewDelegate,NetWorkCallbackDelegate>{
    
    BOOL pcIsChange;
    BOOL getposition;
    int newsCount;
    NSTimer *timer;
    int page;
    CGRect frame;
    NSString *imageLoadUrl;
    UIScrollView *scrollViews;
    NSMutableArray *postArray;
    UIPageControl *pageControl;
}

@property(nonatomic,assign) CGRect frame;
@property(nonatomic,strong) NSString *imageLoadUrl;
-(void)initPostView;
@end