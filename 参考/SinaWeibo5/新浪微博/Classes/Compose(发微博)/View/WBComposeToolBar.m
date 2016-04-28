//
//  WBComposeToolBar.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBComposeToolBar.h"

@interface WBComposeToolBar ()
/** 表情按钮 */
@property (nonatomic, weak) UIButton *emotionButton;
@end

@implementation WBComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        // 添加按钮
        [self addBtnAtToolBarNormalImage:@"compose_camerabutton_background" highlightImage:@"compose_camerabutton_background_highlighted" type:WBComposeToolBarButtonTypeCamera];
        
        [self addBtnAtToolBarNormalImage:@"compose_toolbar_picture" highlightImage:@"compose_toolbar_picture_highlighted" type:WBComposeToolBarButtonTypeAlbum];
        
        [self addBtnAtToolBarNormalImage:@"compose_mentionbutton_background"
                          highlightImage:@"compose_mentionbutton_background_highlighted" type:WBComposeToolBarButtonTypeMention];
        
        [self addBtnAtToolBarNormalImage:@"compose_trendbutton_background" highlightImage:@"compose_trendbutton_background_highlighted" type:WBComposeToolBarButtonTypeTrend];
        
        self.emotionButton = [self addBtnAtToolBarNormalImage:@"compose_emoticonbutton_background" highlightImage:@"compose_emoticonbutton_background_highlighted" type:WBComposeToolBarButtonTypeEmotion];
    }
    return self;
}

/**
 *     添加按钮到工具条
 *
 *     @param image          按钮图片
 *     @param highlightImage 按钮高亮图片
 */
- (UIButton *)addBtnAtToolBarNormalImage:(NSString *)image highlightImage:(NSString *)highlightImage type:(WBComposeToolBarButtonType)type
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = type;
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(composeToolBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

/**
 *     布局子控件
 */
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
- (void)composeToolBarButtonClicked:(UIButton *)btn
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickedButton:)]) {
        [self.delegate composeToolBar:self didClickedButton:(WBComposeToolBarButtonType)btn.tag];
    }
}

- (void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton = showEmotionButton;
    
    if (self.isShowEmotionButton) { // 切换为键盘按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else {    // 切换为表情按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
@end
