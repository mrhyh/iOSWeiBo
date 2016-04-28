//
//  WBUser.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/11.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    // 在这里设置是为了防止频繁调用vip的get方法
    self.vip = mbtype > 2;
}
@end
