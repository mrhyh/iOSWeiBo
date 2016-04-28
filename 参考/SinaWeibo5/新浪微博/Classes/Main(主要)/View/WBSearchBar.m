//
//  WBSearchBar.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/9.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar
+ (instancetype)searchBar
{
    return [[self alloc] init];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
#warning 注意这里已经在图片里设置了拉伸像素
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.width = 320;
        self.height = 30;
        self.placeholder = @"请输入搜索条件";
        self.font = [UIFont systemFontOfSize:15];
        
        // 设置搜索条左边的放大镜
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imgView.height = 30;
        imgView.width = 30;
        imgView.contentMode = UIViewContentModeCenter;
        // 下面两个要一起设置才能显示
        self.leftView = imgView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}
@end
