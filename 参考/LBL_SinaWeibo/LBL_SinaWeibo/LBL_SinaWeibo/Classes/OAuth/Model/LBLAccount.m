//
//  LBLAccount.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/4.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLAccount.h"

@implementation LBLAccount

- (void)setExpires_in:(NSInteger)expires_in
{
    _expires_in = expires_in;
    //设置创建时间
    self.createDate = [NSDate date];
}


/**
 *  指定怎么存储
 *
 *  @param encoder
 */
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeInteger:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.remind_in forKey:@"remind_in"];
    [encoder encodeObject:self.createDate forKey:@"createDate"];


}
/**
 *  当前对象从文件读取调用这个方法
 *
 *  @param decoder
 *
 *  @return 
 */
- (instancetype)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self) {
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeIntegerForKey:@"expires_in"];
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.createDate = [decoder decodeObjectForKey:@"createDate"];

    }
    return self;
}









@end
