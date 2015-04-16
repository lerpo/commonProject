//
//  WcmCmsPicRound.h
//  meyi
//
//  Created by apple on 14/12/24.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface WcmCmsPicRoundDAO : ZUOYLDAOBase

@end
@interface WcmCmsPicRound : ZUOYLModelBase
{
    int identity;
    NSString *uuid;
    NSString *addDate;
    NSString *addIp;
    NSString *addUser;
    NSString *updateDate;
    NSString *updateIp;
    NSString *updateUser;
    int sid;
    NSString *title;
    NSString *img;
    NSString *description;
    int orderno;
    int isShow;
    int link;
    int isPhone;
    int dataId;
    NSString *otherLink;
}
@property(nonatomic,assign) int identity;
@property(nonatomic,strong)NSString *uuid;
@property(nonatomic,strong)NSString *addDate;
@property(nonatomic,strong)NSString *addIp;
@property(nonatomic,strong)NSString *addUser;
@property(nonatomic,strong)NSString *updateDate;
@property(nonatomic,strong)NSString *updateIp;
@property(nonatomic,strong)NSString *updateUser;
@property(nonatomic,assign)int sid;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *description;
@property(nonatomic,assign)int orderno;
@property(nonatomic,assign)int isShow;
@property(nonatomic,assign)int link;
@property(nonatomic,assign)int isPhone;
@property(nonatomic,assign)int dataId;
@property(nonatomic,strong)NSString *otherLink;
@end
