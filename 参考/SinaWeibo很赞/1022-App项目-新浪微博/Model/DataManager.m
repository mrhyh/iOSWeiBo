//
//  DataManager.m
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/22.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import "DataManager.h"
#import "HomeTextCell.h"
#import "SVProgressHUD.h"
#import "HomeNews.h"


@interface DataManager ()
@property (nonatomic,strong) AFHTTPRequestOperationManager *manager;

@end
@implementation DataManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.manager=[AFHTTPRequestOperationManager manager];
        self.manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    }
    return self;
}
+(instancetype)shareManager
{
    
    static DataManager *man=nil;
    static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    
    man=[DataManager new];
});
    return man;
}
-(void)requestNewsWithsuccessHome:(SuccessBlock)sBlock
                       failedHome:(FailedBlock)fBlock
{
    
    //等待提示框
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:@"加载中...."];
    
   
    //请求数据
    AFHTTPRequestOperation *op=[self.manager GET:kUrl parameters:@{@"access_token":@"2.00aEXeZDyhSCeB27395cfea20v93Rw"} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         //Json解析
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        //status是否返回数据,0成功,1失败
        NSString *status=[NSString stringWithFormat:@"%@",dic[@"statuses"]];
        if (status.intValue==1)
        {
            
            return ; //结束后需操作
        }
     
      NSMutableArray *marr=[NSMutableArray new];
       NSArray *arr=dic[@"statuses"];
        
       NSUInteger maxpage=arr.count;
        
      [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
          HomeNews *news=[HomeNews new];
            
          NSDictionary *user = obj[@"user"];
           
    
          news.user=obj[@"user"]; //取出数组中的字典
         
          news.profile_image_url=user[@"profile_image_url"]; //取出字典中对应的用户信息
          news.idOfUser=user[@"id"];
          news.screen_name=user[@"screen_name"];
          news.profile_url=user[@"profile_url"];
          news.location=user[@"location"];
          news.gender=user[@"gender"];
          news.verified=user[@"verified"];
          news.friends_count=user[@"friends_count"];
          news.followers_count=user[@"followers_count"];
          news.descript=user[@"description"];
            
        
           NSArray *imageArr=obj[@"pic_urls"];
           
            switch (imageArr.count) {
                case 0:
                    
                    break;
                case 1:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    break;
                case 2:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    news.imageTwo=[imageArr[1] objectForKey:@"thumbnail_pic"];
                    break;
                case 3:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    news.imageTwo=[imageArr[1] objectForKey:@"thumbnail_pic"];
                    news.imageThree=[imageArr[2] objectForKey:@"thumbnail_pic"];
                    break;
                case 4:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    news.imageTwo=[imageArr[1] objectForKey:@"thumbnail_pic"];
                    news.imageThree=[imageArr[2] objectForKey:@"thumbnail_pic"];
                    news.imageFour=[imageArr[3] objectForKey:@"thumbnail_pic"];
                    break;
                case 5:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    news.imageTwo=[imageArr[1] objectForKey:@"thumbnail_pic"];
                    news.imageThree=[imageArr[2] objectForKey:@"thumbnail_pic"];
                    news.imageFour=[imageArr[3] objectForKey:@"thumbnail_pic"];
                    news.imageFive=[imageArr[4] objectForKey:@"thumbnail_pic"];
                    break;
                case 6:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    news.imageTwo=[imageArr[1] objectForKey:@"thumbnail_pic"];
                    news.imageThree=[imageArr[2] objectForKey:@"thumbnail_pic"];
                    news.imageFour=[imageArr[3] objectForKey:@"thumbnail_pic"];
                    news.imageFive=[imageArr[4] objectForKey:@"thumbnail_pic"];
                    news.imageSix=[imageArr[5] objectForKey:@"thumbnail_pic"];
                    break;
                case 7:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    news.imageTwo=[imageArr[1] objectForKey:@"thumbnail_pic"];
                    news.imageThree=[imageArr[2] objectForKey:@"thumbnail_pic"];
                    news.imageFour=[imageArr[3] objectForKey:@"thumbnail_pic"];
                    news.imageFive=[imageArr[4] objectForKey:@"thumbnail_pic"];
                    news.imageSix=[imageArr[5] objectForKey:@"thumbnail_pic"];
                    news.imageSeven=[imageArr[6] objectForKey:@"thumbnail_pic"];
                    
                    break;
                case 8:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    news.imageTwo=[imageArr[1] objectForKey:@"thumbnail_pic"];
                    news.imageThree=[imageArr[2] objectForKey:@"thumbnail_pic"];
                    news.imageFour=[imageArr[3] objectForKey:@"thumbnail_pic"];
                    news.imageFive=[imageArr[4] objectForKey:@"thumbnail_pic"];
                    news.imageSix=[imageArr[5] objectForKey:@"thumbnail_pic"];
                    news.imageSeven=[imageArr[6] objectForKey:@"thumbnail_pic"];
                    news.imageEight=[imageArr[7] objectForKey:@"thumbnail_pic"];
                    break;
                case 9:
                    news.imageOne=[imageArr[0] objectForKey:@"thumbnail_pic"];
                    news.imageTwo=[imageArr[1] objectForKey:@"thumbnail_pic"];
                    news.imageThree=[imageArr[2] objectForKey:@"thumbnail_pic"];
                    news.imageFour=[imageArr[3] objectForKey:@"thumbnail_pic"];
                    news.imageFive=[imageArr[4] objectForKey:@"thumbnail_pic"];
                    news.imageSix=[imageArr[5] objectForKey:@"thumbnail_pic"];
                    news.imageSeven=[imageArr[6] objectForKey:@"thumbnail_pic"];
                    news.imageEight=[imageArr[7] objectForKey:@"thumbnail_pic"];
                    news.imageNine=[imageArr[8] objectForKey:@"thumbnail_pic"];
                    break;
       
                    
                default:
                    break;
            }
        
          news.created_at=obj[@"created_at"];
          news.text=obj[@"text"];
          news.source=obj[@"source"];
            
            news.retweeted_status=obj[@"retweeted_status"];//转发的信息
           
            if (news.retweeted_status)   //如果数据存在
            {
                
           
    
            NSDictionary *transmit=obj[@"retweeted_status"];
            news.transmitText=transmit[@"text"];
            
            NSDictionary *transmitOfUser=transmit[@"user"];
            
            news.transmitScreen_name=transmitOfUser[@"screen_name"];
            //用一个数组去接收被转发用户的图片
            NSArray *transmitOfImage=transmit[@"pic_urls"];
                switch (transmitOfImage.count) {
                    case 0:
                        
                        break;
                    case 1:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        break;
                    case 2:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        news.transmitImageTwo=[transmitOfImage[1] objectForKey:@"thumbnail_pic"];
                        break;
                    case 3:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        news.transmitImageTwo=[transmitOfImage[1] objectForKey:@"thumbnail_pic"];
                        news.transmitImageThree=[transmitOfImage[2] objectForKey:@"thumbnail_pic"];
                        break;
                    case 4:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        news.transmitImageTwo=[transmitOfImage[1] objectForKey:@"thumbnail_pic"];
                        news.transmitImageThree=[transmitOfImage[2] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFour=[transmitOfImage[3] objectForKey:@"thumbnail_pic"];
                        break;
                    case 5:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        news.transmitImageTwo=[transmitOfImage[1] objectForKey:@"thumbnail_pic"];
                        news.transmitImageThree=[transmitOfImage[2] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFour=[transmitOfImage[3] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFive=[transmitOfImage[4] objectForKey:@"thumbnail_pic"];
                        break;
                    case 6:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        news.transmitImageTwo=[transmitOfImage[1] objectForKey:@"thumbnail_pic"];
                        news.transmitImageThree=[transmitOfImage[2] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFour=[transmitOfImage[3] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFive=[transmitOfImage[4] objectForKey:@"thumbnail_pic"];
                        news.transmitImageSix=[transmitOfImage[5] objectForKey:@"thumbnail_pic"];
                        break;
                    case 7:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        news.transmitImageTwo=[transmitOfImage[1] objectForKey:@"thumbnail_pic"];
                        news.transmitImageThree=[transmitOfImage[2] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFour=[transmitOfImage[3] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFive=[transmitOfImage[4] objectForKey:@"thumbnail_pic"];
                        news.transmitImageSix=[transmitOfImage[5] objectForKey:@"thumbnail_pic"];
                        news.transmitImageSeven=[transmitOfImage[6] objectForKey:@"thumbnail_pic"];
                        
                        break;
                    case 8:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        news.transmitImageTwo=[transmitOfImage[1] objectForKey:@"thumbnail_pic"];
                        news.transmitImageThree=[transmitOfImage[2] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFour=[transmitOfImage[3] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFive=[transmitOfImage[4] objectForKey:@"thumbnail_pic"];
                        news.transmitImageSix=[transmitOfImage[5] objectForKey:@"thumbnail_pic"];
                        news.transmitImageSeven=[transmitOfImage[6] objectForKey:@"thumbnail_pic"];
                        news.transmitImageEight=[transmitOfImage[7] objectForKey:@"thumbnail_pic"];
                        break;
                    case 9:
                        news.transmitImageOne=[transmitOfImage[0] objectForKey:@"thumbnail_pic"];
                        news.transmitImageTwo=[transmitOfImage[1] objectForKey:@"thumbnail_pic"];
                        news.transmitImageThree=[transmitOfImage[2] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFour=[transmitOfImage[3] objectForKey:@"thumbnail_pic"];
                        news.transmitImageFive=[transmitOfImage[4] objectForKey:@"thumbnail_pic"];
                        news.transmitImageSix=[transmitOfImage[5] objectForKey:@"thumbnail_pic"];
                        news.transmitImageSeven=[transmitOfImage[6] objectForKey:@"thumbnail_pic"];
                        news.transmitImageEight=[transmitOfImage[7] objectForKey:@"thumbnail_pic"];
                        news.transmitImageNine=[transmitOfImage[8] objectForKey:@"thumbnail_pic"];
                        break;
                        
                        
                    default:
                        break;
                }
  
                
                
                
            
           }
          
          
        
          news.reposts_count= [NSString stringWithFormat:@"%@",obj[@"reposts_count"]];
          news.comments_count=[NSString stringWithFormat:@"%@",obj[@"comments_count"]];
          news.attitudes_count=[NSString stringWithFormat:@"%@",obj[@"attitudes_count"]];
            
           
          [marr addObject:news];  //可变数组里面加对象news
          
      }];
        if (sBlock)
        {
            
            sBlock(marr,maxpage);
            [SVProgressHUD dismiss];
        }
        
       
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error)
    {
        
        fBlock(error);
        [SVProgressHUD dismiss];
    }];
    
     [op start];
    
}

@end
