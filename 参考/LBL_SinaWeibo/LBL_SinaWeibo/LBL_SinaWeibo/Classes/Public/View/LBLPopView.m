//
//  LBLPopView.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/2.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLPopView.h"


@interface LBLPopView ()

@property (nonatomic,weak) UIImageView *contentView;

@property (nonatomic,weak) UIView *customView;

@property (nonatomic,weak) UIView *showWithView;

@end


@implementation LBLPopView




- (instancetype)initWithCustomView:(UIView *)customView showWithView:(UIView *)showWithView
{
    self = [super init];
    if (self) {
        
        self.customView = customView;
        self.showWithView = showWithView;
        //添加灰框效果
        
        [self setupContentView];
        
        //添加customView
        [self.contentView addSubview:customView];
        
        self.width = SCREENW;
        self.height = SCREENH;
        
        
        //添加点击事件
        [self addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

}


//初始化小灰框
- (void)setupContentView{
    //1.外框箭头的view初始化
    UIImageView *contentView = [[UIImageView alloc] init];
    //初始化uiimage  拉伸方式
    contentView.image = [[UIImage imageNamed:@"popover_background"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 0, 20, 0) resizingMode:UIImageResizingModeStretch];
    
    //用户交互
    contentView.userInteractionEnabled = YES;
    [self addSubview:contentView];
    self.contentView = contentView;
    
    CGFloat contentViewW = self.customView.width + 10;
    CGFloat contentViewH = self.customView.height + 20;
    
    //self.contentView.backgroundColor = [UIColor blueColor];
    self.contentView.size = CGSizeMake(contentViewW, contentViewH);
    
    self.customView.x = 5;
    self.customView.y = 12;
    
}

/**
 *  点击调用方法
 *
 *  隐藏popView
 */
- (void)hide:(UIButton *)btn {
    [self removeFromSuperview];
}

//显示
- (void)show
{
    CGRect showWithViewFrameFromWindow = [self.showWithView convertRect:self.showWithView.bounds toView:[UIApplication sharedApplication].keyWindow];
    
    self.contentView.centerX = self.showWithView.centerX;
    self.contentView.y = CGRectGetMaxY(showWithViewFrameFromWindow);
    
    
    //添加到window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];

}



@end
