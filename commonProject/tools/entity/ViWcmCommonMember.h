//
//  ViWcmCommonMember.h
//  asiastarbus
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUOYLDAOBase.h"
@interface ViWcmCommonMemberDAO : ZUOYLDAOBase

@end
@interface ViWcmCommonMember : ZUOYLModelBase<NSCoding>
{
    int	identity ;
    NSString *	uuid ;
    NSString *	head_img ;//TODO 大头像
    NSString *	usern ;//TODO 用户名
    NSString *	password ;//TODO 密码
    NSString *	email ;//TODO 邮箱
    NSString *	phone ;//TODO 手机
    NSString *	real_name ;//TODO 真实姓名
    int	sex ;//TODO 性别
    NSDate	*birthday ;//TODO 生日
    NSString *	telephone ;//TODO 座机
    int	province_id ;//TODO 省id
    int	city_id ;//TODO 市id
    int	area_id ;//TODO 区id
    NSString * address;//详细地址
    NSString * zip;//邮编
    NSString *	intro ;//TODO 个性签名
    NSString *	qq ;//TODO QQ号
    NSString *	qq_open_id ;//TODO QQ开放Id
    NSString *	sina_open_id ;//TODO sina开放Id
    //TODO 会员卡、积分等信息
    NSString *	member_no ;
    int	now_score ;
    NSString *baby_birthday;
    //TODO 辅助信息
    int	is_temp ;//TODO 是否是临时账户
    int is_quit;//TODO 是否退出
    NSDate *last_registration_date;//最后一次签到时间
    int eshop_website_id;//门店会员
    NSString *unique_code   ;//客户编码
}
@property(nonatomic,assign) int	identity ;
@property(nonatomic,strong) NSString *	uuid ;
@property(nonatomic,strong)NSString *	head_img ;//TODO 大头像
@property(nonatomic,strong)NSString *	usern ;//TODO 用户名
@property(nonatomic,strong)NSString *	password ;//TODO 密码
@property(nonatomic,strong)NSString *	email ;//TODO 邮箱
@property(nonatomic,strong)NSString *	phone ;//TODO 手机
@property(nonatomic,strong)NSString *	real_name ;//TODO 真实姓名
@property(nonatomic,assign)int	sex ;//TODO 性别
@property(nonatomic,strong)NSDate	*birthday ;//TODO 生日
@property(nonatomic,strong)NSString *	telephone ;//TODO 座机
@property(nonatomic,assign)int	province_id ;//TODO 省id
@property(nonatomic,assign)int	city_id ;//TODO 市id
@property(nonatomic,assign)int	area_id ;//TODO 区id
@property(nonatomic,strong)NSString * address;//详细地址
@property(nonatomic,strong)NSString * zip;//邮编
@property(nonatomic,strong)NSString *	intro ;//TODO 个性签名
@property(nonatomic,strong)NSString *	qq ;//TODO QQ号
@property(nonatomic,strong)NSString *	qq_open_id ;//TODO QQ开放Id
@property(nonatomic,strong)NSString *	sina_open_id ;//TODO sina开放Id
//TODO 会员卡、积分等信息
@property(nonatomic,strong)NSString *	member_no ;
@property(nonatomic,assign)int	now_score ;
@property(nonatomic,strong)NSString *baby_birthday;//宝宝出生日期
//TODO 辅助信息
@property(nonatomic,assign)int	is_temp ;//TODO 是否是临时账户
@property(nonatomic,assign)int is_quit;//TODO 是否退出
@property(nonatomic,strong)NSDate *last_registration_date;//最后一次签到时间
@property(nonatomic,assign)int eshop_website_id;//门店会员
@property(nonatomic,strong) NSString *unique_code ;// 产品条形码

@end
