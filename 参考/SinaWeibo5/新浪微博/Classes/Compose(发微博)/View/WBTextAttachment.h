//
//  WBTextAttachment.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBEmotion;
@interface WBTextAttachment : NSTextAttachment

/** 模型 */
@property (nonatomic, weak) WBEmotion *emotion;
@end
