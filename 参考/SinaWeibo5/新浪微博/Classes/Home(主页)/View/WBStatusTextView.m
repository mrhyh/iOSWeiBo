//
//  WBStatusTextView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/18.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBStatusTextView.h"
#import "WBSpecial.h"

// 点中的部分tag
#define WBtatusTextViewBackTag 713

@implementation WBStatusTextView

- (void)setupSpecials
{
    // 取出传递过来特殊属性文字数组
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:0];
    
    
    for (WBSpecial *special in specials) {
        // 选中的range,影响self.selectedTextRange
        self.selectedRange = special.range;
        
        // 获得选中烦我的所有矩形框
        NSArray *selectedRects = [self selectionRectsForRange:self.selectedTextRange];;
        // 清空选中范围
        self.selectedRange = NSMakeRange(0, 0);
        
        
        NSMutableArray *rectSaved = [NSMutableArray array];
        // 取出所有矩形框
        for (UITextSelectionRect *selectedRect in selectedRects) {
            CGRect rect = selectedRect.rect;
            // 无宽无高的就跳过
            if (rect.size.height == 0 || rect.size.width == 0) continue;
            
            // 添加rect到rectSaved
            [rectSaved addObject:[NSValue valueWithCGRect:rect]];
        }
        special.rects = rectSaved;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.editable = NO;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        // 禁止滚动，完全显示文字
        self.scrollEnabled = NO;
    }
    return self;
}

// 处理点击特殊文字
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self];
    
    // 初始化矩形框
    [self setupSpecials];
    
    // 根据触摸点获得被触摸的特殊文本
    WBSpecial *special = [self touchingSpecialWithPoint:location];
    
    // 在被摸出的特殊文本后面显示背景view
    for (NSValue *value in special.rects) {
        UIView *backView = [[UIView alloc] initWithFrame:value.CGRectValue];
        backView.backgroundColor = [UIColor yellowColor];
        backView.tag = WBtatusTextViewBackTag;
        backView.layer.cornerRadius = 5;
        // 插到最下端
        [self insertSubview:backView atIndex:0];
    }
}

- (WBSpecial *)touchingSpecialWithPoint:(CGPoint)point
{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:0];
    for (WBSpecial *special in specials) {
        
        for (NSValue *selectedRect in special.rects) {
            CGRect rect = selectedRect.CGRectValue;
            
            if (CGRectContainsPoint(rect, point)) { // 点中了某个特殊字符串，并且点在了特殊文本框内
                return special;
                
                break;
            }
        }
    }
    return nil;
}
/**
 *     这个点交给谁处理
 */
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return nil;
//}
/**
 *     告诉系统这个点是否在这个UI控件身上
 *     在这里处理textView的点击时间，除了特殊字符串外，其他的都交给cell处理
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // 初始化矩形框
    [self setupSpecials];
    
    // 根据触摸点获得被触摸的特殊文本
    WBSpecial *special = [self touchingSpecialWithPoint:point];
    
    // special有值就是点在了特殊字符串上，就处理
    return special;
}

/** 触摸操作被动取消立马移除背景 */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *child in self.subviews) {
        if (child.tag == WBtatusTextViewBackTag) {
            [child removeFromSuperview];
        }
    }
}
/** 触摸操作主动取消延时0.3秒移除背景 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}
@end
