//
//  NWOAuth.h
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/4/10.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLBaseNetwork.h"

@interface NWOAuth : YLBaseNetwork

/**
 *  获取授权
 */
+ (void)getAccessToken:(NSMutableDictionary *)params successCallBack:(NetworkSuccessCallBack)networkSuccessCallBack errorCallBack:(NetworkErrorCallBack)networkErrorCallBack withStyle:(NetworkErrorInterceptStyle)NetworkErrorInterceptStyle;
@end
