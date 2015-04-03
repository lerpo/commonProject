//
//  PullRefreshCell.m
//  commonProject
//
//  Created by JEREI on 15-4-3.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "PullRefreshCell.h"

@implementation PullRefreshCell
@synthesize lable;
@synthesize pulltablecelldelegate;
- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 400, 44)];
        lable.textColor = [UIColor orangeColor];
        lable.font = [UIFont boldSystemFontOfSize:15.0];
        lable.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClicked:)];
        [lable addGestureRecognizer:tapGestureTel];
        [self.contentView addSubview:lable];
       
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
    
}


-(void)lableClicked:(UILabel *)sender
{
  
    [pulltablecelldelegate pulltableViewcellclicked:lable];
}
@end
