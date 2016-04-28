//
//  NSString+Extension.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/13.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *     返回CGSize
 *
 *     @param text 文字
 *     @param font 字体大小
 *     @param maxW 宽度限制
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

/** 计算文件\文件夹内容大小 */
- (NSInteger)fileSize;
@end
