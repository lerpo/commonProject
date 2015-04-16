//
//  commonJudgeMent.m
//  asiastarbus
//
//  Created by apple on 14-8-20.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "commonJudgeMent.h"
#import  <netdb.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
@implementation commonJudgeMent

typedef enum {
    NETWORK_TYPE_NONE= 0,
    NETWORK_TYPE_WIFI= 1,
    NETWORK_TYPE_3G= 2,
    NETWORK_TYPE_2G= 3,
} NETWORK_TYPE;

//ifConnectnet
+(BOOL)ifConnectNet{
    struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	if (!didRetrieveFlags) {
		return NO;
	}
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	return (isReachable && !needsConnection) ? YES : NO;
}

+ (int)getNetworkType
{
    
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
       int netType = NETWORK_TYPE_NONE;
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    if (num == nil) {
        netType = NETWORK_TYPE_NONE;
        
    }else{
        
        int n = [num intValue];
        if (n == 0) {
            netType = NETWORK_TYPE_NONE;   //无网络
        }else if (n == 1){
            netType = NETWORK_TYPE_2G;     //2G网络
        }else if (n == 2){
            netType = NETWORK_TYPE_3G;     //3G网络
        }else{
            netType = NETWORK_TYPE_WIFI;   //WIFI网络
        }
        
        
    }
    
    
    return netType;
}@end
