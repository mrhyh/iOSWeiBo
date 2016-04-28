//
//  WBEmotionTextView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTextView.h"
@class WBEmotion;

@interface WBEmotionTextView : WBTextView 
/**
 *     插入表情
 */
- (void)insertEmotion:(WBEmotion *)emotion;
/**
 *     将所有的属性文字"转为"普通文本
 */
- (NSString *)fullText;
@end
