//
//  UIBarButtonItem+Extension.h
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  初始化一个UIBarButtonItem
 *
 *  @param image     默认图片
 *  @param higtImage 高亮图片
 */
+(UIBarButtonItem *)itemWithImage:(NSString *)image higtImage:(NSString *)higtImage target:(id)target action:(SEL)action;

+(UIBarButtonItem *)itemWithImage:(NSString *)image higtImage:(NSString *)higtImage target:(id)target action:(SEL)action title:(NSString *)title;





@end
