//
//  LBLAccountTool.h
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/7.
//  Copyright © 2015年 LBL. All rights reserved.
//账号保存与读取

#import <Foundation/Foundation.h>
@class LBLAccount;

@interface LBLAccountTool : NSObject
//保存
+ (void)saveAccount:(LBLAccount *)account;
//读取
+ (LBLAccount *)account;

@end
