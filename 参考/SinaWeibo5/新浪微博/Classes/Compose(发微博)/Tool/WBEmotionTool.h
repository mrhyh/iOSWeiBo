//
//  WBEmotionTool.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/17.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBEmotion;
@interface WBEmotionTool : NSObject
/**
 *     存储表情到沙盒中
 *
 *     @param emotion 要存储的表情
 */
+ (void)addRecentEmotion:(WBEmotion *)emotion;
/** 取出最近表情 */
+ (NSArray *)recentEmotions;
/** 取出默认表情 */
+ (NSArray *)defaultEmotions;
/** 取出emoji表情 */
+ (NSArray *)emojiEmotions;
/** 取出浪小花表情 */
+ (NSArray *)lxhEmotions;
/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (WBEmotion *)emotionWithChs:(NSString *)chs;
@end
