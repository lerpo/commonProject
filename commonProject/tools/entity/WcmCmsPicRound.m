//
//  WcmCmsPicRound.m
//  meyi
//
//  Created by apple on 14/12/24.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "WcmCmsPicRound.h"
@implementation WcmCmsPicRoundDAO
+(Class)getBindingModelClass
{
    return [WcmCmsPicRound class];
}
const static NSString* tablename = @"WcmCmsPicRound";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation WcmCmsPicRound
@synthesize identity;
@synthesize uuid;
@synthesize addDate;
@synthesize addIp;
@synthesize addUser;
@synthesize updateDate;
@synthesize updateIp;
@synthesize updateUser;
@synthesize sid;
@synthesize title;
@synthesize img;
@synthesize description;
@synthesize orderno;
@synthesize isShow;
@synthesize link;
@synthesize isPhone;
@synthesize dataId;
@synthesize otherLink;

@end
