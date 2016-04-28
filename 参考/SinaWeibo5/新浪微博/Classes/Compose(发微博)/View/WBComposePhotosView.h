//
//  WBComposePhotosView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBComposePhotosView : UIView
- (void)addPhoto:(UIImage *)image;
/** 要发送的图片 */
@property (nonatomic, strong, readonly) NSMutableArray *photos;
@end
