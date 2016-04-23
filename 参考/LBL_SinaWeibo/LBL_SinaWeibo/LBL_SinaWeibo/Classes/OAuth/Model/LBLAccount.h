//
//  LBLAccount.h
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/4.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBLAccount : NSObject<NSCoding>


@property (nonatomic, copy) NSString *uid;

@property (nonatomic, assign) NSInteger expires_in;

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *remind_in;

//accessToken 获取的时间 计算账号是否过期 createDate+expires_in(秒)与当前时间对比
@property (nonatomic,strong) NSDate *createDate;


@end
