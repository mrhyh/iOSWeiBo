//
//  YLTabBarButton.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/22.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLTabBarButton.h"
#import "YLBadgeButton.h"
#import "UIView+Extension.h"

// 图标的比例
#define YLTabBarButtonImageRatio 0.6

// 按钮的默认文字颜色
#define  YLTabBarButtonTitleColor [UIColor whiteColor]
// 按钮的选中文字颜色
#define  YLTabBarButtonTitleSelectedColor  IWColor(248, 139, 0))

@interface YLTabBarButton()

/**
 *  提醒数字
 */
@property (nonatomic, weak) YLBadgeButton *badgeBtn;

@end

@implementation YLTabBarButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:YLTabBarButtonTitleColor forState:UIControlStateNormal];
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        
        //添加一个提醒数   字按钮
        YLBadgeButton *badgeBtn = [[YLBadgeButton alloc] init];
        badgeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        self.badgeBtn = badgeBtn;
    }
    
    return self;
}

// 重写去掉高亮状态

- (void)setHighlighted:(BOOL)highlighted{}
// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * YLTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    
    return CGRectMake(0, titleY, titleW, titleH);
}

// 设置item
- (void)setItem:(UITabBarItem *)item{
    _item = item;
    
    // KVO监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
}

- (void)dealloc{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}


- (void)attemptRecoveryFromError:(NSError *)error optionIndex:(NSUInteger)recoveryOptionIndex delegate:(id)delegate didRecoverSelector:(SEL)didRecoverSelector contextInfo:(void *)contextInfo{
    
    // 设置文字
    [self setTitle:self.item.title forState:UIControlStateSelected];
    [self setTitle:self.item.title forState:UIControlStateNormal];
    // 设置图片
    [self setImage:self.item forState:UIControlStateNormal];
    [self setImage:self.item forState:UIControlStateSelected];
    // 设置提醒数字
    self.badgeBtn.badgeValue = self.item.badgeValue;
    // 设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.width - self.badgeBtn.width - 10;
    CGRect badgeF = self.badgeBtn.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeBtn.frame = badgeF;
    
}
@end
