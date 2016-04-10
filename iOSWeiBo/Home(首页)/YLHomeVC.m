//
//  YLHomeVC.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/23.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLHomeVC.h"
#import "YLMeVC.h"
#import "YLCommon.h"
#import "MBProgressHUD+YL.h"
#import "NWOAuth.h"

@interface YLHomeVC () <UIWebViewDelegate>

@end

@implementation YLHomeVC

- (void)viewDidLoad{
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面(新浪提供的登录页面)
    NSURL *url = [NSURL URLWithString:WeiBoLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

   
}

#pragma mark WebView代理方法

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessageWait:@"拼命加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    // 1.请求的URL路径: http://ios.itcast.cn/?code=0f189b682cd020e79303dbb043d4fb28
    NSString *urlStr = request.URL.absoluteString;
    
     // 2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含了code=
    if(range.length){
        
        // 4.截取code=后面的请求标记(经过用户授权成功的)
        unsigned long loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
         // 5.发送POST请求给新浪,  通过code换取一个accessToken
        [self accessTokenWithCode:code];
        
         // 不加载这个请求
        return NO;
    }
    
    return YES;
}


/**
 *  通过code换取一个accessToken
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = WeiBoAppKey;
    params[@"client_secret"] = WeiBoAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = WeiBoRedirectURI;
    
    // 2.发送请求
    [NWOAuth getAccessToken:params successCallBack:^(id data) {
//        // 4.先将字典转为模型
//        IWAccount *account = [IWAccount accountWithDict:json];
//        
//        // 5.存储模型数据
//        [IWAccountTool saveAccount:account];
//        
//        // 6.新特性\去首页
//        [IWWeiboTool chooseRootController];
        
        // 7.隐藏提醒框
        [MBProgressHUD hideHUD];
    } errorCallBack:^(long code, NSString *msg) {
        // 隐藏提醒框
        [MBProgressHUD hideHUD];
        
    } withStyle:NetworkErrorInterceptStyleSkip];


}

@end
