//
//  WBStatusToolBar.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/12.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatus;

@interface WBStatusToolBar : UIView
+ (instancetype)toolBar;
/** 给工具条传递WBStatus模型数据 */
@property (nonatomic, strong) WBStatus *status;
@end
