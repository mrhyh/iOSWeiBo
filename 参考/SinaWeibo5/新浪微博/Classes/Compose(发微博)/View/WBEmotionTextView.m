//
//  WBEmotionTextView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionTextView.h"
#import "WBEmotion.h"
#import "WBTextAttachment.h"

@implementation WBEmotionTextView
- (void)insertEmotion:(WBEmotion *)emotion
{
    if (emotion.code) { // 是emoji表情
        [self insertText:emotion.code.emoji];
        
    } else if (emotion.png) {   // 是图片表情
        // 加载图片
        WBTextAttachment *textAttach = [[WBTextAttachment alloc] init];
        
        // 传递模型
        textAttach.emotion = emotion;
        
        // 设置图片属性
        CGFloat attchWH = self.font.lineHeight;
        textAttach.bounds = CGRectMake(0, -4, attchWH, attchWH);
        
        // 根据附件创建图片属性文字
        NSAttributedString *imageAttributeString = [NSAttributedString attributedStringWithAttachment:textAttach];
        
        // 插入属性文字到光标位置，得到文字
        [self insertAttributedText:imageAttributeString settingBlock:^(NSMutableAttributedString *mutableAttributedString) {
            // 设置字体
            [mutableAttributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, mutableAttributedString.length)];
        }];
    }
}

/**
 *     将所有的属性文字"转为"普通文本
 */
- (NSString *)fullText
{
    NSMutableString *mutableString = [NSMutableString string];
    
    // 遍历所有的attribute
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        WBTextAttachment *attachment = attrs[@"NSAttachment"];
        if (attachment) { // 是图片
            // 拼接表情描述
            [mutableString appendString:attachment.emotion.chs];
        } else { // 普通文字、emoji
            // 获得这个范围内的文字
            NSAttributedString *string = [self.attributedText attributedSubstringFromRange:range];
            [mutableString appendString:string.string];
        }
    }];
    return mutableString;
}
@end
