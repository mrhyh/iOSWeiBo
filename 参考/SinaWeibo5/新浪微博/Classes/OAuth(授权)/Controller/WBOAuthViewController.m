//
//  WBOAuthViewController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/10.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "WBHTTPTool.h"
#import "WBStatusDataTool.h"

@interface WBOAuthViewController () <UIWebViewDelegate>
@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    // 设置代理
    webView.delegate =self;
    webView.frame = self.view.bounds;
    
    // 请求地址
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", WBAppKey, WBRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
    [self.view addSubview:webView];
}
#pragma mark - UIWebViewDelegate代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    WJLog(@"webViewDidFinishLoad----");
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    WJLog(@"webViewDidStartLoad-----");
    [MBProgressHUD showMessage:@"正在加载......"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    
    // http://localhost/?code=4f989d4ab20a34a7a166a91fda2acb1f

    WJLog(@"%@", url);
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止回调网址弹出
        return NO;
    }
    
    return YES;
}

/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 设置请求参数
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = WBAppKey;
    params[@"client_secret"] = WBAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = WBRedirectURI;
    params[@"code"] = code;
    
    // 发送请求
    [WBHTTPTool POST:url params:params success:^(id responseObject) {
        // 先移除蒙版
        [MBProgressHUD hideHUD];
        WJLog(@"请求成功---%@", responseObject);
        
        // 存储access_toaken
        // 字典转模型---> 存储
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        [WBAccountTool saveAccount:account];
        
        /** 切换根控制器 */
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(NSError *error) {
        WJLog(@"请求失败----%@", error);
        [MBProgressHUD hideHUD];
    }];
}
@end
