//
//  PullRefreshCell.h
//  commonProject
//
//  Created by JEREI on 15-4-3.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pulltableViewcellDelegate <NSObject>

-(void)pulltableViewcellclicked:(UIView *)tag;

@end
@interface PullRefreshCell : UITableViewCell

@property UILabel *lable;
@property(nonatomic,strong)id<pulltableViewcellDelegate> pulltablecelldelegate;
@end
