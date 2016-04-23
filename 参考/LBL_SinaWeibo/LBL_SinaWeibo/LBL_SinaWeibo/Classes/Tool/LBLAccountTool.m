//
//  LBLAccountTool.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLAccountTool.h"
#import "LBLAccount.h"



//账号信息路径
#define ACCOUNT_ARCHIVE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation LBLAccountTool

+ (void)saveAccount:(LBLAccount *)account
{//归档路径
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_ARCHIVE_PATH];
    
}

+(LBLAccount *)account
{
    //读取
    
    LBLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_ARCHIVE_PATH];
    //1.判断读取是否为空
    if (account) {
        //拿expires_in这个值进行相关计算
        //accessToken 获取的时间 计算账号是否过期 createDate+expires_in(秒)与当前时间对比
        //计算过期时间
        NSDate *expiresDate = [account.createDate dateByAddingTimeInterval:account.expires_in];
        //当前时间
        NSDate *currentDate = [NSDate date];
        //对比
//       NSComparisonResult
//        {
//            NSOrderedAscending,从小到大
//            NSOrderedSame,相同
//            NSOrderedDescending 从大到小
//        }

        NSComparisonResult result = [expiresDate compare:currentDate];
        if (result == NSOrderedDescending) {
            //没有过期
            return account;
        
            
        }
        
    }
    
    return nil;
}

@end
