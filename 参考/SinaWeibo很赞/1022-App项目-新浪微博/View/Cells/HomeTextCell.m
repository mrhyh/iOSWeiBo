//
//  HomeCell.m
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/22.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import "HomeTextCell.h"
#import "UIButton+AFNetworking.h"
#import "UITableViewCell+Config.h"
#import "UserViewController.h"
#import "UserViewController.h"
#import "UIImageView+AFNetworking.h"
@interface HomeTextCell ()
@property (strong, nonatomic) IBOutlet UIButton *buttonOfHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *labelOfUserName;
@property (strong, nonatomic) IBOutlet UILabel *labelOfTime;
@property (strong, nonatomic) IBOutlet UILabel *labelOfSource;
@property (strong, nonatomic) IBOutlet UILabel *labelOfText;
@property (strong, nonatomic) IBOutlet UILabel *labelOfTransmitText;
@property (strong, nonatomic) IBOutlet UIView *viewOfTransmitText;


@property (strong, nonatomic) IBOutlet UIButton *buttonOfTransmit;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfComment;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfPraise;
@property (nonatomic,strong) TapButtonOfHeadImageBlock bBlock;


@end
@implementation HomeTextCell


-(void)configHomeCell:(HomeNews *)news
{
    
    
    
    //给button配置头像
    NSString *str=news.profile_image_url;
    NSURL *url=[NSURL URLWithString:str];
    self.buttonOfHeadImage.layer.cornerRadius=25;
    self.buttonOfHeadImage.clipsToBounds=YES;
    [self.buttonOfHeadImage setBackgroundImageForState:UIControlStateNormal withURL:url];
    //给label配置用户名
    self.labelOfUserName.text=news.screen_name;
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
    NSString *strOfSource=news.source;
    NSArray *arrOfSource=[strOfSource componentsSeparatedByString:@">"];
    
    NSString *strOfSource1=arrOfSource[1];
    
    NSArray *arrOfSource1=[strOfSource1 componentsSeparatedByString:@"<"];
    
    NSString *strOfSourceFinal=[NSString stringWithFormat:@"来自 %@",arrOfSource1[0]];
    
    self.labelOfSource.text=strOfSourceFinal;
    
    
    //用户所在地
   // self.labelOfSource.text=news.location;
   // 发布内容
    self.labelOfText.text=news.text;
    self.labelOfText.numberOfLines=0;
    
    if (news.retweeted_status&&news.transmitImageOne==nil)
    {
        //被转发人的微博名字
        NSString *strOfTransmitScreen_name=[NSString stringWithFormat:@"@%@:",news.transmitScreen_name];
        //被转发人得内容
        NSString *strOfTransmitText=news.transmitText;
        
        NSString *strOfTransmitTextFinal=[NSString stringWithFormat:@"%@%@",strOfTransmitScreen_name,strOfTransmitText];
        //转发内容
        self.labelOfTransmitText.text=strOfTransmitTextFinal;
        self.labelOfTransmitText.numberOfLines=0;
   
    }
    else
    {
        
        self.viewOfTransmitText.hidden=YES ;   //如果不是转发,把View隐藏掉
        [self.labelOfTransmitText removeFromSuperview]; //把label移除掉
        
    
    }

    
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

//接收外界的代码,存在属性中
-(void)setTapButtonOfHeadImageBlock:(TapButtonOfHeadImageBlock)aBlock
{
    self.bBlock=aBlock;
}

- (IBAction)tapButtonOfHeadImage:(UIButton *)sender
{
   //点击按钮执行属性存储的block
    if (self.bBlock)
    {
        self.bBlock(nil);
    }
  
}









- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
