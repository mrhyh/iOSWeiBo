//
//  WBStatusPhotosView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/13.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#define WBStatusPhotoWH 70
#define WBStatusPhotoMargin 5
/** 配图最大列数 */
#define WBStatusPhotoMaxCol(count) ((count==4)?2:3)


#import "WBStatusPhotosView.h"
#import "WBPhoto.h"
#import "WBStatusPhotoView.h"

@implementation WBStatusPhotosView
/** 设置背景颜色 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSInteger photosCount = photos.count;
    
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        WBStatusPhotoView *photoView = [[WBStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        WBStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            // 把photo传递给WBStatusPhotoView
            photoView.photo = photos[i];
            photoView.hidden = NO;
            
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }

}

- (void)layoutSubviews
{
    [ super layoutSubviews];
    
    NSInteger photosCount = self.photos.count;
    
    // 最大列数（一行最多有多少列）
    int maxCols = WBStatusPhotoMaxCol(photosCount);
    
    for (int i = 0; i<photosCount; i++) {
        WBStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCols;
        photoView.x = col * (WBStatusPhotoWH + WBStatusPhotoMargin);
        
        int row = i / maxCols;
        photoView.y = row * (WBStatusPhotoWH + WBStatusPhotoMargin);
        photoView.width = WBStatusPhotoWH;
        photoView.height = WBStatusPhotoWH;
    }
}
/**
 *     传入图片张数，计算图片所需占用尺寸
 */
+ (CGSize)sizeWithImageCount:(NSInteger)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = WBStatusPhotoMaxCol(count);
    
    /** 行数 */
    NSInteger rows = (count + maxCols - 1) / maxCols;
    
    /** 列数 */
    NSInteger cols = (count >= maxCols)? maxCols : count;;
//    WJLog(@"%ld", cols);
    /** 所有图片占用宽度 */
    CGFloat photosW = cols * WBStatusPhotoWH + (cols - 1) * WBStatusPhotoMargin;
    
    /** 所有图片占用高度 */
    CGFloat photosH = rows * WBStatusPhotoWH + (rows - 1) * WBStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
