//
//  WBDropdownMenu.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/9.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBDropdownMenu.h"

@interface WBDropdownMenu ()
/**
 *  containerView
 */
@property (nonatomic, weak) UIView *containerView;
@end
@implementation WBDropdownMenu
#pragma mark - 懒加载
- (UIView *)containerView
{
    if (!_containerView) {
        // 添加一个灰色图片控件
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES; // 开启交互
        [self addSubview:containerView];
        self.containerView = containerView;
        }
    return _containerView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 清除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc] init];
}

/**
 *     从哪里显示下拉菜单
 */
- (void)showFrom:(UIView *)from
{
    // 1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2.添加自己到窗口上
    [window addSubview:self];
    
    // 3.设置尺寸
    self.frame = window.bounds;
    
    // 4.调整灰色图片的位置
    // 默认情况下，frame是以父控件左上角为坐标原点
    // 转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    //    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);

}

/**
 *     移除下拉菜单
 */
- (void)dismiss
{
    [self removeFromSuperview];
}

/**
 *     设置UIViewController--contentVc内容
 */
- (void)setContentVc:(UIViewController *)contentVc
{
    _contentVc = contentVc;
    
    self.content = contentVc.view;
}

/**
 *     设置UIView--content内容
 */
- (void)setContent:(UIView *)content
{
    _content = content;
    
    // 调整内容位置
    self.content.x = 10;
    self.content.y = 15;
    
    // 设置灰色的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 12;
    // 设置灰色的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
    
    // 通知代理显示下拉菜单
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
}

/**
 *     点击空白处移除下拉菜单
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
    
    // 通知代理收起下拉菜单
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}
@end
