//
//  WBTabBar.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/9.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTabBar.h"

@interface WBTabBar ()
/**
 *  加号按钮
 */
@property (nonatomic, weak) UIButton *plusBtn;
@end
@implementation WBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加按钮到tabBar中
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        
        // 监听点击
        [plusBtn addTarget:self action:@selector(clickedPlusBtn) forControlEvents:UIControlEventTouchUpInside];
        // 设置尺寸
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        // 添加加号按钮
        [self addSubview:plusBtn];
        
        self.plusBtn = plusBtn;
    }
    return self;
}
/**
 *     点击了加号按钮
 */
- (void)clickedPlusBtn
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusBtn:)]) {
        [self.delegate tabBarDidClickedPlusBtn:self];
    }
}
/**
 *     布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置加号按钮位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    // 布局其他UITabBarButton
    CGFloat tarBarButtonWidth = self.bounds.size.width * 0.2;
    int tarBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {  // 是UITabBarButton
            child.width = tarBarButtonWidth;
            child.x = tarBarButtonIndex * tarBarButtonWidth;
            tarBarButtonIndex++;
            
            // 第三个开始再加一次，不要给加号按钮设置x
            if (tarBarButtonIndex == 2) {
                tarBarButtonIndex++;
            }
        }
    }
//    WJLog(@"%@", self.subviews);
    
}
@end
