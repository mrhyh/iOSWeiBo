//
//  UIBarButtonItem+Extension.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+extension.h"

@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithImage:(NSString *)image higtImage:(NSString *)higtImage target:(id)target action:(SEL)action
{
    //自定义button 作为UIBarButtonItem 的customView
    UIButton *button = [[UIButton alloc] init];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:higtImage] forState:UIControlStateHighlighted];
    
    //button大小
    button.size = [button currentImage].size;
    
    //点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
    
    
}

+(UIBarButtonItem *)itemWithImage:(NSString *)image higtImage:(NSString *)higtImage target:(id)target action:(SEL)action title:(NSString *)title
{
    //自定义button 作为UIBarButtonItem 的customView
    UIButton *button = [[UIButton alloc] init];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:higtImage] forState:UIControlStateHighlighted];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    //button大小
    //button.size = [button currentImage].size;
    [button sizeToFit];
    //点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
    
    
}





@end
