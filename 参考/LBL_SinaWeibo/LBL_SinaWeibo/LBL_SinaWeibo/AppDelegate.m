//
//  AppDelegate.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "AppDelegate.h"
#import "LBLTabBarController.h"
#import "LBLNewFeaturesController.h"
#import "LBLOAuthViewController.h"
#import "LBLAccount.h"
#import "LBLAccountTool.h"
#import "UIWindow+SwitchRootviewCtrl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
      
    
    
    
//初始化一个window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    

   // LBLTabBarController *tabbarCtrl = [[LBLTabBarController alloc] init];
    
    
    
    //设置根控制器
    
    [self setRootViewCtrlWithWindow:self.window];
    
    //[self.window setRootViewController:[LBLOAuthViewController new]];
    
    //3.显示出来
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
    return YES;
}

- (void)setRootViewCtrlWithWindow:(UIWindow *)window{
    
    //判断保存得版本号
    CGFloat currentVersion = [LBLUtils appVersion];
    CGFloat saveVersion = [[NSUserDefaults standardUserDefaults] doubleForKey:KEY_VERSION];
    if (saveVersion == 0) {
        //进入新特性
        [self.window setRootViewController:[LBLNewFeaturesController new]];
    }else{
        //版本号对比
        if (currentVersion>saveVersion) {
            [self.window setRootViewController:[LBLNewFeaturesController new]];
        }else{
            //是否登陆
            [window switchRootviewCtrl];
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
