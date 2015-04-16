//
//  WaitProgress.m
//  SocketTest
//
//  Created by apple on 12-11-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WaitProgress.h"

@implementation WaitProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.frame = CGRectMake(0.0f, 0.0f, 26.0f, 26.0f);
        //    [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        
        [self addSubview:activityView];
        [activityView startAnimating];

        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
     Drawing code
}
*/

@end
