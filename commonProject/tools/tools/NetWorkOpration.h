
/**
   网络操作
 
 
 1获取网络实例：  networkopration = [NetWorkOpration getInstance];
 2设定代理   ：  networkopration.delegate = self;
 3发送网络请求：  ［networkopration.sendGetRequestWithUrl：@"www.baidu.com"］
 3实现代理方法：  netWorkCallbackResult： //此处返回操作请求的结果
 
 */
#import <Foundation/Foundation.h>

@protocol NetWorkCallbackDelegate <NSObject>

-(void)netWorkCallbackResult:(NSData *)data;  //网络操作返回的结果
@end

@interface NetWorkOpration : NSObject


@property(nonatomic,strong)  const id<NetWorkCallbackDelegate>  delegate;

-(void)sendGetRequestWithUrl:(NSString *)url;
+(NetWorkOpration *) getInstance;

@end
