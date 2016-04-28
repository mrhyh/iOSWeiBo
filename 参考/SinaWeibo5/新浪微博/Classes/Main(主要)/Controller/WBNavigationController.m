//
//  WBNavigationController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

+ (void)initialize
{
    // 设置导航栏状态
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置导航栏文字颜色和大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [navBar setTitleTextAttributes:attrs];
    
    // 设置导航栏UIBarButtonItem主题（只需要设置一次）
    // 设置默认状态
    UIBarButtonItem *appear = [UIBarButtonItem appearance];
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [appear setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    // 设置不可用状态
    NSMutableDictionary *disableTextAttr = [NSMutableDictionary dictionary];
    disableTextAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [appear setTitleTextAttributes:disableTextAttr forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
//    NSLog(@"%ld %@", self.viewControllers.count, viewController);
    // 设置根控制器不需要该图标
    NSInteger count = self.viewControllers.count;
    if (count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        // 当被push进来隐藏工具条
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置左上角图标
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self SEL:@selector(back) image:@"navigationbar_back" highlightImage:@"navigationbar_back_highlighted"];
        
        // 设置右上角图标
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self SEL:@selector(more) image:@"navigationbar_more" highlightImage:@"forState:UIControlStateHighlighted"];
    }
    
    WJLog(@"%@------pushed", viewController);
    [super pushViewController:viewController animated:YES];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
}
@end