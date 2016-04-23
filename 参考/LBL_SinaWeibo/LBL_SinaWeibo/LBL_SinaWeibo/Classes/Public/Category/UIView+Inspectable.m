//
//  UIView+Inspectable.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/2.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "UIView+Inspectable.h"

@implementation UIView (Inspectable)

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius>0;
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor{
    return [[UIColor alloc] initWithCGColor:self.layer.borderColor];
}



@end
