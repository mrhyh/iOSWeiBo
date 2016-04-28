//
//  WBEmotionTabBar.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//  表情键盘工具条

#import <UIKit/UIKit.h>

@class WBEmotionTabBar;

typedef enum {
    WBEmotionTabBarButtonTypeRecent, // 最近
    WBEmotionTabBarButtonTypeDefault, // 最近
    WBEmotionTabBarButtonTypeEmoji, // 最近
    WBEmotionTabBarButtonTypeLXH, // 最近
} WBEmotionTabBarButtonType;
@protocol WBEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(WBEmotionTabBar *)emotionTabBar didClickedButton:(WBEmotionTabBarButtonType)buttonType;

@end

@interface WBEmotionTabBar : UIView
/** 按钮类型 */
@property (nonatomic, assign) WBEmotionTabBarButtonType buttonType;
/** 代理 */
@property (nonatomic, weak) id<WBEmotionTabBarDelegate> delegate;
@end
