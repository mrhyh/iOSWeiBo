//
//  WBStatusDataTool.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/26.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusDataTool : NSObject
/**
 *     根据参数返回数据库中微博
 *
 *     @param params 参数
 */
+ (NSArray *)statusesWithParams:(NSDictionary *)params;
/**
 *     存储微博数据到沙盒中
 *
 *     @param statuses 微博数据
 */
+ (void)saveStatuses:(NSArray *)statuses;
@end
