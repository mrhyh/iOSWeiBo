//
//  WBEmotionListView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//  表情键盘 listView + pageControl

#import <UIKit/UIKit.h>

@interface WBEmotionListView : UIView
/** 存放所有的Emotion表情模型 */
@property (nonatomic, strong) NSArray *emotions;
/** 是否隐藏最近显示表情 */
@property (nonatomic, assign, getter=isHihhenPageControl) BOOL hidePageControl;
@end
