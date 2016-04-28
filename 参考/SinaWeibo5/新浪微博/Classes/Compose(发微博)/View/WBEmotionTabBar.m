//
//  WBEmotionTabBar.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionTabBar.h"
#import "WBEmotionTabBarButton.h"

@interface WBEmotionTabBar ()
/** 标记选中的按钮 */
@property (nonatomic, weak) WBEmotionTabBarButton *selectedButton;
@end

@implementation WBEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addButton:@"最近" buttonType:WBEmotionTabBarButtonTypeRecent];
        [self addButton:@"默认" buttonType:WBEmotionTabBarButtonTypeDefault];
        [self addButton:@"Emoji" buttonType:WBEmotionTabBarButtonTypeEmoji];
        [self addButton:@"浪小花" buttonType:WBEmotionTabBarButtonTypeLXH];
    }
    return self;
}

- (void)addButton:(NSString *)name buttonType:(WBEmotionTabBarButtonType)buttonType
{
    WBEmotionTabBarButton *btn = [[WBEmotionTabBarButton alloc] init];
    // 设置监听
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchDown];
    // 绑定标识
    btn.tag = buttonType;
    [self addSubview:btn];
    
    // 设置按钮文字
    [btn setTitle:name forState:UIControlStateNormal];
    
    // 设置按钮背景
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectedImage = @"compose_emotion_table_mid_selected";
    if (buttonType == WBEmotionTabBarButtonTypeRecent) {
        image = @"compose_emotion_table_left_normal";
        selectedImage = @"compose_emotion_table_left_selected";
    } else if (buttonType == WBEmotionTabBarButtonTypeLXH) {
        image = @"compose_emotion_table_right_normal";
        selectedImage = @"compose_emotion_table_right_selected";
    }    
    // 设置背景图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateDisabled];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.x = btnW * i;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }

}

/** 点击了按钮 */
- (void)btnClicked:(WBEmotionTabBarButton *)button
{
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didClickedButton:)]) {
        [self.delegate emotionTabBar:self didClickedButton:(WBEmotionTabBarButtonType)button.tag];
    }
}

/**
 *     拦截setDelegate:设置默认选中"默认"表情，并加以显示
 */
- (void)setDelegate:(id<WBEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 设置默认选中"默认"
    [self btnClicked:(WBEmotionTabBarButton *)[self viewWithTag:WBEmotionTabBarButtonTypeDefault]];
}
@end
