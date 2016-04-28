//
//  WBComposePhotosView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBComposePhotosView.h"

@implementation WBComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (void)addPhoto:(UIImage *)image
{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = image;
    [self addSubview:photoView];
    [self.photos addObject:image];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
   NSUInteger count = self.subviews.count;
    // 最大列数（一行最多有多少列）
    int maxCols = 4;
    CGFloat margin = 10;
    CGFloat photoWH = 60;
    
    for (NSUInteger i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        NSUInteger col = i % maxCols;
        photoView.x = col * (photoWH + margin);
        
        NSUInteger row = i / maxCols;
        photoView.y = row * (photoWH + margin);
        photoView.width = photoWH;
        photoView.height = photoWH;
    }

}
@end
