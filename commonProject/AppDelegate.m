//
//  AppDelegate.m
//  meyi
//
//  Created by apple on 14/11/14.
//  Copyright (c) 2014年 jerei. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonStr.h"
@implementation AppDelegate
@synthesize viewDelegate = _viewDelegate;
@synthesize token;
- (id)init
{
    if(self = [super init])
    {
        _viewDelegate = [[ACViewDelegate alloc] init];
    }
    return self;
}
- (void)initializePlat
{
    
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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    [ShareSDK registerApp:@"63f63ca14992"];
    [self initializePlat];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *rootController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.window setRootViewController:rootController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
