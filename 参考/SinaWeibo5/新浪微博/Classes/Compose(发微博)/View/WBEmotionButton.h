//
//  WBEmotionButton.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//  一个表情就是一个emotionButton

#import <UIKit/UIKit.h>
@class WBEmotion;
@interface WBEmotionButton : UIButton
/** 表情模型 */
@property (nonatomic, weak) WBEmotion *emotion;
@end
