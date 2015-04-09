//
//  ViewController.h
//  commonProject
//
//  Created by JEREI on 15-4-2.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *listarray;
    UITableView *tableView;
}

@end

