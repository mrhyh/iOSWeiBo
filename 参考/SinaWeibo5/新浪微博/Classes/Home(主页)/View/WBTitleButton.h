//
//  WBTitleButton.h
//  sina
//
//  Created by huju on 15/10/6.
//  Copyright (c) 2015年 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTitleButton : UIButton

/**
 *  设置按钮
 *
 *  @param title  按钮标题
 *  @param image  normal状态的图片
 *  @param selImg selected状态的图片
 *
 */
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage;
/**
 *  设置按钮
 *
 *  @param title  按钮标题
 *  @param image  normal状态的图片
 *
 */
+ (instancetype)buttonWithTitle:(NSString *)title image:(NSString *)image;

@end
