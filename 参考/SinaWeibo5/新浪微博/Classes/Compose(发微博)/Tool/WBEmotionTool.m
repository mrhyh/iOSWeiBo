//
//  WBEmotionTool.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/17.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionTool.h"
#import "WBEmotion.h"
#import "MJExtension.h"

#define WBRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.archive"]

@implementation WBEmotionTool

// 减少IO操作
static NSMutableArray *_recentEmotionArray;

+ (void)initialize
{
    // 先从沙盒中取出已有的表情
    _recentEmotionArray = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithFile:WBRecentEmotionsPath];
    
    if (_recentEmotionArray == nil) {   // 原来没有表情才创建
        _recentEmotionArray = [NSMutableArray array];
    }
}

+ (void)addRecentEmotion:(WBEmotion *)emotion
{
    // 先移除已经存在表情
    [_recentEmotionArray removeObject:emotion];
    
    // 最多允许20个最近表情
    if (_recentEmotionArray.count > 19) {
        [_recentEmotionArray removeLastObject];
    }
    // 添加表情到最前面
    [_recentEmotionArray insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotionArray toFile:WBRecentEmotionsPath];
}

+ (NSArray *)recentEmotions
{
    return _recentEmotionArray;
}

// 减少IO操作
static NSArray *_defaultEmotions, *_emojiEmotions, *_lxhEmotions;

/** 取出默认表情 */
+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info" ofType:@"plist"];
        _defaultEmotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultEmotions;
}

/** 取出emoji表情 */
+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info" ofType:@"plist"];
        _emojiEmotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiEmotions;
}

/** 取出浪小花表情 */
+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info" ofType:@"plist"];
        _lxhEmotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhEmotions;
}

+ (WBEmotion *)emotionWithChs:(NSString *)chs
{
    // 拿到表情
    NSArray *defaults = [self defaultEmotions];
    for (WBEmotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    NSArray *lxhs = [self lxhEmotions];
    for (WBEmotion *emotion in lxhs) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    
    return nil;
}
@end
