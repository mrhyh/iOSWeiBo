//
//  WBTabBar.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/9.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabBar;

@protocol WBTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickedPlusBtn:(WBTabBar *)tabBar;

@end
@interface WBTabBar : UITabBar

/**
 *  代理
 */
@property (nonatomic, weak) id<WBTabBarDelegate> delegate;

@end
