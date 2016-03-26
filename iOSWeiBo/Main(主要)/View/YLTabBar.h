//
//  YLTabBar.h
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/22.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YLTabBar;

@protocol YLTabBarDelegate <NSObject>

@optional

- (void)tabBar:(YLTabBar *)tabBar didSelectedButtonFrom:(NSInteger) from to:(NSInteger)to;
- (void)tabBarDidClickedPlusButton:(YLTabBar *)tabBar;


@end

@interface YLTabBar : UIView


- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic, weak) id <YLTabBarDelegate> delegate;


@end
