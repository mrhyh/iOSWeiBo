//
//  YLTabbarC.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/22.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLTabbarC.h"
#import "YLTabBar.h"
#import "YLHomeVC.h"
#import "YLDiscoverVC.h"
#import "YLMeVC.h"
#import "YLMessageVC.h"
#import "YLNavigationC.h"

@interface YLTabbarC ()<YLTabBarDelegate>

@property(nonatomic, weak) YLTabBar *customTabBar;

@end

@implementation YLTabbarC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews){
        if ([child isKindOfClass:[UIControl class]]){
            [child removeFromSuperview];
        }
    }
}

- (void)setupTabbar{
    
    YLTabBar *customTabbar = [[YLTabBar alloc] init];
    customTabbar.frame = self.tabBar.bounds;
    customTabbar.delegate = self;
    _customTabBar = customTabbar;
    [self.tabBar addSubview:_customTabBar];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers{
    
    //1.首页
    YLHomeVC *homeVC = [[YLHomeVC alloc] init];
    homeVC.tabBarItem.badgeValue = @"N";
    [self setupChildViewController:homeVC title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    //2.消息
    YLMessageVC *messageVC = [[YLMessageVC alloc] init];
    messageVC.tabBarItem.badgeValue = @"N";
    [self setupChildViewController:messageVC title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    //3.广场
    YLDiscoverVC *discoverVC = [[YLDiscoverVC alloc] init];
    discoverVC.tabBarItem.badgeValue = @"N";
    [self setupChildViewController:discoverVC title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    //4.我
    YLMeVC *meVC = [[YLMeVC alloc] init];
    meVC.tabBarItem.badgeValue = @"N";
    [self setupChildViewController:meVC title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中的图标
    UIImage *selectImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 2.包装一个导航控制器
    YLNavigationC *navC = [[YLNavigationC alloc] initWithRootViewController:childVc];
    [self addChildViewController:navC];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

#pragma mark YLTabBarDelegate
- (void)tabBar:(YLTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to{
    self.selectedIndex = to;
}

- (void)tabBarDidClickedPlusButton:(YLTabBar *)tabBar{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
