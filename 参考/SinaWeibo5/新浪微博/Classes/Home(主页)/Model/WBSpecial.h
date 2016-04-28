//
//  WBSpecial.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/18.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBSpecial : NSObject
/** 这段特殊文字的内容 */
@property (nonatomic, copy) NSString *text;
/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange range;
/** 这段特殊文字的矩形框（CGRect） */
@property (nonatomic, strong) NSArray *rects;
@end
