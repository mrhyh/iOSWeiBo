//
//  YLAppVersion.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/4/9.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLAppVersion.h"

#define YLAppVersionKey @"YLAppVersionKey"

@implementation YLAppVersion

+ (BOOL)isFirstSetUpApp{
    // 1. 获取当前版本信息
    NSString *currentBundleVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 2. 判断当前版本是否是最新
    if ([currentBundleVersion isEqualToString:[YLAppVersion readLocalAppVersion]]) { // 3.1 如果不是新版本
        return NO;
    } else {                                            // 3.2 如果是新版本
        // 1. 保存新版本信息（偏好设置)
        [self saveAppVersionToLocal:currentBundleVersion];
        
        return YES;
    }

}

+ (void )saveAppVersionToLocal:(NSString *)currentBundleVersion{
    [[NSUserDefaults standardUserDefaults] setObject:currentBundleVersion forKey:YLAppVersionKey];
}

#pragma mark 读取本地保存的App的版本号
+ (NSString *)readLocalAppVersion{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"YLAppVersionKey"];
}
@end
