//
//  WBTextPart.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/18.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTextPart.h"

@implementation WBTextPart
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
