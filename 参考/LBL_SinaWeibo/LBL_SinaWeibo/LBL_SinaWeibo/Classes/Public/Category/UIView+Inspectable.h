//
//  UIView+Inspectable.h
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/2.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Inspectable)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
