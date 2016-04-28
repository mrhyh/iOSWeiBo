//
//  WBTextView.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/14.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTextView : UITextView
/** 占位文字 */
@property (nonatomic, strong) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
