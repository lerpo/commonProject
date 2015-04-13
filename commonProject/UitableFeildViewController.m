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
#import "UITextField+UITextFeildCatagory.h"
#import "UIView+UIViewCategory.h"
#import "ViewEvent.h"
@interface UitableFeildViewController ()

@end

@implementation UitableFeildViewController

- (void)viewDidLoad {
     self.navTiltle = @"UITextFeild UITextView UIlable Test";
    [super viewDidLoad];
    UITextView *textview = [[UITextView alloc] init];
    [self.view addSubview:textview];
    [textview layout_heigth:20];
    [textview layout_width:100];
    [textview margin_left:10.0];
    [textview margin_top:64];
    [textview setInputView];
    
    UITextField *textfeild = [[UITextField alloc] init];
    [self.view addSubview:textfeild];
    [textfeild layout_width:100];
    [textfeild layout_heigth:20];
    [textfeild tobottomView:textview ofPix:10];
    [textfeild alignleftwithview:textview];
    textfeild.placeholder = @"请输入内容";
    [textfeild setInputView];
    
    UILabel *lable = [[UILabel alloc] init];
    [self.view addSubview:lable];
    lable.backgroundColor = [UIColor orangeColor];
    lable.textColor = [UIColor whiteColor];
    [lable layout_heigth:20];
    [lable layout_width:200];
    [lable tobottomView:textfeild ofPix:10];
    [lable alignleftwithview:textfeild];
    lable.text = @"you click me,please!!";
    lable.userInteractionEnabled = YES;
    [ViewEvent setclickListenerOnView:lable withCallback:@selector(lableclick:) withTarget:self];
    
   
}

-(void)lableclick:(UIGestureRecognizer *) sender
{
    UILabel *textField = (UILabel *)sender.view;
    NSLog(@"%@",textField.text);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
