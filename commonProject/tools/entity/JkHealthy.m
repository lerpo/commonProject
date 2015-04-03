//
//  JkHealthy.m
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "JkHealthy.h"
@implementation JkHealthyDAO
+(Class)getBindingModelClass
{
    return [JkHealthy class];
}
const static NSString* tablename = @"JkHealthy";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation JkHealthy

@synthesize  identity;
@synthesize  userName;
@synthesize  age;
@synthesize  sex;
@synthesize  img;
@synthesize  ear;
@synthesize  glu;
@synthesize  addUser;
@synthesize  addDate;
@synthesize  addIp;
@synthesize  uuid;
@synthesize  catDate;
@synthesize  catAddress;
@synthesize  userId;
@synthesize  pcp;
@synthesize  pdp;
@synthesize  heartRate;
@synthesize  longitude;
@synthesize  latitude;
@synthesize  catResult;
@synthesize  healthFlag;
@synthesize  usern;
@synthesize  headImg;
@end
