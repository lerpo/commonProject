//
//  URLNameSpace.h
//  asiastarbus
//
//  Created by jerei on 14-8-5.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLNameSpace : NSObject
//基础url
#define BASE_URL @"http://www.meiyibaby.cn"

#define BASE_URLL @"http://192.168.50.46:1114"
#define pushURL @"/login/pushInfoUpdate.jsp"

//产品

//宝宝墙
#define URL_BAOBAOQIANG @"/appbackend/forum/list.jsp"

//宝宝墙
#define URL_BAOBAOQIANG_DETAIL @"/appbackend/forum/detail.jsp"
//签到
#define URL_QIANDAO @"/appbackend/signIn/index.jsp"
//能量兑换
#define URL_NENGLIANGDUIHUAN @"/appbackend/common/index.jsp"

    //兑换
#define URL_DUIHUANSHANGPIN @"/appbackend/gift/convert.jsp"
//成长线
#define URL_CHENGZHANGXIAN @"/appbackend/babyLine/list.jsp"
//会员
#define URL_HUIYUAN @"/member"

//获得会员信息
#define URL_GET_MEMBER_INFO @"/core/control/wcm_common_member/control.jsp"
//轮显
#define URL_BANNER @"/appbackend/home/banner.jsp"
//帖子 宝宝墙等
#define URL_TOPTOPICS @"/appbackend/home/index.jsp"

//产品
#define URL_CHANPIN_LIST @"/appbackend/product/list.jsp"
//详细
#define URL_CHANPIN_DETAIL @"/appbackend/product/detail.jsp"
//购买
#define URL_CHANPIN_GOUMAI @"/core/control/wcm_eshop_order_cart/control.jsp"
//立即购买
#define URL_WEB_SHOPPING @"/member/confirm_order.htm"

//跳至购物车
#define URL_WEB_SHOPPING_CART @"/member/cart.htm"

//添加到购物车
#define URL_CHANPIN_GOUWUCHE @"/core/control/wcm_eshop_order_cart/control.jsp"
//收藏
#define URL_CHANPIN_SHOUCANG @"/appbackend/collect/insert.jsp"

//取消收藏
#define URL_CHANPIN_DELETE_SHOUCANG @"/appbackend/collect/delete.jsp"

//登录
#define URL_LOGIN @"/member"

//登录页面
#define URL_WEB_LOGIN @"/member/login.htm"
//签到
#define URL_SIGN_URL @"/appbackend/signIn/index.jsp"


#define URL_INSERT @"/appbackend/forum/insert.jsp"

//更新帖子
#define URL_UPDATE @"/appbackend/forum/updatelist.jsp"

//图片上传
#define BASE_URL_FOR_IMAGE @"http://xxldata.jerei.com"

//二维码
#define DEFINE_INDEX_URL @"/appbackend/scan/index.jsp"

#define SUBMIT_INSERT @"/appbackend/submit/insert.jsp"
//个人资料修改
#define USER_INFO_UPDATE_URL @"/member/info.jsp"
@end
/*
http://192.168.50.45:9998/appbackend/forum/list.jsp?condition=add_user_id=1034&channel_id=1&user_id= 1034 //我的宝宝墙


http://192.168.50.45:9998/appbackend/signIn/index.jsp?sid=25&user_id=1034 //签到


http://192.168.50.45:9998/appbackend/common/index.jsp?sid=25&table_name=wcm_cms_gift //能量兑换


http://192.168.50.45:9998/appbackend/babyLine/list.jsp?gid=24 //成长线


http://192.168.50.45:9998/member //会员 Web

http://192.168.50.45:9998/appbackend/product/list.jsp?type_id=0&condition= //产品 type_id=0&condition= 明确筛选条件，参数均未定
 */

