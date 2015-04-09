//
//  ScreenConfig.h
//  asiastarbus
//
//  Created by JEREI on 14-8-25.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenConfig : NSObject

//屏幕高度
#define SCREEN_HEIGHT_TAG 1

//屏幕宽度
#define SCREEN_WIDTH_TAG 2

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width

#define KDeviceHeight [UIScreen mainScreen].bounds.size.height

@end
