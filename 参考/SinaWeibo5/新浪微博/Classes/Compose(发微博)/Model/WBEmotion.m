//
//  WBEmotion.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotion.h"

@interface WBEmotion () <NSCoding>

@end

@implementation WBEmotion
/**
 *     从文件中读取
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

/**
 *    写入到文件
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
}

/**
 *     重写此方法是为了将比较对象地址转为比较字符串
 */
- (BOOL)isEqual:(WBEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];;
}


@end
