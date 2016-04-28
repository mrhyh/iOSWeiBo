//
//  DataManager.h
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/22.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Constant.h"
//#import "HomeNews.h"
//成功之后处理的block
typedef void (^SuccessBlock)(NSArray *arr,NSUInteger maxpage);
//失败
typedef void (^FailedBlock)(NSError *error);

@interface DataManager : NSObject


+(instancetype)shareManager;

-(void)requestNewsWithsuccessHome:(SuccessBlock)sBlock
                       failedHome:(FailedBlock)fBlock;

@end
