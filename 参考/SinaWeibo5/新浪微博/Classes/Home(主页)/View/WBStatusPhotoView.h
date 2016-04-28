//
//  WBStatusPhotoView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/14.
//  Copyright © 2015年 王万杰. All rights reserved.
//  一张图片

#import <UIKit/UIKit.h>
@class WBPhoto;
@interface WBStatusPhotoView : UIImageView
/** 传递图片模型给一个photo */
@property (nonatomic, strong) WBPhoto *photo;
@end
