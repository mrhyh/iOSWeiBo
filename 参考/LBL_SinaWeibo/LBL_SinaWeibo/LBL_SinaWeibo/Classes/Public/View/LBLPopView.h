//
//  LBLPopView.h
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/2.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBLPopView : UIButton


- (instancetype)initWithCustomView:(UIView *)customView showWithView:(UIView *)showWithView;
//显示
- (void)show;

@end
