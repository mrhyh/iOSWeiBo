//
//  WBTitleButton.m
//  sina
//
//  Created by huju on 15/10/6.
//  Copyright (c) 2015年 HJ. All rights reserved.
//

#import "WBTitleButton.h"

@interface WBTitleButton ()

@property (nonatomic, strong)UIFont *titleFont;
@property (nonatomic, assign) CGFloat titleW;
@property (nonatomic, assign) CGFloat imageW;

@end

@implementation WBTitleButton

// 设置初始状态
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 设置按钮标题字体，20号黑体
    self.titleFont = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.font = self.titleFont;
    // 设置字体颜色，注意不要用 titleLabel.textColor 来设置
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 设置按钮中字体排列方式，默认为居中排布
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    // 设置按钮中图片排布方式
    self.imageView.contentMode = UIViewContentModeCenter;
}
/**
 *  实现系统自带方法来设置按钮中文字的尺寸
 *
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    
    // 设置标题中字体的大小，也可以设置其他内容
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithCapacity:2];
    attrs[NSFontAttributeName] = self.titleFont;
    
    // 根据当前按钮的文字数量和初始化时设置好的字体大小，设置文字部分的图框宽度
    // self.currentTitle 按钮当前的文字
    CGFloat titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    self.titleW = titleW;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

/**
 *  设置按钮中图片尺寸
 *
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 15;
    CGFloat imageX = self.titleW + 2;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageY = 0;
    self.imageW = imageW + 2;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 新建一个按钮
    WBTitleButton *btn = [[self alloc] init];
    
    // 根据传递的参数设置按钮的文字、图片
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];

    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 因为按钮添加部位的特性，设置X.Y没有意义，后面修改按钮时还会有不好的影响，因此不设置X.Y
    CGFloat btnH = 30;
    CGFloat btnW = self.titleW + self.imageW;
    self.height = btnH;
    self.width = btnW;
}

+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image
{
    return [self buttonWithTitle:title image:image selectedImage:nil];
}


@end
