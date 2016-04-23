//
//  LBLTabBar.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLTabBar.h"
#import "UIView+extension.h"

@interface LBLTabBar ()



@property (nonatomic,weak) UIButton *plusButon;
@end


@implementation LBLTabBar

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化加号
        UIButton *plusButon = [[UIButton alloc] init];
        //背景
        [plusButon setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButon setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        //图片
        [plusButon setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButon setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        //加好点击事件
        [plusButon addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:plusButon];
        
        self.plusButon = plusButon;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //button位子大小
    self.plusButon.size = [self.plusButon.currentBackgroundImage size];
    self.plusButon.centerX = self.centerX;
    self.plusButon.centerY = self.height * 0.5;
    
    
    //计算tabbarbutton 宽度
    CGFloat tabBarButtonW = self.width / 5;
    NSInteger buttonIndex = 0;
    
    for (int i = 0; i < self.subviews.count; ++i) {
        UIView *childView = self.subviews[i];
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (buttonIndex == 2) {
                buttonIndex++;
            }
            childView.width = tabBarButtonW;
            childView.x = buttonIndex * tabBarButtonW;
            buttonIndex++;
        }
        
        
    }
    
    
   
    
    
    
}

- (void)plusButtonClick:(UIButton *)plusBtn{
    if ([self.delegate respondsToSelector:@selector(tabBar:plusButtonClick:)]) {
        [self.delegate tabBar:self plusButtonClick:plusBtn];
        
    }
}











/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
