//
//  WBEmotionKeyboard.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionKeyboard.h"
#import "WBEmotionListView.h"
#import "WBEmotionTabBar.h"
#import "WBEmotion.h"
#import "MJExtension.h"
#import "WBEmotionTool.h"

@interface WBEmotionKeyboard () <WBEmotionTabBarDelegate>
/** 标记正在显示的listView */
@property (nonatomic, weak) WBEmotionListView *showingListView;
/** 工具条 */
@property (nonatomic, weak) WBEmotionTabBar *tabBar;
/** 最近表情 */
@property (nonatomic, strong) WBEmotionListView *recentEmotionView;
/** 默认表情 */
@property (nonatomic, strong) WBEmotionListView *defaultEmotionView;
/** emoji表情 */
@property (nonatomic, strong) WBEmotionListView *emojiEmotionView;
/** 浪小花表情 */
@property (nonatomic, strong) WBEmotionListView *lxhEmotionView;
@end

@implementation WBEmotionKeyboard
#pragma mark - 懒加载
- (WBEmotionListView *)recentEmotionView
{
    if (!_recentEmotionView) {
        self.recentEmotionView = [[WBEmotionListView alloc] init];
        // 如果是最近表情就隐藏页码指示器
        self.recentEmotionView.hidePageControl = YES;// 取出沙盒中的表情
        self.recentEmotionView.emotions = [WBEmotionTool recentEmotions];
    }
    return _recentEmotionView;
}
- (WBEmotionListView *)defaultEmotionView
{
    if (!_defaultEmotionView) {
        self.defaultEmotionView = [[WBEmotionListView alloc] init];
        self.defaultEmotionView.hidePageControl = NO;
        self.defaultEmotionView.emotions = [WBEmotionTool defaultEmotions];
    }
    return _defaultEmotionView;
}
- (WBEmotionListView *)emojiEmotionView
{
    if (!_emojiEmotionView) {
        self.emojiEmotionView = [[WBEmotionListView alloc] init];
        self.emojiEmotionView.hidePageControl = NO;
        self.emojiEmotionView.emotions = [WBEmotionTool emojiEmotions];
    }
    return _emojiEmotionView;
}

- (WBEmotionListView *)lxhEmotionView
{
    if (!_lxhEmotionView) {
        self.lxhEmotionView = [[WBEmotionListView alloc] init];
        self.lxhEmotionView.hidePageControl = NO;
        self.lxhEmotionView.emotions = [WBEmotionTool lxhEmotions];
    }
    return _lxhEmotionView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 工具条 */
        WBEmotionTabBar *tabBar = [[WBEmotionTabBar alloc] init];
        // 设置代理
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 监听表情按钮被按下
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionButtonDidClicked) name:WBEmotionButtonDidClickedNotification object:nil];
    }
    return self;
}

/** 监听表情被按下刷新最近表情 */
- (void)emotionButtonDidClicked
{
    // 取出沙盒中的表情
    self.recentEmotionView.emotions = [WBEmotionTool recentEmotions];
}

/** 移除监听 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews
{
    // 工具条
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 设置正在显示listView的frame
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.height = self.tabBar.y;
    self.showingListView.width = self.width;
}

#pragma mark - WBEmotionTabBarDelegate代理方法
- (void)emotionTabBar:(WBEmotionTabBar *)emotionTabBar didClickedButton:(WBEmotionTabBarButtonType)buttonType
{
    // 先移除正在显示的listView
    [self.showingListView removeFromSuperview];
    
    switch (buttonType) {
        case WBEmotionTabBarButtonTypeRecent:   { // 最近
            [self addSubview:self.recentEmotionView];
            break;
        }
            
        case WBEmotionTabBarButtonTypeDefault:  { // 默认
            [self addSubview:self.defaultEmotionView];
            break;
        }
            
        case WBEmotionTabBarButtonTypeEmoji:    { // Emoji
            [self addSubview:self.emojiEmotionView];
            break;
        }
            
        case WBEmotionTabBarButtonTypeLXH:     { // 浪小花
            [self addSubview:self.lxhEmotionView];
            break;
        }
    }
    // 最后一个即是需要显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 重新布局子控件(系统会在下一个消息循环中恰当时刻调用)
    [self setNeedsLayout];

}
@end
