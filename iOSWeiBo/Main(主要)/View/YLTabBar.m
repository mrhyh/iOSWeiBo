//
//  YLTabBar.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/22.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLTabBar.h"
#import "YLTabBarButton.h"
#import "UIImage+YL.h"
#import "UIView+Extension.h"

@interface YLTabBar()

@property (nonatomic, strong) NSMutableArray *tabBarBtns;
@property (nonatomic, weak)   UIButton       *plusBtn;
@property (nonatomic, weak)   YLTabBarButton *selectedBtn;

@end

@implementation YLTabBar

- (NSMutableArray *)tabBarBtns{
    if(_tabBarBtns == nil){
        _tabBarBtns = [[NSMutableArray alloc] init];
    }
    
    return _tabBarBtns;
}

- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        
#warning TODO 这里弄得太复杂了
        // 添加一个加号按钮
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        plusBtn.bounds = CGRectMake(0, 0, plusBtn.currentBackgroundImage.size.width, plusBtn.currentBackgroundImage.size.height);
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    
    return self;
}

- (void)plusBtnClick{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]){
        [self.delegate tabBarDidClickedPlusButton:self];
    }
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    // 1.创建按钮
    YLTabBarButton *btn = [[YLTabBarButton alloc] init];
    [self addSubview:btn];
    // 2.添加按钮到数组中
    [self.tabBarBtns addObject:btn];
    btn.item = item;
    // 3.监听按钮点击
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    // 4.默认选中第0个按钮
    if(self.tabBarBtns.count == 1){
        [self btnClick:btn];
    }
}

/**
 *  监听按钮点击
 */
- (void)btnClick:(YLTabBarButton *)btn{

    // 1.通知代理
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]){
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedBtn.tag to:btn.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    CGFloat h = self.height;
    CGFloat w = self.width;
    self.plusBtn.center = CGPointMake(w * 0.5, h * 0.5);
    // 按钮的frame数据
    CGFloat btnH = h;
    CGFloat btnW = w / self.subviews.count;
    CGFloat btnY = 0;
    
    for (int index = 0; index < self.tabBarBtns.count; index++) {
        // 1.取出按钮
        YLTabBarButton *btn = self.tabBarBtns[index];
        // 2.设置按钮的frame
        CGFloat btnX = index * btnW;
        if (index > 1){
            btnX += btnW;
        }
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        // 3.绑定tag
        btn.tag = index;
    }
}


@end
