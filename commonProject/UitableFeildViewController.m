//
//  UitableFeildViewController.m
//  commonProject
//
//  Created by JEREI on 15-4-8.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "UitableFeildViewController.h"
#import "ScreenConfig.h"
#import "UITextView+UITextViewCategory.h"
@interface UitableFeildViewController ()

@end

@implementation UitableFeildViewController

- (void)viewDidLoad {
     self.navTiltle = @"UiTableFeild Test";
    [super viewDidLoad];
   
    UITextView *textField = [[UITextView alloc] initWithFrame:CGRectMake(0, 74,200 , 200)];
    textField.textColor = [UIColor blackColor];
    [textField setInputView];
    [self.view addSubview:textField];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
