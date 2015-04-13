//
//  shareContentsToOtherApps.h
//  yuehandier
//
//  Created by apple on 14/12/13.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface shareContentsToOtherApps : UIViewController
@property(nonatomic,strong)NSString *contentString;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *description;
@property(nonatomic,strong)NSString *url;
- (void)simpleShareAllButtonClickHandler:(id)sender;
+ (void)initializePlat;
+ (void)share;
@end
