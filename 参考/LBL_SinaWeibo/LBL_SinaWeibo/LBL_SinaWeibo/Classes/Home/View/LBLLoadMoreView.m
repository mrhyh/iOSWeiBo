//
//  LBLLoadMoreView.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLLoadMoreView.h"

@implementation LBLLoadMoreView

+ (instancetype)loadMoreView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LBLLoadMoreView" owner:nil options:nil] lastObject];
}
@end
