//
//  YLNavigationC.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/23.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLNavigationC.h"
#import "UIImage+YL.h"

@interface YLNavigationC()

@end

@implementation YLNavigationC

/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+(void)initialize{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme{
    
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    
    // 设置背景
    [barButtonItem setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [barButtonItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor grayColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:12];
    [barButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [barButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[UITextAttributeTextColor] =  [UIColor lightGrayColor];
    [barButtonItem setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];

    // 设置背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置标题属性
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    textAttrs[NSShadowAttributeName] = [UIColor blackColor];
//    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:19];
//    [navBar setTitleTextAttributes:textAttrs];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont boldSystemFontOfSize:19];
    [navBar setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if(self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

@end
