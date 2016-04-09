//
//  YLBaseNetwork.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/4/9.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLBaseNetwork.h"
#import "AFNetworking.h"

@implementation YLBaseNetwork


+ (void)post:(NSString *)URLString
        parameters:(id)parameters

          progress:(void(^)(NSProgress *))uploadProgress
   successCallBack:(NetworkSuccessCallBack)successCallBack
     errorCallBack:(NetworkErrorCallBack)errorCallBack
         withStyle:(NetworkErrorInterceptStyle)NetworkErrorInterceptStyle{
    
    //AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy]; //https请求采用
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    //**HTTPS请求专属**
    //session.securityPolicy = securityPolicy;
    //**
    
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [session POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSNumber *code = (NSNumber *)dict[@"code"];
        if(code !=nil && code.intValue !=200 ){
             NSLog(@"请求数据失败..代码: %d msg: %@.", code.intValue, dict[@"message"]);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}
/*
 
 if (code != nil && code.intValue != 200) {

 [self execErrorCallBack:errorCallBack daoErrorInterceptStyle:daoErrorInterceptStyle code:code.intValue message:dict[@"message"]];
 return;
 }
 successCallBack(dict);
 
 }
 failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
 NSLog(@"网络错误.. %@.", [error localizedDescription]);
 [self execErrorCallBack:errorCallBack daoErrorInterceptStyle:daoErrorInterceptStyle code:error.code message:[error localizedDescription]];
 }];
 */
+ (void)get:(NSString *)URLString
 parameters:(id)parameters

   progress:(void(^)(NSProgress *))uploadProgress
successCallBack:(NetworkSuccessCallBack)successCallBack
errorCallBack:(NetworkErrorCallBack)errorCallBack
  withStyle:(NetworkErrorInterceptStyle)NetworkErrorInterceptStyle{
    
}

+ (void)defaultErrorCallBack:(long)code msg:(NSString*)msg
{
    NSLog(@"出错后的回调");
}

+ (void)errorCallBack:(NetworkErrorCallBack)errorCallBack networkErrorInterceptStyle:
(NetworkErrorInterceptStyle)networkErrorIntercept code:(long)code message:(NSString *)message{
    
    if (errorCallBack != nil){
        
        switch (networkErrorIntercept) {
            case NetworkErrorInterceptStyleBeforeChain:
                
                errorCallBack(code, message);
                [self defaultErrorCallBack:code msg:message];
                break;
                
            case NetworkErrorInterceptStyleAfterChain:
                [self defaultErrorCallBack:code msg:message];
                errorCallBack(code, message);
                break;
                
            case NetworkErrorInterceptStyleSkip:
                errorCallBack(code, message);
                break;
                
            default:
                break;
        }
        
    }else{ //errorCallBack为空
        [self defaultErrorCallBack:code msg:message];
    }
}




























@end
