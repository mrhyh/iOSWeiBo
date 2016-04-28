//
//  WBAccountTool.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/10.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"

#define WBAccountInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accountInfo.archive"]

@implementation WBAccountTool
+ (void)saveAccount:(WBAccount *)account
{
    // 存储用户信息模型
    [NSKeyedArchiver archiveRootObject:account toFile:WBAccountInfoPath];
}

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (WBAccount *)account
{
    // 加载模型
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:WBAccountInfoPath];
    
    /** 验证token是否过期 */
    /** token生命时长 */
    long long expires_in = [account.expires_in longLongValue];
    /** 算出token过期时间（创建时间加上生命时长）*/
    NSDate *expires_time = [account.created_time dateByAddingTimeInterval:expires_in];
    /** 当前时间 */
    NSDate *now = [NSDate date];
    
    // 比较时间
    NSComparisonResult result = [expires_time compare:now];
    if (result != NSOrderedDescending) { // 不是降序就是过期
        return nil;
    }
    
    return account;
}
@end
