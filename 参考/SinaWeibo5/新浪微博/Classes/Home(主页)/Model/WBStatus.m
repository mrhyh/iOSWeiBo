//
//  WBStatus.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/11.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBStatus.h"
#import "MJExtension.h"
#import "WBPhoto.h"
#import "WBTextPart.h"
#import "WBSpecial.h"
#import "RegexKitLite.h"
#import "WBEmotionTool.h"
#import "WBEmotion.h"
#import "WBUser.h"

@implementation WBStatus
/**
 *     设置pic_urls包含的是WBPhoto类
 */
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [WBPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //    _created_at = @"Tue Sep 30 17:06:25 +0800 2014";
    
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

/**
 *     重写set而不是get一是没必要，二是节约性能，
 *     这个只会在字典转模型时调用一次，而get只要显示cell就要调用
 */
- (void)setSource:(NSString *)source
{
    // 截串 NSString
        NSRange range;
    
    if ([source isEqualToString:@""]) {
        _source = @"来自新浪微博";
    } else {
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        // range.length = [source rangeOfString:@"<" options:NSBackwardsSearch];
        _source = [NSString stringWithFormat:@"来自 %@", [source substringWithRange:range]];
    }
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
        
    self.attributedText = [self attributedTextWithText:text];
    
}

- (void)setRetweeted_status:(WBStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    
    NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status.user.name, retweeted_status.text];
    self.retweetedAttributedText = [self attributedTextWithText:retweetContent];
}

/**
 *  普通文字 --> 属性文字
 *
 *  @param text 普通文字
 *
 *  @return 属性文字
 */
- (NSAttributedString *)attributedTextWithText:(NSString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
    // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        // 得到的范围长度为0就不要
        if ((*capturedRanges).length == 0) return;
        
        WBTextPart *part = [[WBTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
//        WJLog(@"%@ --> %@", *capturedStrings, NSStringFromRange(*capturedRanges));
    }];
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        WBTextPart *part = [[WBTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
//        WJLog(@"%@ --> %@", *capturedStrings, NSStringFromRange(*capturedRanges));
    }];
    
    // 排序
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(WBTextPart *part1, WBTextPart *part2) {
        // 比较位置前后，location大的在后面
        if (part1.range.location > part2.range.location) {
            // 降序
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    
    UIFont *font = [UIFont systemFontOfSize:15];
    
    // 这个special是要插到属性文字里传递给textView的
    NSMutableArray *specials = [NSMutableArray array];
    // 按顺序拼接每一段文字
    for (WBTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            // 根据文字描述找到表情图片
            NSString *name = [WBEmotionTool emotionWithChs:part.text].png;
            if (name) { // 能找到对应的图片
                attch.image = [UIImage imageNamed:name];
                // 设置附件尺寸
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                // 拼接附件
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.special) { // 非表情的特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor blueColor]
                                                                                       }];
            
            // 创建特殊对象，这个special是要插到属性文字里传递给textView的
            WBSpecial *s = [[WBSpecial alloc] init];
            s.text = part.text;
            NSUInteger loc = attributedText.length;
            NSUInteger len = part.text.length;
            s.range = NSMakeRange(loc, len);
            [specials addObject:s];
        } else { // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text attributes:@{
                                                                                       NSForegroundColorAttributeName : [UIColor darkTextColor]
                                                                                       }];
        }
        [attributedText appendAttributedString:substr];
    }
    
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    // 拼接specials传递给textView
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    
    return attributedText;
}
@end
