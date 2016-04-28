//
//  WBDropdownMenu.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/9.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBDropdownMenu;

@protocol WBDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidShow:(WBDropdownMenu *)menu;
- (void)dropdownMenuDidDismiss:(WBDropdownMenu *)menu;
@end
@interface WBDropdownMenu : UIView
/**
 *     创建下拉菜单
 */
+ (instancetype)menu;
/**
 *     显示
 *
 *     @param from 从哪里显示
 */
- (void)showFrom:(UIView *)from;
/**
 *    移除
 */
- (void)dismiss;
/**
 *  设置内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentVc;
/**
 *  代理
 */
@property (nonatomic, weak) id<WBDropdownMenuDelegate> delegate;
@end
