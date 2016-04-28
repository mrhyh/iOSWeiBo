//
//  HomeNews.h
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/22.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeNews : NSObject
//微博首页中的属性

@property (nonatomic,strong) NSDictionary *user;
//用户信息
@property (nonatomic,strong) NSString *idOfUser;
@property (nonatomic,copy) NSString *profile_image_url; //用户头像地址（中图），50×50像素
@property (nonatomic,copy) NSString *screen_name;//用户昵称
@property (nonatomic,copy) NSString *created_at;//用户创建（注册）时间
@property (nonatomic,copy) NSString *profile_url;//用户的微博统一URL地址
@property (nonatomic,strong) NSString *location; //用户地址
@property (nonatomic,strong) NSString *gender; //用户性别
@property (nonatomic,assign) id followers_count;//用户粉丝数
@property (nonatomic,assign) id  friends_count;//用户关注数
@property (nonatomic,assign) id verified;//用户是否是VIP
@property (nonatomic,strong) NSString *descript;//用户描述
//微博信息
@property (nonatomic,copy) NSString *text;//微博信息内容
@property (nonatomic,strong) id  reposts_count;//转发数
@property (nonatomic,strong) id comments_count;//评论数
@property (nonatomic,strong) id attitudes_count;//表态数
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *imageOne;//附带图片数
@property (nonatomic,strong) NSString *imageTwo;//附带图片数
@property (nonatomic,strong) NSString *imageThree;//附带图片数
@property (nonatomic,strong) NSString *imageFour;//附带图片数
@property (nonatomic,strong) NSString *imageFive;//附带图片数
@property (nonatomic,strong) NSString *imageSix;//附带图片数
@property (nonatomic,strong) NSString *imageSeven;//附带图片数
@property (nonatomic,strong) NSString *imageEight;//附带图片数
@property (nonatomic,strong) NSString *imageNine;//附带图片数
@property (nonatomic,strong) NSString *source;//微博发布自哪里
//微博转发信息
@property (nonatomic,strong) NSString *retweeted_status;//转发时的数据
@property (nonatomic,strong) NSString *transmitText;//转发文本
@property (nonatomic,strong) NSString *transmitScreen_name;//被转发的人的微博名字

@property (nonatomic,strong) NSString *transmitImageOne; //被转发人的图片
@property (nonatomic,strong) NSString *transmitImageTwo;
@property (nonatomic,strong) NSString *transmitImageThree;
@property (nonatomic,strong) NSString *transmitImageFour;
@property (nonatomic,strong) NSString *transmitImageFive;
@property (nonatomic,strong) NSString *transmitImageSix;
@property (nonatomic,strong) NSString *transmitImageSeven;
@property (nonatomic,strong) NSString *transmitImageEight;
@property (nonatomic,strong) NSString *transmitImageNine;



@end
