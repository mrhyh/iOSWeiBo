//
//  WBHTTPTool.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/17.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBHTTPTool.h"
#import "AFNetworking.h"

@implementation WBHTTPTool
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    [mgr POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
