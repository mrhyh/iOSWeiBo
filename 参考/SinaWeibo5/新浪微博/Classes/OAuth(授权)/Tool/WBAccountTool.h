//
//  WBAccountTool.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/10.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBAccount;

@interface WBAccountTool : NSObject
/**
 *     将账户信息模型存储进沙盒
 *
 *     @param account 要存储的账户模型
 */
+ (void)saveAccount:(WBAccount *)account;
/**
 *     返回账户信息
 *
 *     @return 帐号信息账号模型（如果账号过期，返回nil）
 */
+ (WBAccount *)account;
@end
