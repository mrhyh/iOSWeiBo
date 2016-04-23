//
//  LBLTabBarController.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLTabBarController.h"
#import "LBLTabBar.h"
#import "LBLHomeTableVC.h"
#import "LBLNavigationController.h"
#import "LBLDiscoverTableVC.h"

@interface LBLTabBarController ()<LBLTabBarDelegate>

@end

@implementation LBLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化自定义tabbar
    LBLTabBar *tabBar = [[LBLTabBar alloc] init];
    tabBar.delegate = self;
    //kvc只读
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    
    
    LBLHomeTableVC *Home = [[LBLHomeTableVC alloc] init];

    
    
    [self addChildViewControllerWithTitle:@"首页" image:@"tabbar_home" ctrl:Home];
    
    
    UIViewController *Message = [[UIViewController alloc] init];
    
    [self addChildViewControllerWithTitle:@"消息" image:@"tabbar_message_center" ctrl:Message];
    
    LBLDiscoverTableVC *Discover = [[LBLDiscoverTableVC alloc] init];
    
    [self addChildViewControllerWithTitle:@"发现" image:@"tabbar_discover" ctrl:Discover];
    
    UIViewController *Profile = [[UIViewController alloc] init];
    
    [self addChildViewControllerWithTitle:@"我" image:@"tabbar_profile" ctrl:Profile];
    

    
}

- (void)addChildViewControllerWithTitle:(NSString *)title image:(NSString *)image ctrl:(UIViewController *)ctrl
{
    
    
    ctrl.view.backgroundColor = [UIColor whiteColor];
    //初始化子控制器
    //UIViewController *ctrl = [[UIViewController alloc] init];
    ctrl.tabBarItem.image = [UIImage imageNamed:image];
    
    //图片选中的颜色
    
    UIImage *originalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",image]];
    
    
    ctrl.tabBarItem.selectedImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //标题
//    ctrl.tabBarItem.title = title;
//    
//    ctrl.navigationItem.title = title;
    ctrl.title = title;
    
    //初始化文字属性
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //标题文字属性
    [ctrl.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
    LBLNavigationController *navCtrl = [[LBLNavigationController alloc] initWithRootViewController:ctrl];
    
    
    [self addChildViewController:navCtrl];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -LBLTabBarDelegate
- (void)tabBar:(LBLTabBar *)tabBar plusButtonClick:(UIButton *)btn
{
    
}


@end
