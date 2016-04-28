//
//  WBEmotionPopView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionPopView.h"
#import "WBEmotionButton.h"

@interface WBEmotionPopView ()
/** 背景图片 */
@property (nonatomic, weak) UIImageView *imageView;
/** 图片按钮 */
@property (nonatomic, weak) WBEmotionButton *emotionBtn;
@end

@implementation WBEmotionPopView
+ (instancetype)popView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景图片
        UIImage *image = [UIImage imageNamed:@"emoticon_keyboard_magnifier"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        // 图片按钮
        WBEmotionButton *emotionButton = [[WBEmotionButton alloc] init];
        [self addSubview:emotionButton];
        self.emotionBtn = emotionButton;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置背景frame
    self.imageView.frame = self.bounds;
    
    // 按钮frame
    self.emotionBtn.x = self.emotionBtn.y = 0;
    self.emotionBtn.width = self.width;
    self.emotionBtn.height = self.emotionBtn.width;
}

/** 从某个表情按钮显示 */
- (void)showFrom:(WBEmotionButton *)btn
{
    // 如果按钮无值直接返回
    if (btn == nil) return;
    
    // 将模型传递给popView
    self.emotionBtn.emotion = btn.emotion;
    
    // 取得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 将放大镜显示在窗口上
    [window addSubview:self];
    
    // 设置放大镜frame
    // 转换坐标系
    CGRect newFrame = [btn convertRect:btn.bounds toView:window];
    self.centerX = btn.centerX;
    self.y = CGRectGetMidY(newFrame) - self.height;
}
@end
