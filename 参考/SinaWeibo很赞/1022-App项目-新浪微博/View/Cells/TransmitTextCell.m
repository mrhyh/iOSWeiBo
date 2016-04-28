//
//  TransmitImageCell.m
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/11/3.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import "TransmitTextCell.h"
#import "UITableViewCell+Config.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface TransmitTextCell ()
@property (strong, nonatomic) IBOutlet UIButton *buttonOfHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *labelOfName;
@property (strong, nonatomic) IBOutlet UILabel *labelOfTime;
@property (strong, nonatomic) IBOutlet UILabel *labelOfAddress;
@property (strong, nonatomic) IBOutlet UILabel *labelOfText;
@property (strong, nonatomic) IBOutlet UILabel *labelOfTransmitText;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewFour;

@property (strong, nonatomic) IBOutlet UIImageView *imageViewFive;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewSix;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewSeven;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewEight;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewNine;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfTransmit;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfComment;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfPraise;


@end
@implementation TransmitTextCell

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
    //被转发人的内容
    
    //被转发人的微博名字
    NSString *strOfTransmitScreen_name=[NSString stringWithFormat:@"@%@:",news.transmitScreen_name];
    //被转发人得内容
    NSString *strOfTransmitText=news.transmitText;
    
    NSString *strOfTransmitTextFinal=[NSString stringWithFormat:@"%@%@",strOfTransmitScreen_name,strOfTransmitText];
    //转发内容
    self.labelOfTransmitText.text=strOfTransmitTextFinal;
    self.labelOfTransmitText.numberOfLines=0;
    
    
    //图片内容
    //1.
    NSString *str1=news.transmitImageOne;
    NSURL *urlImage1=[NSURL URLWithString:str1];
    [self.imageViewOne sd_setImageWithURL:urlImage1];
    [self.imageViewOne sd_setImageWithURL:urlImage1 placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    //2.
    NSString *str2=news.transmitImageTwo;
    NSURL *urlImage2=[NSURL URLWithString:str2];
    [self.imageViewTwo sd_setImageWithURL:urlImage2];
    //3.
    NSString *str3=news.transmitImageThree;
    NSURL *urlImage3=[NSURL URLWithString:str3];
    [self.imageViewThree sd_setImageWithURL:urlImage3];
    //4.
    NSString *str4=news.transmitImageFour;
    NSURL *urlImage4=[NSURL URLWithString:str4];
    if (str4==nil)
    {
        
          [self.imageViewFour sd_setImageWithURL:urlImage4];
    }
    else
    {
    
        [self.imageViewFour sd_setImageWithURL:urlImage4 placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    }

    //5.
    NSString *str5=news.transmitImageFive;
    NSURL *urlImage5=[NSURL URLWithString:str5];
    [self.imageViewFive sd_setImageWithURL:urlImage5];
    //6.
    NSString *str6=news.transmitImageSix;
    NSURL *urlImage6=[NSURL URLWithString:str6];
    [self.imageViewSix sd_setImageWithURL:urlImage6];
    //7.
    NSString *str7=news.transmitImageSeven;
    NSURL *urlImage7=[NSURL URLWithString:str7];
   
    if (urlImage7==nil)
    {
        
         [self.imageViewSeven sd_setImageWithURL:urlImage7];
    }
    else
    {
    [self.imageViewSeven sd_setImageWithURL:urlImage7 placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    }
    //8.
    NSString *str8=news.transmitImageEight;
    NSURL *urlImage8=[NSURL URLWithString:str8];
    [self.imageViewEight sd_setImageWithURL:urlImage8];
    //9.
    NSString *str9=news.transmitImageNine;
    NSURL *urlImage9=[NSURL URLWithString:str9];
    [self.imageViewNine sd_setImageWithURL:urlImage9];
   
   
    
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


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
