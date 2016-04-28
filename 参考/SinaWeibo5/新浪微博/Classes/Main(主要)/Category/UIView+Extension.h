//
//  UIView+Extension.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//  提供直接修改frame参数

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  x
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  y
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  width
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  heightx
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  centerX
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  centerY
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 *  size
 */
@property (nonatomic, assign) CGSize size;
/**
 *  origin
 */
@property (nonatomic, assign) CGPoint origin;
@end
