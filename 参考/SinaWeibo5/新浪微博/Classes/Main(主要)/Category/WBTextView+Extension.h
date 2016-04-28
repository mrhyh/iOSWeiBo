//
//  WBTextView+Extension.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTextView.h"

@interface WBTextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *mutableAttributedString))settingBlock;
@end
