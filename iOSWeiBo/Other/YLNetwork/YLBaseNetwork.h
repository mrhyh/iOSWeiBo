//
//  YLBaseNetwork.h
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/4/9.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

typedef void (^NetworkSuccessCallBack)(id data);
typedef void (^NetworkErrorCallBack) (long code, NSString *msg);

//网络错误捕获类型
typedef NS_ENUM(NSInteger, NetworkErrorInterceptStyle) {
    NetworkErrorInterceptStyleBeforeChain,
    NetworkErrorInterceptStyleAfterChain,
    NetworkErrorInterceptStyleSkip
};

@interface YLBaseNetwork : NSObject


+ (void)defaultErrorCallBack:(long)code msg:(NSString*)msg;

+ (void)post:(NSString *)URLString
        parameters:(id)parameters

          progress:(void(^)(NSProgress *))uploadProgress
   successCallBack:(NetworkSuccessCallBack)successCallBack
     errorCallBack:(NetworkErrorCallBack)errorCallBack
         withStyle:(NetworkErrorInterceptStyle)NetworkErrorInterceptStyle;

+ (void)get:(NSString *)URLString
        parameters:(id)parameters

          progress:(void(^)(NSProgress *))uploadProgress
   successCallBack:(NetworkSuccessCallBack)successCallBack
     errorCallBack:(NetworkErrorCallBack)errorCallBack
         withStyle:(NetworkErrorInterceptStyle)NetworkErrorInterceptStyle;
@end
