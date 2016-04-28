//
//  WBTextView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/14.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTextView.h"

@implementation WBTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 增加通知监听自己的内容改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

/** 移除监听 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/** 自己的内容改变 */
- (void)textChanged
{
    // 重绘
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
//    WJLog(@"drawRect---");
    // 有文字就不要重绘
    if (self.hasText) return;
    
    // 设置属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    // 为能自动换行，设置绘图限定在一个矩形框内
    // 绘制
   CGRect placeholderRect = CGRectMake(5, 8, rect.size.width - 10, rect.size.height - 16);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}
@end
