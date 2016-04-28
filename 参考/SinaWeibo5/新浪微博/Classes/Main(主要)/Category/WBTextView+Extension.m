//
//  WBTextView+Extension.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTextView+Extension.h"

@implementation WBTextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text
{
    [self insertAttributedText:text settingBlock:nil];
}

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock
{
    // 创建属性文字
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    
    // 拼接之前的文字（图片和文字）
    [mutableAttributedString appendAttributedString:self.attributedText];
    
    // 拼接图片
    NSUInteger location = self.selectedRange.location;
//    [mutableAttributedString insertAttributedString:text atIndex:location];
    [mutableAttributedString replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    // 如果有设置block，就把mutableAttributedString传出去设置
    if (settingBlock) {
        settingBlock(mutableAttributedString);
    }
    
    // 赋值
    self.attributedText = mutableAttributedString;
    
    // 移动光标
    self.selectedRange = NSMakeRange(location + 1, 0);
}
@end
