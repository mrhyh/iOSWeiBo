//
//  LBLUtils.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/3.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLUtils.h"

@implementation LBLUtils

+(CGFloat)appVersion
{
    NSDictionary *infoDictionary = [NSBundle mainBundle].infoDictionary;
    
    CGFloat currentVersion = [infoDictionary[@"CFBundleShortVersionString"]doubleValue];
    
    return currentVersion;
    
    
}


@end
