//
//  WBEmotionPopView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//  选中表情弹出的放大镜

#import <UIKit/UIKit.h>
@class WBEmotionButton;

@interface WBEmotionPopView : UIView
+ (instancetype)popView;
/** 从某个表情按钮显示 */
- (void)showFrom:(WBEmotionButton *)btn;
@end