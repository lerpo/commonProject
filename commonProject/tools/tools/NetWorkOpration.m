//
//  NetWorkOpration.m
//  commonProject
//
//  Created by JEREI on 15-4-9.
//  Copyright (c) 2015年 com.xu.tableview. All rights reserved.
//

#import "NetWorkOpration.h"

@implementation NetWorkOpration
@synthesize delegate;


+(NetWorkOpration *)getInstance
{
     static NetWorkOpration *networkoprations;
    @synchronized(self)
    {
       if(!networkoprations)
       {
          networkoprations = [[self alloc] init];
       }
       
    }
    return networkoprations;
}


-(void)sendGetRequestWithUrl:(NSString *)url
{
    
       NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];   //get请求方式
    /*
     同步请求
     */
    @autoreleasepool {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *respons = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respons error:&error];
            NSLog(@"请求的线程:%@",[NSThread currentThread]);
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(data != nil)
                {
                    [delegate netWorkCallbackResult:data];
                    
                }
                else if(data == nil && error == nil)
                {
                    NSLog(@"接收到空数据");
                }
                else
                {
                    NSLog(@"%@",error.localizedDescription);
                }
            });});
    }


}

#pragma mark post请求
-(void)sendPostRequestWithUrl:(NSString *)url withData:(NSArray *)datas
{
    //第二步，创建请求
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    
    NSString *str = @"type=focus-c";//设置参数
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    /*
     同步请求
     */
    @autoreleasepool {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLResponse *respons = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respons error:&error];
            NSLog(@"请求的线程:%@",[NSThread currentThread]);
            dispatch_sync(dispatch_get_main_queue(), ^{
                if(data != nil)
                {
                    [delegate netWorkCallbackResult:data];
                    
                }
                else if(data == nil && error == nil)
                {
                    NSLog(@"接收到空数据");
                }
                else
                {
                    NSLog(@"%@",error.localizedDescription);
                }
            });});
    }


}
@end
