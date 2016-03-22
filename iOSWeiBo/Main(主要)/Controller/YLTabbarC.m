//
//  YLTabbarC.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/22.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLTabbarC.h"
#import "YLTabBar.h"

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

- (void)setupTabbar{
    YLTabBar *customTabbar = [[YLTabBar alloc] init];
    customTabbar.frame = self.tabBar.bounds;
    customTabbar.delegate = self;
    [self.tabBar addSubview:customTabbar];
    _customTabBar = customTabbar;

}

- (void)setupAllChildViewControllers{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
