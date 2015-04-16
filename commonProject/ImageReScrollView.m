//
//  firstTop.m
//  ViewDeckExample
//
//  Created by apple on 14-2-24.
//  Copyright (c) 2014年 Adriaenssen BVBA. All rights reserved.
//

#import "ImageReScrollView.h"
#import "SDImageView+SDWebCache.h"
#import "commonAction.h"
#import "commonJudgeMent.h"
#import "ScreenConfig.h"
#import "JsonToModel.h"
#import "WcmCmsPicRound.h"
#import <SystemConfiguration/SystemConfiguration.h>
#define HeightOfPic 120
@interface ImageReScrollView ()

@property(nonatomic,retain) NSRunLoop *actionLoop;
@property(nonatomic,assign) BOOL doSthLoop;

@end
@implementation ImageReScrollView

@synthesize frame;
@synthesize imageLoadUrl;
#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    postArray=[[NSMutableArray alloc]initWithCapacity:0];
    
}

-(void)initTopView{
    UIImageView *backImage=[[UIImageView alloc]initWithFrame:frame];
    backImage.image=[UIImage imageNamed:@"default_img_middle.png"];
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    backImage.clipsToBounds = YES;
    [self.view addSubview:backImage];
    scrollViews=[[UIScrollView alloc]initWithFrame:frame];
    scrollViews.delegate=self;
    scrollViews.pagingEnabled=YES;
    scrollViews.backgroundColor=[UIColor clearColor];
    scrollViews.showsVerticalScrollIndicator=NO;
    scrollViews.showsHorizontalScrollIndicator=NO;
    [scrollViews setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:scrollViews];
    [self initScrollView];
    
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(frame.origin.x, frame.size.height-30+frame.origin.y, frame.size.width, 30)];
    [pageControl setHidesForSinglePage:YES];
    [pageControl setPageIndicatorTintColor:[UIColor whiteColor]];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    int count;
    count = [postArray count];
    pageControl.numberOfPages=count;
    [self.view addSubview:pageControl];
    [self addTimer];
}

-(void)loadImages{
    @autoreleasepool {
        if ([postArray count]>0) {
            for (int i=0; i<[postArray count]; i++) {
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
                WcmCmsPicRound *news=[postArray objectAtIndex:i];
                if ([news.img hasPrefix:@"http"]) {
                    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",news.img]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"default_img_middle.png"]];
                }else{
                    [imageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://www.meiyibaby.cn",news.img]] refreshCache:NO placeholderImage:[UIImage imageNamed:@"default_img_middle.png"]];
                }
                imageView.userInteractionEnabled=YES;
                imageView.backgroundColor=[UIColor clearColor];
                imageView.clipsToBounds=YES;
                imageView.contentMode=UIViewContentModeScaleAspectFill;
                
                [scrollViews addSubview:imageView];
            }
            [scrollViews setContentSize:CGSizeMake([postArray count]*frame.size.width, frame.size.height)];
            page = 0;
        }
    }
}


-(void)initScrollView{
    [NSThread detachNewThreadSelector:@selector(loadImages) toTarget:self withObject:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==100101) {
        if (pcIsChange) {
            return;
        }
        CGFloat pageWidth=scrollView.frame.size.width;
        int page2=floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1;
        pageControl.currentPage=page2;
       
    }else{
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    pcIsChange=NO;
}

-(void)changePage:(id)sender{
    CGRect frame1=scrollViews.frame;
    frame1.origin.x=frame1.size.width*pageControl.currentPage;
    frame1.origin.y=0;
    [scrollViews scrollRectToVisible:frame1 animated:YES];
    pcIsChange=YES;
}

-(void)initPostView{
    NetWorkOpration *netWorkOpration = [NetWorkOpration getInstance];
    netWorkOpration.delegate = self;
    [netWorkOpration sendGetRequestWithUrl:imageLoadUrl];
    
//    if ([commonJudgeMent ifConnectNet]){
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,URL_BANNER]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
//        [request setHTTPMethod:@"POST"];
//        //        举例：BASEURL//saleout/saleout_list.jsp?sid=10&longitude=0&latitude=0&distance=26400&page_size=2&start_page=1&is_page=1
//        NSString *str;
//        str =[NSString stringWithFormat:@"sid=%d",PROJECTSID];//设置参数
//        
//        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//        [request setHTTPBody:data];
//        //第二步，连接服务器
//        connection1 = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//    }else{
//        [self initDBData];
//        [commonAction showToast:NONETWORK];
//    }
}

//-(void)initDBData{
//    @autoreleasepool {
//        FMDatabaseQueue *queue=[[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
//        WcmCmsPicRoundDAO *dao=[[WcmCmsPicRoundDAO alloc]initWithDbqueue:queue];
//        [dao searchWhere:@"1=1"orderBy:@"identity desc" offset:0 count:PAGESIZE callback:^(NSArray *array) {
//            self.postArray =(NSMutableArray *)array;
//        }];
//        [self initTopView];
//    }
//}

//数据传完之后调用此方法
-(void)netWorkCallbackResult:(NSData *)data
{
   
        NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",receiveStr);
        NSArray *objects=[JsonToModel objectsFromDictionaryData:data className:@"WcmCmsPicRound"];
//        FMDatabaseQueue *queue = [[FMDatabaseQueue alloc]initWithPath:[ZUOYLTempHelper getPathForDocuments:@"asiastarbus.db" inDir:@"db"]];
//        WcmCmsPicRoundDAO* dao = [[WcmCmsPicRoundDAO alloc]initWithDbqueue:queue];
//        @autoreleasepool {
//            [dao deleteToDBcallback:^(BOOL block){
//            }];
//        }
//        @autoreleasepool {
//            [dao replaceArrayToDB:objects callback:^(BOOL block){
//            }];
//        }
        postArray =(NSMutableArray *)objects;
        //排序
//        NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"orderno" ascending:NO];
//        [self.postArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
        [self initTopView];
    
    
}


/**
 *  开启定时器
 */
-(void)addTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  关闭定时器
 */
-(void)removeTimer{
    [timer invalidate];
}

-(void)nextPage {
    if (pageControl.currentPage==postArray.count-1) {
        pageControl.currentPage=0;
    }else {
        pageControl.currentPage++;
    }
    [self changePage:nil];
}

@end
