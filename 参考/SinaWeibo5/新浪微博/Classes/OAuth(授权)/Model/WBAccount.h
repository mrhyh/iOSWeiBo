//
//  WBAccount.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/10.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject <NSCoding>

/** 接口获取授权后的access token */
@property (nonatomic, copy) NSString *access_token;

/** access_token 的生命周期，过期时间 */
@property (nonatomic, copy) NSNumber *expires_in;

/** 当前授权用户的UID */
@property (nonatomic, copy) NSString *uid;

/** access_token 的创建时间 */
@property (nonatomic, copy) NSDate *created_time;

/** 存储用户昵称 */
@property (nonatomic, copy) NSString *username;

/** 快速创建WBAccount模型 */
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
