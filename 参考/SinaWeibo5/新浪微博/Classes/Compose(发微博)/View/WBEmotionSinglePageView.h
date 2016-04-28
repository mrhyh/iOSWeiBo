//
//  WBEmotionSinglePageView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//  每一页显示的表情

#import <UIKit/UIKit.h>

// 一页中最多3行
#define WBEmotionMaxRows 3
// 一行中最多7列
#define WBEmotionMaxCols 7
// 每一页的表情个数
#define WBEmotionNumbersPerPage ((WBEmotionMaxRows * WBEmotionMaxCols) - 1)

@interface WBEmotionSinglePageView : UIView
/** 每一页显示的表情，里面存放的都是WBEmotion模型 */
@property (nonatomic, strong) NSArray *emotions;
@end
