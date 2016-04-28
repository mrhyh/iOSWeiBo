//
//  WBIconView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/14.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBUser;
@interface WBIconView : UIImageView
/** 传递WBUser模型给头像 */
@property (nonatomic, strong) WBUser *user;
@end
