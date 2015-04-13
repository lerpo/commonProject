//
//  UITextField+UITextFeildCatagory.m
//  commonProject
//
//  Created by JEREI on 15-4-13.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "UITextField+UITextFeildCatagory.h"

@implementation UITextField (UITextFeildCatagory)
-(void)setInputView
{
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 38.0f)];
    keyboardToolbar.barStyle  = UIBarStyleBlack;
    keyboardToolbar.tag  = self.tag;
    
    
    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(resignFirstResponder)];
    
    [keyboardToolbar setItems:[NSArray arrayWithObjects:spaceBarItem,doneBarItem, nil]];
    self.inputAccessoryView = keyboardToolbar;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

@end
