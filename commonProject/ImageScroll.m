//
//  ImageScroll.m
//  commonProject
//
//  Created by JEREI on 15-4-16.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "ImageScroll.h"

@implementation ImageScroll

-(void)viewDidLoad
{
    self.navTiltle=@"图片轮显";
    [super viewDidLoad];
    ImageReScrollView *scrollView = [[ImageReScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 100, 300, 200);
    scrollView.imageLoadUrl = @"http://www.meiyibaby.cn/appbackend/home/banner.jsp?sid=25";
    [scrollView initPostView];
    [self.view addSubview:scrollView.view];
}
@end
