//
//  WBStatusPhotosView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/13.
//  Copyright © 2015年 王万杰. All rights reserved.
//  所有图片

#import <UIKit/UIKit.h>

@interface WBStatusPhotosView : UIView
/**
 *     传入图片张数，计算图片所需占用尺寸
 */
+ (CGSize)sizeWithImageCount:(NSInteger)count;
/** 存放所有图片 */
@property (nonatomic, strong) NSArray *photos;
@end
