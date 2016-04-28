//
//  WBStatusToolBar.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/12.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBStatusToolBar.h"
#import "WBStatus.h"

@interface WBStatusToolBar ()

/** 里面存放所有的按钮 */
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线 */
@property (nonatomic, strong) NSMutableArray *dividers;
/** 转发按钮 */
@property (nonatomic, weak) UIButton *retweetBtn;
/** 评论按钮 */
@property (nonatomic, weak) UIButton *commentBtn;
/** 赞按钮 */
@property (nonatomic, weak) UIButton *attitudeBtn;
@end

@implementation WBStatusToolBar
- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

+ (instancetype)toolBar
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        /** 添加按钮 */
        self.retweetBtn = [self addBtn:@"转发" image:@"timeline_icon_retweet"];
        self.commentBtn = [self addBtn:@"评论" image:@"timeline_icon_comment"];
       self.attitudeBtn = [self addBtn:@"赞" image:@"timeline_icon_unlike"];
        
        /** 添加分隔线 */
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}
/**
 *     添加分隔线
 */
- (void)setupDivider
{
    UIImageView *dividerLine = [[UIImageView alloc] init];
    dividerLine.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:dividerLine];
    
    [self.dividers addObject:dividerLine];
}
/**
 *     快速添加按钮
 *
 *     @param title 按钮标题
 *     @param image 按钮图片
 */
- (UIButton *)addBtn:(NSString *)title image:(NSString *)image
{
    UIButton *btn = [[UIButton alloc] init];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    return btn;
}

/**
 *     设置子控件frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮frame
    NSInteger count = self.btns.count;
    CGFloat btnY = 0;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 设置分隔线frame
    NSInteger dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
    
}

- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    [self setupBtnNumbers:self.retweetBtn count:status.reposts_count title:@"转发"];
    [self setupBtnNumbers:self.commentBtn count:status.comments_count title:@"评论"];
    [self setupBtnNumbers:self.attitudeBtn count:status.attitudes_count title:@"赞"];
    
}

/**
 *     设置工具条按钮数字
 *
 *     @param btn   按钮
 *     @param count 需设置数字
 *     @param title 无数字时标题
 */
- (void)setupBtnNumbers:(UIButton *)btn count:(int)count title:(NSString *)title
{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        } else {
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
