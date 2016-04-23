//
//  UIWindow+SwitchRootviewCtrl.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "UIWindow+SwitchRootviewCtrl.h"
#import "LBLAccountTool.h"
#import "LBLTabBarController.h"
#import "LBLOAuthViewController.h"

@implementation UIWindow (SwitchRootviewCtrl)

- (void)switchRootviewCtrl
{
    UIViewController *ctrl = nil;
    if ([LBLAccountTool account]) {
        //进入主页面
        ctrl = [[LBLTabBarController alloc] init];
    }else{
        ctrl = [LBLOAuthViewController new];
    }
    [self setRootViewController:ctrl];
}


@end
