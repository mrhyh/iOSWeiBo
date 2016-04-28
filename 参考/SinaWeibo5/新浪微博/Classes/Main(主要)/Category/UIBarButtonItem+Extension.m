//
//  UIBarButtonItem+Extension.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/9.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

/**
 *     返回一个设置好图片的UIBarButtonItem
 *
 *     @param target         点击调用哪个控制器的方法
 *     @param sel            点击调用控制器的哪个方法
 *     @param image          默认状态图片
 *     @param highlightImage 选中时图片
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target SEL:(SEL)sel image:(NSString *)image highlightImage:(NSString *)highlightImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 添加事件监听
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    // 设置frame
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
