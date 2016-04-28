//
//  ChiefViewController.m
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/22.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import "ChiefViewController.h"
#import "DWTabBar.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"


#define DWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0] //<<< 用10进制表示颜色，例如（255,255,255）黑色
#define DWRandomColor DWColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
@interface ChiefViewController ()

@end

@implementation ChiefViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 设置子控制器
//    [self setUpChildViewController];
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    HomeViewController *hvc=[sb instantiateViewControllerWithIdentifier:@"HomeViewController"];
    
    [self.navigationController pushViewController:hvc animated:YES];

 [self setUpTabBar];

}
#pragma mark -
#pragma mark - Private Methods

/**
 *  利用 KVC 把 系统的 tabBar 类型改为自定义类型。
 */
- (void)setUpTabBar
{
    
    [self setValue:[[DWTabBar alloc] init] forKey:@"tabBar"];
}


///**
// *  添加子控制器，我这里值添加了4个，没有占位自控制器
// */
//- (void)setUpChildViewController{
//    
//    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]]
//                          WithTitle:@"首页"
//                          imageName:@"tabbar_home"
//                  selectedImageName:@"tabbar_home_selected"];
//    
//    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[MessageViewController alloc] init]]
//                          WithTitle:@"消息"
//                          imageName:@"tabbar_message_center"
//                  selectedImageName:@"tabbar_message_center_selected"];
//    
//    
//    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[DiscoverViewController alloc]init]]
//                          WithTitle:@"发现"
//                          imageName:@"tabbar_discover"
//                  selectedImageName:@"tabbar_discover_selected"];
//    
//    
//    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:[[MeViewController alloc]init]]
//                          WithTitle:@"我"
//                          imageName:@"tabbar_profile"
//                  selectedImageName:@"tabbar_profile_selected"];
//    
//}
//
///**
// *  添加一个子控制器
// *
// *  @param viewController    控制器
// *  @param title             标题
// *  @param imageName         图片
// *  @param selectedImageName 选中图片
// */
//
//- (void)addOneChildViewController:(UIViewController *)viewController
//                        WithTitle:(NSString *)title
//                        imageName:(NSString *)imageName
//                selectedImageName:(NSString *)selectedImageName
//{
//    
//    viewController.view.backgroundColor     = DWRandomColor;
//    viewController.tabBarItem.title         = title;
//    viewController.tabBarItem.image         = [UIImage imageNamed:imageName];
//    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
//    
//  [self addChildViewController:viewController];
//    
//}



@end
