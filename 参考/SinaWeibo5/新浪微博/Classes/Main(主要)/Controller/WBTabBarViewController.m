//
//  WBTabBarViewController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTabBarViewController.h"
#import "WBHomeViewController.h"
#import "WBMessageCenterViewController.h"
#import "WBDiscoverViewController.h"
#import "WBProfileViewController.h"
#import "WBNavigationController.h"
#import "WBTabBar.h"
#import "WBComposeViewController.h"

@interface WBTabBarViewController () <WBTabBarDelegate>

@end

@implementation WBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置子控制器
    WBHomeViewController *homeVc = [[WBHomeViewController alloc] init];
    [self addChildVc:homeVc name:@"主页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    WBMessageCenterViewController *messageCenter = [[WBMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter name:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    WBDiscoverViewController *discover = [[WBDiscoverViewController alloc] init];
    [self addChildVc:discover name:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    WBProfileViewController *profile = [[WBProfileViewController alloc] init];
    [self addChildVc:profile name:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    // 替换系统的tabBar为自定义的
    WBTabBar *tabBar = [[WBTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

/**
 *     添加一个子控制器
 *
 *     @param childVc       子控制器
 *     @param name          子控制器名称
 *     @param image         图片
 *     @param selectedImage 选中时显示的图片
 */
- (void)addChildVc:(UIViewController *)childVc name:(NSString *)name image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置控制器tabBar名称（同时设置了tabBar和导航栏标题）
    childVc.title = name;
    // 设置默认图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 设置选中时的图片并且图片不渲染，保留原始
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置默认字体属性
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = WBColor(123, 123, 123, 1);
    [childVc.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    // 设置选中字体属性
    NSMutableDictionary *textSelectededAttr = [NSMutableDictionary dictionary];
    textSelectededAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textSelectededAttr forState:UIControlStateSelected];
    // 因为view是懒加载，这里提前调用了viewDidLoad
//        childVc.view.backgroundColor = WBRandomColor;
    // 给控制器包装一个导航控制器
    WBNavigationController *navC = [[WBNavigationController alloc] initWithRootViewController:childVc];
    
    // 添加子控制器
    [self addChildViewController:navC];
}

#pragma mark - WBTabBarDelegate代理方法
/**
 *     点击了加号发微博按钮
 */
- (void)tabBarDidClickedPlusBtn:(WBTabBar *)tabBar
{
    WBComposeViewController *composeVc = [[WBComposeViewController alloc] init];
    WBNavigationController *modal = [[WBNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:modal animated:YES completion:nil];
}

@end
