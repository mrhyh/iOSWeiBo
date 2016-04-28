//
//  WBTextAttachment.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTextAttachment.h"
#import "WBEmotion.h"

@implementation WBTextAttachment
- (void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    
    // 设置图片
    self.image = [UIImage imageNamed:emotion.png];
}

@end
