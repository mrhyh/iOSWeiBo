//
//  UserViewController.h
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/29.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController
@property (nonatomic,strong) NSString *userHeadImage;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userGender;
@property (nonatomic,assign) id userVip;
@property (nonatomic,strong) id fansCounts;
@property (nonatomic,strong) id focusCounts;
@property (nonatomic,strong) NSString *descript;

@end
