//
//  WBStatusPhotoView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/14.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"

@interface WBStatusPhotoView ()

/** gif标记*/
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation WBStatusPhotoView
#pragma mark - 懒加载
- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

/**
 *     设置内容显示
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置内容显示按比例适应
        self.contentMode = UIViewContentModeScaleAspectFill;
        
        // 设置超出的部分裁剪，只显示规定的正方形大小
        self.clipsToBounds = YES;
    }
    return self;
}
- (void)setPhoto:(WBPhoto *)photo
{
    _photo = photo;
    
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    WJLog(@"%@", photo.thumbnail_pic);
    // 设置是否隐藏gifView
     self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

/**
 *     设置gifView位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}
@end
