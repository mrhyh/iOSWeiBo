//
//  YLNavigationC.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/23.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLNavigationC.h"
#import "UIImage+YL.h"
#import "YLCommon.h"
#import "UIColor+Extension.h"

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
   // [self setupBarButtonItemTheme];
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
    //UINavigationBar *navBar = [UINavigationBar appearance];

    
     /************ 控件外观设置 **************/
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //设置navigationBar背景和字体颜色
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithHex:0x15A230]];
    [[UITabBar appearance] setTintColor:[UIColor colorWithHex:0x15A230 alpha:0.5]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:0x15A230]} forState:UIControlStateSelected];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor navigationbarColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor titleBarColor]];
    
    
    //设置返回图片

    
//    [UISearchBar appearance].tintColor = [UIColor colorWithHex:0x15A230];
//    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setCornerRadius:14.0];
//    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAlpha:0.6];
}

//重写此方法后Navigation的设定属性全不见了
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
//    if(self.viewControllers.count > 0){
//        viewController.hidesBottomBarWhenPushed = YES;
//    }
//    
//    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"backImage" style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton::)];
   // viewController.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"backImage"];
  [super pushViewController:viewController animated:animated];
}

- (void)didTapBackButton:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:animated];
}

@end
