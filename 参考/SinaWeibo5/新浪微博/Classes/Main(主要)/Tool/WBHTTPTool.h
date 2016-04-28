//
//  WBHTTPTool.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/17.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBHTTPTool : NSObject
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure;
+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
