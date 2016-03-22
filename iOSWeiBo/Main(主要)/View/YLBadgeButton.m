//
//  YLBadgeButton.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/22.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLBadgeButton.h"
#import "UIImage+YL.h"

@implementation YLBadgeButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
 
    }
    return self;
}



@end
