//
//  UserViewController.m
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/29.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import "UserViewController.h"
#import "HomeNews.h"
#import "DataManager.h"
#import "HomeTextCell.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
@interface UserViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOfBackground;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *labelOfName;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfSex;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfVip;
@property (strong, nonatomic) IBOutlet UILabel *labelOfFocus;
@property (strong, nonatomic) IBOutlet UILabel *labelOfFans;
@property (strong, nonatomic) IBOutlet UILabel *labelOfIdentity;
@property (strong, nonatomic) IBOutlet UIImageView *imageViewOfButton;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfWeibo;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfHomepage;
@property (strong, nonatomic) IBOutlet UIButton *buttonOfAlbum;

@end

@implementation UserViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.buttonOfHeadImage.layer.cornerRadius=25;
    self.buttonOfHeadImage.clipsToBounds=YES;
    [self.buttonOfHeadImage setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:self.userHeadImage]];
    self.labelOfName.text=self.userName;
    self.labelOfName.numberOfLines=0;
    //性别配置
    NSString *str=self.userGender;
    if ([str isEqualToString:@"m"])
    {
        [self.buttonOfSex setBackgroundImage:[UIImage imageNamed:@"userinfo_gender_male"] forState:UIControlStateNormal];
    }
    else if ([str isEqualToString:@"f"])
    {
        [self.buttonOfSex setBackgroundImage:[UIImage imageNamed:@"userinfo_gender_female"] forState:UIControlStateNormal];
    }
    else
    {
        [self.buttonOfSex setBackgroundColor:[UIColor whiteColor]];
    }
    //是否是VIP
    id vip=self.userVip;
    if ([vip isEqual:@0])
    {
        [self.buttonOfVip setBackgroundImage:[UIImage imageNamed:@"common_icon_membership_expired"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.buttonOfVip setBackgroundImage:[UIImage imageNamed:@"common_icon_membership"] forState:UIControlStateNormal];
    }

    
    id focus=self.focusCounts;
    NSString *strOfFocus=[NSString stringWithFormat:@"关注 %@",focus];
    self.labelOfFocus.text=strOfFocus;
    id fans=self.fansCounts;
    NSString *strOfFans=[NSString stringWithFormat:@"粉丝 %@",fans];
    self.labelOfFans.text=strOfFans;
    self.labelOfIdentity.numberOfLines=0;
    self.labelOfIdentity.text=self.descript;
    
    
    
    [self.buttonOfWeibo setTitle:@"微博" forState:UIControlStateNormal];
    [self.buttonOfWeibo addTarget:self action:@selector(tapButtonOfWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonOfHomepage setTitle:@"主页" forState:UIControlStateNormal];
    [self.buttonOfHomepage addTarget:self action:@selector(buttonOfHomepage:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonOfAlbum setTitle:@"相册" forState:UIControlStateNormal];
    [self.buttonOfAlbum addTarget:self action:@selector(buttonOfAlbum:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)tapButtonOfWeibo:(UIButton *)sender
{
    [self.buttonOfWeibo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.buttonOfHomepage setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buttonOfAlbum setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (IBAction)buttonOfHomepage:(UIButton *)sender
{
    [self.buttonOfHomepage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.buttonOfWeibo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buttonOfAlbum setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (IBAction)buttonOfAlbum:(UIButton *)sender
{
    [self.buttonOfAlbum setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.buttonOfHomepage setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buttonOfWeibo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
}




@end
