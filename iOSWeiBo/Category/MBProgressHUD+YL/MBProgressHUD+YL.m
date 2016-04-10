//
//  MBProgressHUD+MBProgressHUD.m
//  MBProgressHUDDemoPerson
//
//  Created by ylgwhyh on 16/3/11.
//  Copyright © 2016年 com.hyh. All rights reserved.
//

#import "MBProgressHUD+YL.h"


@interface MBProgressHUD()

@end

@implementation MBProgressHUD (YL)

#define IPHONE_HEIGHT_MBProgressHUD_YL   [UIScreen mainScreen].bounds.size.height
#define IPHONE_WIDTH_MBProgressHUD_YL    [UIScreen mainScreen].bounds.size.width

// RGB颜色设定
#define RGB_MBProgressHUD(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define RGBA_MBProgressHUD(r, g, b, a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]


#pragma mark 显示正确或错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view hide:YES dimBackground:NO];
}
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view hide:YES dimBackground:NO];
}


+ (void)showMessage:(NSString *)message imageName:(NSString *)imageName{
    [self show:message icon:imageName view:nil hide:YES dimBackground:NO];
}
+ (void)showMessage:(NSString *)message imageName:(NSString *)imageName toView:(UIView *)view{
    [self showMessage:message imageName:imageName toView:view];
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view hide:(BOOL)isAutoHide dimBackground:(BOOL)dimBackground
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.labelFont = [UIFont systemFontOfSize:14];
    
    hud.opacity = 0.7;
    hud.color = RGBA_MBProgressHUD(90, 91, 92, 0.7); //矩形框背景色
    
    if(icon != nil){
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        imageView.center = CGPointMake(IPHONE_WIDTH_MBProgressHUD_YL/2, IPHONE_HEIGHT_MBProgressHUD_YL/2);
        imageView.bounds = CGRectMake(0, 10, 20, 20);
        
        // 设置图片(从Bundle文件目录读取)
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
        
        hud.customView = imageView;
        hud.mode = MBProgressHUDModeCustomView;
    }else{
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
    //隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = dimBackground; // YES代表需要蒙版效果
    if(isAutoHide){
        //0.9秒之后再消失
        [hud hide:YES afterDelay:0.9];
    }
    
}


#pragma mark 显示一些信息
+ (void)showMessageWait:(NSString *)message toView:(UIView *)view {
    
    [self show:message icon:nil view:view hide:NO dimBackground:YES];
}
+ (void)hideMessage:(NSString *)message toView:(UIView *)view{
    
    MBProgressHUD *hud = [self HUDForView:view];
    if (hud != nil) {
        hud.removeFromSuperViewOnHide = YES;
    }
}

+ (void)showMessageWait:(NSString *)message{
    [self showMessageWait:message toView:nil];
}

#pragma mark 隐藏HUD

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

@end
