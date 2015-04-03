//
//  JkHealthy.h
//  jiankangyizu
//
//  Created by apple on 15/1/16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface JkHealthyDAO : ZUOYLDAOBase

@end
@interface JkHealthy : ZUOYLModelBase
{
    int identity;
    NSString *userName;
    int age;
    int sex;
    NSString *img;
    double ear;
    double glu;
    NSString *addUser;
    NSString *addDate;
    NSString *addIp;
    NSString *uuid;
    NSString *catDate;
    NSString *catAddress;
    NSString *headImg;
    NSString *usern;
    int userId;
    int pcp;
    int pdp;
    int heartRate;
    NSString *longitude;
    NSString *latitude;
    NSString *catResult;
    int healthFlag;
}
@property(nonatomic,strong) NSString *usern;
@property(nonatomic,assign) int userId;
@property(nonatomic,assign) int identity;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,assign) int age;
@property(nonatomic,assign) int sex;
@property(nonatomic,strong) NSString *img;
@property(nonatomic,assign) double ear;
@property(nonatomic,assign) double glu;
@property(nonatomic,strong) NSString *addUser;
@property(nonatomic,strong) NSString *addDate;
@property(nonatomic,strong) NSString *addIp;
@property(nonatomic,strong) NSString *uuid;
@property(nonatomic,strong) NSString *catDate;
@property(nonatomic,strong) NSString *catAddress;
@property(nonatomic,strong) NSString *headImg;
@property(nonatomic,assign) int pcp;
@property(nonatomic,assign) int pdp;
@property(nonatomic,assign) int heartRate;
@property(nonatomic,strong) NSString *longitude;
@property(nonatomic,strong) NSString *latitude;
@property(nonatomic,strong) NSString *catResult;
@property(nonatomic,assign) int healthFlag;
@end
