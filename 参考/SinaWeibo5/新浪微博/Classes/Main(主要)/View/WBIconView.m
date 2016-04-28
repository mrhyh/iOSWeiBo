//
//  WBIconView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/14.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBIconView.h"
#import "UIImageView+WebCache.h"
#import "WBUser.h"
@interface WBIconView ()
/** 认证头像 */
@property (nonatomic, weak) UIImageView *verifiedView;
@end

@implementation WBIconView

#pragma mark - 懒加载
- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (void)setUser:(WBUser *)user
{
    _user = user;
    
    // 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 设置认证
    switch (user.verified_type) {
        case WBUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case WBUserVerifiedOrgEnterprice: // 企业官方：CSDN、EOE、搜狐新闻客户端
        case WBUserVerifiedOrgMedia: // 媒体官方：程序员杂志、苹果汇
        case WBUserVerifiedOrgWebsite: // 网站官方：猫扑
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case WBUserVerifiedDaren: // 达人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        
        default: // 当做没有任何认证
            self.verifiedView.hidden = YES;
            break;
    }
}
/**
 *     设置认证图标位置
 */
- (void)layoutSubviews
{
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - scale * self.verifiedView.width;
    self.verifiedView.y = self.height - scale * self.verifiedView.height;
    self.verifiedView.size = self.verifiedView.image.size;
}
@end
