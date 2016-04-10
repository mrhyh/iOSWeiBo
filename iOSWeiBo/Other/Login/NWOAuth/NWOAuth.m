//
//  NWOAuth.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/4/10.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "NWOAuth.h"

@implementation NWOAuth

#define URLGetAccessToken @"https://api.weibo.com/oauth2/access_token"


+ (void)getAccessToken:(NSMutableDictionary *)params successCallBack:(NetworkSuccessCallBack)successCallBack errorCallBack:(NetworkErrorCallBack)errorCallBack withStyle:(NetworkErrorInterceptStyle)networkErrorInterceptStyle{
    
    [super post:URLGetAccessToken parameters:params progress:nil successCallBack:successCallBack errorCallBack:errorCallBack withStyle:networkErrorInterceptStyle];

}
@end
