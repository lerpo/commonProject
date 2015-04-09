//
//  PullRefreshController.h
//  commonProject
//
//  Created by JEREI on 15-4-2.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableViewController.h"
#import "PullRefreshCell.h"
#import "BaseViewController.h"
@interface PullRefreshController : BaseViewController <MJTableViewControllerDelegate,pulltableViewcellDelegate>
{
    MJTableViewController *tableView;
    UITableViewCell *cell;
    NSMutableArray *multiblearray;
}
@end
