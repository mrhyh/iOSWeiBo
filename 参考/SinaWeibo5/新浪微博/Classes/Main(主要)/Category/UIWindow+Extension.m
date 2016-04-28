//
//  UIWindow+Extension.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/10.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "WBNewFeatureViewController.h"
#import "WBTabBarViewController.h"

@implementation UIWindow (Extension)
/**
 *     切换根控制器
 */
- (void)switchRootViewController
{
    // 获取沙盒中软件版本号
    NSString *versionKey = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] valueForKey:versionKey];
    
    // 获取当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    // 存储版本号到沙盒中
    if ([currentVersion isEqualToString:lastVersion]) {
        // 显示WBTabBarViewController
        self.rootViewController = [[WBTabBarViewController alloc] init];
    } else {
        // 显示WBNewFeatureViewController 新特性界面
        self.rootViewController = [[WBNewFeatureViewController alloc] init];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
        // 这句不要少
        [[NSUserDefaults standardUserDefaults] synchronize];
        WJLog(@"%@", currentVersion);
    }
}
@end
