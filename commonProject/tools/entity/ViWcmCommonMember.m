//
//  ViWcmCommonMember.m
//  asiastarbus
//
//  Created by apple on 14-10-10.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "ViWcmCommonMember.h"
@implementation ViWcmCommonMemberDAO
+(Class)getBindingModelClass
{
    return [ViWcmCommonMember class];
}
const static NSString* tablename = @"ViWcmCommonMember";
+(const NSString *)getTableName
{
    return tablename;
}
@end
@implementation ViWcmCommonMember
@synthesize	identity ;
@synthesize	uuid ;
@synthesize	head_img ;//TODO 大头像
@synthesize	usern ;//TODO 用户名
@synthesize	password ;//TODO 密码
@synthesize	email ;//TODO 邮箱
@synthesize	phone ;//TODO 手机
@synthesize	real_name ;//TODO 真实姓名
@synthesize	sex ;//TODO 性别
@synthesize birthday ;//TODO 生日
@synthesize	telephone ;//TODO 座机
@synthesize	province_id ;//TODO 省id
@synthesize	city_id ;//TODO 市id
@synthesize	area_id ;//TODO 区id
@synthesize address;//详细地址
@synthesize zip;//邮编
@synthesize	intro ;//TODO 个性签名
@synthesize	qq ;//TODO QQ号
@synthesize	qq_open_id ;//TODO QQ开放Id
@synthesize	sina_open_id ;//TODO sina开放Id
//TODO 会员卡、积分等信息
@synthesize	member_no ;
@synthesize	now_score ;
@synthesize baby_birthday;
//TODO 辅助信息
@synthesize	is_temp ;//TODO 是否是临时账户
@synthesize is_quit;//TODO 是否退出
@synthesize last_registration_date;//最后一次签到时间
@synthesize eshop_website_id;//门店会员
@synthesize unique_code ; //产品条形码
-(id)init{
    self=[super init];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:last_registration_date forKey:@"last_registration_date"];
    [aCoder encodeObject:member_no forKey:@"member_no"];
    [aCoder encodeObject:sina_open_id forKey:@"sina_open_id"];
    [aCoder encodeObject:qq_open_id forKey:@"qq_open_id"];
    [aCoder encodeObject:unique_code forKey:@"unique_code"];
    [aCoder encodeObject:qq forKey:@"qq"];
    [aCoder encodeObject:intro forKey:@"intro"];
    [aCoder encodeObject:zip forKey:@"zip"];
    [aCoder encodeObject:address forKey:@"address"];
    [aCoder encodeObject:telephone forKey:@"telephone"];
    [aCoder encodeObject:birthday forKey:@"birthday"];
    [aCoder encodeObject:real_name forKey:@"real_name"];
    [aCoder encodeObject:phone forKey:@"phone"];
    [aCoder encodeObject:email forKey:@"email"];
    [aCoder encodeObject:password forKey:@"password"];
    [aCoder encodeObject:usern forKey:@"usern"];
    [aCoder encodeObject:head_img forKey:@"head_img"];
    [aCoder encodeObject:uuid forKey:@"uuid"];
    [aCoder encodeInteger:now_score forKey:@"now_score"];
    [aCoder encodeObject:baby_birthday forKey:@"baby_birthday"];
    [aCoder encodeInteger:area_id forKey:@"area_id"];
    [aCoder encodeInteger:city_id forKey:@"city_id"];
    [aCoder encodeInteger:province_id forKey:@"province_id"];
    [aCoder encodeInteger:sex forKey:@"sex"];
    
    [aCoder encodeBool:is_quit forKey:@"is_quit"];
    [aCoder encodeBool:is_temp forKey:@"is_temp"];
    [aCoder encodeInteger:eshop_website_id forKey:@"eshop_website_id"];
    
    [aCoder encodeInteger:identity forKey:@"identity"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self.last_registration_date =[aDecoder decodeObjectForKey:@"last_registration_date"];
    self.member_no =[aDecoder decodeObjectForKey:@"member_no"];
    self.sina_open_id =[aDecoder decodeObjectForKey:@"sina_open_id"];
    self.qq_open_id =[aDecoder decodeObjectForKey:@"qq_open_id"];
    self.qq =[aDecoder decodeObjectForKey:@"qq"];
    self.intro =[aDecoder decodeObjectForKey:@"intro"];
    self.zip =[aDecoder decodeObjectForKey:@"zip"];
    self.address=[aDecoder decodeObjectForKey:@"address"];
    self.telephone=[aDecoder decodeObjectForKey:@"telephone"] ;
    self.birthday=[aDecoder decodeObjectForKey:@"birthday"] ;
    self.real_name =[aDecoder decodeObjectForKey:@"real_name"];
    self.phone =[aDecoder decodeObjectForKey:@"phone"];
    self.email =[aDecoder decodeObjectForKey:@"email"];
    self.password=[aDecoder decodeObjectForKey:@"password"] ;
    self.usern=[aDecoder decodeObjectForKey:@"usern"] ;
    self.head_img =[aDecoder decodeObjectForKey:@"head_img"];
    self.uuid =[aDecoder decodeObjectForKey:@"uuid"];
    self.is_temp=[aDecoder decodeBoolForKey:@"is_temp"];
    self.unique_code = [aDecoder decodeObjectForKey:@"unique_code"];
    self.identity=[aDecoder decodeIntForKey:@"identity"];
    self.sex=[aDecoder decodeIntForKey:@"sex"];
    self.province_id=[aDecoder decodeIntForKey:@"province_id"];
    self.city_id=[aDecoder decodeIntForKey:@"city_id"];
    self.area_id=[aDecoder decodeIntForKey:@"area_id"];
    self.now_score=[aDecoder decodeIntForKey:@"now_score"];
    self.baby_birthday =[aDecoder decodeObjectForKey:@"baby_birthday"];
    self.eshop_website_id =[aDecoder decodeIntForKey:@"eshop_website_id"];
    
    self.is_quit=[aDecoder decodeBoolForKey:@"is_quit"];
    
    return self;
}


@end
