//
//  WBEmotionTabBarButton.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionTabBarButton.h"

@implementation WBEmotionTabBarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认字体大小和颜色
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    // 取消高亮状态所做的一切事情
}
@end
