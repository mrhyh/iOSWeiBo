//
//  LBLStatus.h
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/8.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBLStatus : NSObject

//当前微博id
@property (nonatomic,assign) long long id;


//微博正文内容
@property (nonatomic,copy) NSString *text;



@end
