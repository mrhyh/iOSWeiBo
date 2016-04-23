//
//  LBLTabBar.h
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LBLTabBar;

@protocol  LBLTabBarDelegate<NSObject,UITabBarDelegate>

- (void)tabBar:(LBLTabBar *)tabBar plusButtonClick:(UIButton *)btn;

@end


@interface LBLTabBar : UITabBar

@property (nonatomic,weak) id<LBLTabBarDelegate>delegate;



@end
