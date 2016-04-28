//
//  UserDetailsViewController.m
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/11/6.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "UIWebView+AFNetworking.h"
@interface UserDetailsViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *WebViewOfUserDetails;


@end

@implementation UserDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableString *mstr=[NSMutableString stringWithFormat:@"http://weibo.com/u/%@",self.idOfUser];
    NSURL *url=[NSURL URLWithString:mstr];
    NSLog(@"%@",url);
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    [self.WebViewOfUserDetails loadRequest:req];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
