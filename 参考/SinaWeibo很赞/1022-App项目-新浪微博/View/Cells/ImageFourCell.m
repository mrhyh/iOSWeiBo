//
//  ImageFourCell.m
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/28.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import "ImageFourCell.h"
#import "UITableViewCell+Config.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"


@interface ImageFourCell ()
@property (strong, nonatomic) IBOutlet UIButton *buttonOfHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *labelOfName;
@property (strong, nonatomic) IBOutlet UILabel *labelOfTime;
@property (strong, nonatomic) IBOutlet UILabel *labelOfAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelOfText;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOfOne;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOfTwo;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOfThree;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOfFour;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOfFive;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOfSix;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfTransmit;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfComment;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfPraise;

@end
@implementation ImageFourCell



-(void)configHomeCell:(HomeNews *)news
{
    //给button配置头像
    NSString *str=news.profile_image_url;
    NSURL *url=[NSURL URLWithString:str];
    self.buttonOfHeadImage.layer.cornerRadius=25;
    self.buttonOfHeadImage.clipsToBounds=YES;
    [self.buttonOfHeadImage setBackgroundImageForState:UIControlStateNormal withURL:url];
    //给label配置用户名
    self.labelOfName.text=news.screen_name;
    //发布时间
    NSString *strTime=news.created_at;
    NSArray *arrTime=[strTime componentsSeparatedByString:@" "];
    NSString *month=arrTime[1];
    
    NSString *day=arrTime[2];
    NSString *time=arrTime[3];
    
    if ([month isEqualToString:@"Jan"])
    {
        month=@"1";
    }
    else if ([month isEqualToString:@"Feb"])
    {
        month=@"2";
    }
    else if ([month isEqualToString:@"Mar"])
    {
        month=@"3";
    }
    else if ([month isEqualToString:@"Apr"])
    {
        month=@"4";
    }
    else if ([month isEqualToString:@"May"])
    {
        month=@"5";
    }
    else if ([month isEqualToString:@"Jun"])
    {
        month=@"6";
    }
    else if ([month isEqualToString:@"Jul"])
    {
        month=@"7";
    }
    else if ([month isEqualToString:@"Aug"])
    {
        month=@"8";
    }
    else if ([month isEqualToString:@"Sept"])
    {
        month=@"9";
    }
    else if ([month isEqualToString:@"Oct"])
    {
        month=@"10";
    }
    else if ([month isEqualToString:@"Nov"])
    {
        month=@"11";
    }
    else if ([month isEqualToString:@"Dec"])
    {
        month=@"12";
    }
    NSMutableString *mTime=[NSMutableString stringWithFormat:@"%@-%@ %@",month,day,time];
    self.labelOfTime.text=mTime;
    
    //发布来源
    self.labelOfAddress.text=news.location;
    // 发布内容
    //文本内容
    self.labelOfText.text=news.text;
    self.labelOfText.numberOfLines=0;
    //图片内容
    //1.
    NSString *str1=news.imageOne;
    NSURL *urlImage1=[NSURL URLWithString:str1];
    [self.imageViewOfOne setImageWithURL:urlImage1];
    //2.
    NSString *str2=news.imageTwo;
    NSURL *urlImage2=[NSURL URLWithString:str2];
    [self.imageViewOfTwo setImageWithURL:urlImage2];
    //3.
    NSString *str3=news.imageThree;
    NSURL *urlImage3=[NSURL URLWithString:str3];
    [self.imageViewOfThree setImageWithURL:urlImage3];
    //4.
    NSString *str4=news.imageFour;
    NSURL *urlImage4=[NSURL URLWithString:str4];
    [self.imageViewOfFour setImageWithURL:urlImage4];
    //5.
    NSString *str5=news.imageFive;
    NSURL *urlImage5=[NSURL URLWithString:str5];
    [self.imageViewOfFive setImageWithURL:urlImage5];
    //6.
    NSString *str6=news.imageSix;
    NSURL *urlImage6=[NSURL URLWithString:str6];
    [self.imageViewOfSix setImageWithURL:urlImage6];
    
    
    //转发数
    id strOfTransmit=news.reposts_count;
    
    [self.buttonOfTransmit setTitle:[NSString stringWithFormat:@"%@",strOfTransmit] forState:UIControlStateNormal];
    //评论数
    id strOfComment=news.comments_count;
    [self.buttonOfComment setTitle:[NSString stringWithFormat:@"%@",strOfComment] forState:UIControlStateNormal];
    
    
    //表态数
    id strOfPraise=news.attitudes_count;
    [self.buttonOfPraise setTitle:[NSString stringWithFormat:@"%@",strOfPraise] forState:UIControlStateNormal];
    
}



















- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
