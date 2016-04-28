//
//  WBEmotionButton.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionButton.h"
#import "WBEmotion.h"

@implementation WBEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *     初始化
 */
- (void)setup
{
    // 设置文字大小
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    // 取消高亮图片变灰
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {  // 有图片
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code) {  // 是emoji表情
        NSString *emoji = [emotion.code emoji];
        [self setTitle:emoji forState:UIControlStateNormal];
    }

}
@end
