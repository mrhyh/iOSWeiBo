//
//  WBAccount.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/10.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.access_token = dict[@"access_token"];
        self.expires_in = dict[@"expires_in"];
        self.uid = dict[@"uid"];
        // 获得当前时间，把时间存储进用户信息，近似于access_token创建时间
        self.created_time = [NSDate date];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
    }
    return self;
}
@end
