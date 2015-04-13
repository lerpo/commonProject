//
//  shareContentsToOtherApps.m
//  yuehandier
//
//  Created by apple on 14/12/13.
//  Copyright (c) 2014年 jerei. All rights reserved.
//


#import "shareContentsToOtherApps.h"
#import <ShareSDK/ShareSDK.h>
#import "ACViewDelegate.h"
#define APPALL ((AppDelegate*)[[UIApplication sharedApplication] delegate])
@interface shareContentsToOtherApps ()

@end

@implementation shareContentsToOtherApps
@synthesize title;
@synthesize contentString;
@synthesize imageUrl;
@synthesize description;
@synthesize url;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)simpleShareAllButtonClickHandler:(id)sender
{
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:contentString
                                       defaultContent:@""
                                                image:[ShareSDK imageWithUrl:imageUrl]
                                                title:title
                                                  url:url
                                          description:description
                                            mediaType:SSPublishContentMediaTypeText];
    
    ///////////////////////
    //以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
    
    
    
    //定制QQ空间信息
    [publishContent addQQSpaceUnitWithTitle:NSLocalizedString(title, @"Hello QQ空间")
                                        url:INHERIT_VALUE
                                       site:nil
                                    fromUrl:nil
                                    comment:INHERIT_VALUE
                                    summary:INHERIT_VALUE
                                      image:INHERIT_VALUE
                                       type:INHERIT_VALUE
                                    playUrl:nil
                                       nswb:nil];
    
    //定制微信好友信息
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                         content:INHERIT_VALUE
                                           title:NSLocalizedString(title, @"Hello 微信好友!")
                                             url:INHERIT_VALUE
                                      thumbImage:[ShareSDK imageWithUrl:imageUrl]
                                           image:INHERIT_VALUE
                                    musicFileUrl:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil];
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                          content:INHERIT_VALUE
                                            title:NSLocalizedString(title, @"Hello 微信朋友圈!")
                                              url:url
                                       thumbImage:[ShareSDK imageWithUrl:imageUrl]
                                            image:INHERIT_VALUE
                                     musicFileUrl:@"http://mp3.mwap8.com/destdir/Music/2009/20090601/ZuiXuanMinZuFeng20090601119.mp3"
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    //定制微信收藏信息
    [publishContent addWeixinFavUnitWithType:INHERIT_VALUE
                                     content:INHERIT_VALUE
                                       title:NSLocalizedString(@"TEXT_HELLO_WECHAT_FAV", @"Hello 微信收藏!")
                                         url:INHERIT_VALUE
                                  thumbImage:[ShareSDK imageWithUrl:@"http://img1.bdstatic.com/img/image/67037d3d539b6003af38f5c4c4f372ac65c1038b63f.jpg"]
                                       image:INHERIT_VALUE
                                musicFileUrl:nil
                                     extInfo:nil
                                    fileData:nil
                                emoticonData:nil];
    
    //定制QQ分享信息
    //    publishContent addQQUnitWithType:<#(NSNumber *)#> content:<#(NSString *)#> title:<#(NSString *)#> url:<#(NSString *)#> image:<#(id<ISSCAttachment>)#>
    [publishContent addQQUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeText]
                              content:contentString
                                title:title
                                  url:url
                                image:[ShareSDK imageWithUrl:imageUrl]];
    
    //定制邮件信息
    [publishContent addMailUnitWithSubject:@"Hello Mail"
                                   content:INHERIT_VALUE
                                    isHTML:[NSNumber numberWithBool:YES]
                               attachments:INHERIT_VALUE
                                        to:nil
                                        cc:nil
                                       bcc:nil];
    
    //定制短信信息
    [publishContent addSMSUnitWithContent:@"Hello SMS"];
    
    //定制有道云笔记信息
    [publishContent addYouDaoNoteUnitWithContent:INHERIT_VALUE
                                           title:NSLocalizedString(@"TEXT_HELLO_YOUDAO_NOTE", @"Hello 有道云笔记")
                                          author:@"ShareSDK"
                                          source:nil
                                     attachments:INHERIT_VALUE];
    
    //定制Instapaper信息
    [publishContent addInstapaperContentWithUrl:INHERIT_VALUE
                                          title:@"Hello Instapaper"
                                    description:INHERIT_VALUE];
    
    
    
    //结束定制信息
    ////////////////////////
    
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:APPALL.viewDelegate];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    id<ISSShareOptions> shareOptions = [ShareSDK simpleShareOptionsWithTitle:NSLocalizedString(@"TEXT_SHARE_TITLE", @"内容分享")
                                                           shareViewDelegate:APPALL.viewDelegate];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}

+ (void)initializePlat
{
    [ShareSDK registerApp:@"63f63ca14992"];
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    //    [ShareSDK connectWeChatWithAppId:@"wx184ab5ea26680987"        //此参数为申请的微信AppID
    //                           wechatCls:[WXApi class]];
    [ShareSDK connectWeChatTimelineWithAppId:@"wxea62efdda8c777e0" wechatCls:[WXApi class]];
    [ShareSDK connectWeChatSessionWithAppId:@"wxea62efdda8c777e0" wechatCls:[WXApi class]];
    
    /**
     连接QQ应用以使用相关功能，此应用需要引用QQConnection.framework和QQApi.framework库
     http://mobile.qq.com/api/上注册应用，并将相关信息填写到以下字段
     **/
    //旧版中申请的AppId（如：QQxxxxxx类型），可以通过下面方法进行初始化
    //    [ShareSDK connectQQWithAppId:@"QQ075BCD15" qqApiCls:[QQApi class]];
    
    [ShareSDK connectQQWithQZoneAppKey:@"1103594518"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
    [ShareSDK connectQZoneWithAppKey:@"1103594518"
                           appSecret:@"6pEcqDxapAbCQYoM"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    
    //    [ShareSDK connectQQWithQZoneAppKey:@"100371282"                 //该参数填入申请的QQ AppId
    //                     qqApiInterfaceCls:[QQApiInterface class]
    //                       tencentOAuthCls:[TencentOAuth class]];
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"1769223290"
                               appSecret:@"a1ea892f80a9f3b961586178aa61fcff"
                             redirectUri:@"http://www.meiyibaby.cn/"];
    
    
    
    //    /**
    //     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
    //     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
    //
    //     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
    //     **/
    //    [ShareSDK connectTencentWeiboWithAppKey:@"801484358"
    //                                  appSecret:@"a20cf1547d6a971974d16e0f0a667dd7"
    //                                redirectUri:@"http://www.wajueji.com"
    //                                   wbApiCls:[WeiboApi class]];
    //连接邮件
    [ShareSDK connectMail];
    
    
    
}

//分享
+ (void)share {
    shareContentsToOtherApps *shareview=[[shareContentsToOtherApps alloc]init];
    shareview.title=@"分享功能";
    
//    if (topic.resourceList!=nil&&[topic.resourceList count]>0) {
//        NSString *imgSmall=[CommonStr stringValue:[topic.resourceList objectAtIndex:0] forKey:@"imgSmall"];
//        if (imgSmall!=nil&&imgSmall.length>0) {
//            if ([imgSmall hasPrefix:@"http"]) {
//                shareview.imageUrl = imgSmall;
//            }else{
                shareview.imageUrl = [NSString stringWithFormat:@"%@",@"http://www.jerei.com"];
//            }
//        }
//    }
    shareview.contentString=@"分享内容";
    shareview.url=[NSString stringWithFormat:@"http://xxlfront.jerei.com/customer/download/index.jsp?sid=%d",25];
    //    if ([news.img hasPrefix:@"http"]) {
    //        shareview.imageUrl=news.img;
    //    }else{
    //
    //        shareview.imageUrl=[NSString stringWithFormat:@"%@%@",BASE_URL,news.img];
    //    }
    [shareview simpleShareAllButtonClickHandler:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


