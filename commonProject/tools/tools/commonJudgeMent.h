//
//  commonJudgeMent.h
//  asiastarbus
//
//  Created by apple on 14-8-20.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commonJudgeMent : NSObject
+(BOOL)ifConnectNet;   //判断网络是否连接
+(int)getNetworkType;  //判断网络类型
@end
