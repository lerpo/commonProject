//
//  AspactAcrollViewViewController.m
//  commonProject
//
//  Created by JEREI on 15-4-23.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "AspactAcrollViewViewController.h"
#import "UIView+UIViewCategory.h"
#import "ScreenConfig.h"

#define ALLBTN 0
#define LUNDIBTN 1
#define DELUZIBTN 2
#define DEKUIBEIERBTN 3

@interface AspactAcrollViewViewController ()
{
    UIButton *view1;
    UIButton *view2;
    UIButton *view3;
    UIButton *view4;
    NSArray *topViewgroup;
    NSArray *
    
}
@end

@implementation AspactAcrollViewViewController

- (void)viewDidLoad {
     self.navTiltle= @"滑动选项卡";
    [super viewDidLoad];
    
    UIView *topView = [[UIView alloc] init];  // 
    [topView layout_heigth:40];
    [topView layout_width:kDeviceWidth];
    [topView margin_top:74];
    [self.view addSubview:topView];
    
     view1 = [[UIButton alloc] init];
    [view1 layout_width:kDeviceWidth/4];
    [view1 layout_heigth:30];
    [view1 setTitle:@"view1" forState:UIControlStateNormal];
    [view1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view1 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    view1.tag = ALLBTN;
    [view1 addTarget:self action:@selector(toubuttonsTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    view2 = [[UIButton alloc] init];
    [view2 layout_width:kDeviceWidth/4];
    [view2 layout_heigth:30];
    [view2 setTitle:@"view2" forState:UIControlStateNormal];
    [view2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view2 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [view2 torigthView:view1 ofPix:0];
    [view2 aligntopwithview:view1];
    view2.tag = LUNDIBTN;
    [view2 addTarget:self action:@selector(toubuttonsTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    view3 = [[UIButton alloc] init];
    [view3 layout_width:kDeviceWidth/4];
    [view3 layout_heigth:30];
    [view3 setTitle:@"view3" forState:UIControlStateNormal];
    [view3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view3 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [view3 torigthView:view2 ofPix:0];
    [view3 aligntopwithview:view2];
    view3.tag = DELUZIBTN;
    [view3 addTarget:self action:@selector(toubuttonsTouch:) forControlEvents:UIControlEventTouchUpInside];
    
     view4= [[UIButton alloc] init];
    [view4 layout_width:kDeviceWidth/4];
    [view4 layout_heigth:30];
    [view4 setTitle:@"view4" forState:UIControlStateNormal];
    [view4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view4 setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [view4 torigthView:view3 ofPix:0];
    [view4 aligntopwithview:view3];
     view4.tag = DEKUIBEIERBTN;
    [view4 addTarget:self action:@selector(toubuttonsTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:view1];
    [topView addSubview:view2];
    [topView addSubview:view3];
    [topView addSubview:view4];
    topView.userInteractionEnabled = YES;
    
    apsScrollView = [[APScrollView alloc]init];
    if (DeviceVersion>=7.0) {
        [apsScrollView layout_heigth:KDeviceHeight-topView.frame.size.height];
        [apsScrollView layout_width:kDeviceWidth];
        [apsScrollView tobottomView:topView ofPix:10];
//        apsScrollView.frame = CGRectMake(0, 120, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-92.5);
    }else{
        apsScrollView.frame = CGRectMake(0, 40, kDeviceWidth, [[UIScreen mainScreen] bounds].size.height-92.5);
    }
    apsScrollView.contentSize = CGSizeMake(kDeviceWidth * 4, [[UIScreen mainScreen] bounds].size.height-93);
    apsScrollView.pagingEnabled = YES;
    apsScrollView.delegate1=self;
    apsScrollView.delegate=self;
    apsScrollView.isSecond=1;
    apsScrollView.showsHorizontalScrollIndicator=NO;
    
    
    UIView *uiview1 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth*0, 0, kDeviceWidth, KDeviceHeight)];
    uiview1.backgroundColor = [UIColor brownColor];
    
    UIView *uiview2 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth*1, 0, kDeviceWidth, KDeviceHeight)];
    uiview2.backgroundColor = [UIColor blueColor];

    UIView *uiview3 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth*2, 0, kDeviceWidth, KDeviceHeight)];
    uiview3.backgroundColor = [UIColor purpleColor];

    UIView *uiview4 = [[UIView alloc] initWithFrame:CGRectMake(kDeviceWidth*3, 0, kDeviceWidth, KDeviceHeight)];
    uiview4.backgroundColor = [UIColor lightGrayColor];

    
    
    [apsScrollView addSubview:uiview1];
    [apsScrollView addSubview:uiview2];
    [apsScrollView addSubview:uiview3];
    [apsScrollView addSubview:uiview4];
    [apsScrollView setContentOffset:CGPointMake(kDeviceWidth*0, 0) animated:YES];
    [self.view addSubview:apsScrollView];
    
}

-(void)toubuttonsTouch:(id)sender{  //此处最容易忘记的就是 setContentOffset的位置
    apsScrollView.isSecond=0;
    UIButton *button=(UIButton *)sender;
    int tag=button.tag;
    switch (tag) {
        case ALLBTN:
        {
            view1.selected=YES;
            view2.selected=NO;
            view3.selected=NO;
            view4.selected=NO;
            
            [apsScrollView setContentOffset:CGPointMake(kDeviceWidth*0, 0) animated:YES];
        }
            break;
        case LUNDIBTN:
        {
            
            
            view1.selected=NO;
            view2.selected=YES;
            view3.selected=NO;
            view4.selected=NO;
            
            [apsScrollView setContentOffset:CGPointMake(kDeviceWidth*1, 0) animated:YES];
        }
            break;
            
        case DELUZIBTN:
        {
            view1.selected=NO;
            view2.selected=NO;
            view3.selected=YES;
            view4.selected=NO;
            [apsScrollView setContentOffset:CGPointMake(kDeviceWidth*2, 0) animated:YES];
        }
            break;
            
        case DEKUIBEIERBTN:
        {
            view1.selected=NO;
            view2.selected=NO;
            view3.selected=NO;
            view4.selected=YES;
            [apsScrollView setContentOffset:CGPointMake(kDeviceWidth*3, 0) animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)scrollToCurrenPage:(int)currentpage
{
    
    if (currentpage==0)
    {
        view1.selected=YES;
        view2.selected=NO;
        view3.selected=NO;
        view4.selected=NO;
       
    }
    if(currentpage==1){
        view1.selected=NO;
        view2.selected=YES;
        view3.selected=NO;
        view4.selected=NO;
        
          }
    if(currentpage==2){
        
        view1.selected=NO;
        view2.selected=NO;
        view3.selected=YES;
        view4.selected=NO;
       
    }
    
    if(currentpage==3)
    {
        
        view1.selected=NO;
        view2.selected=NO;
        view3.selected=NO;
        view4.selected=YES;
       
    }
    
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)_scrollView
{
    apsScrollView.isSecond=1;
    int currentPage= (_scrollView.contentOffset.x + (_scrollView.frame.size.width / 2)) / (_scrollView.frame.size.width);
    NSLog(@"currentPage:%d",currentPage);
    [self scrollToCurrenPage:currentPage];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
