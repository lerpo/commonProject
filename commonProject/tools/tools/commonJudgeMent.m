//
//  commonJudgeMent.m
//  asiastarbus
//
//  Created by apple on 14-8-20.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "commonJudgeMent.h"
#import  <netdb.h>
#import <SystemConfiguration/SystemConfiguration.h>
@implementation commonJudgeMent

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
@end
