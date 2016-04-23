//
//  LBLOAuthViewController.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/4.
//  Copyright © 2015年 LBL. All rights reserved.
/*
 
 App Key：1147015486
 App Secret：b93d7f956b74dcb38af2ff8d57f90bde
 https://api.weibo.com/oauth2/authorize?client_id=1147015486&redirect_uri=http://www.baidu.com/
 
*/

#import "LBLOAuthViewController.h"
#import "AFNetworking.h"
#import "LBLAccount.h"
#import "LBLAccountTool.h"
#import "LBLTabBarController.h"


#define CLIENT_ID @"1147015486"

#define APP_SECRET @"b93d7f956b74dcb38af2ff8d57f90bde"

#define REDIRECT_URL @"http://www.baidu.com/"

@interface LBLOAuthViewController ()<UIWebViewDelegate>

@property (nonatomic,weak) UIWebView *webView;


@end

@implementation LBLOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    [self loadOAuthPage];
}


//加载登陆页面
- (void)loadOAuthPage{
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",CLIENT_ID,REDIRECT_URL];
    
    //初始化url
    NSURL *url = [NSURL URLWithString:urlStr];
    //初始化请求
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];
    

}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    
    NSLog(@"---%@",urlStr);
    
    //判断点击同意或取消
    if ([urlStr hasPrefix:REDIRECT_URL]) {
        
        //同意 http://www.baidu.com/?code=4ceff0acd8c7180cad170644628da4df

        //取消http://www.baidu.com/?error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330
        NSLog(@"%@",request.URL.query);
        NSString *queryStr = request.URL.query;
        
        NSString *preStr = @"code=";
        if ([queryStr hasPrefix:preStr]) {
            NSRange range = NSMakeRange(preStr.length, queryStr.length - preStr.length);
            
            NSString *code = [queryStr substringWithRange:range];
            //同意code ===== 4ceff0acd8c7180cad170644628da4df

            NSLog(@"code ===== %@",code);
            
            //获取AccessToken
            [self requestAccessTokenWithCode:code];
            
        }
        return NO;
        
        
    }
    return YES;
}

- (void)requestAccessTokenWithCode:(NSString *)code{
    //获取管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    AFJSONResponseSerializer
    
    
    NSString *urlStr = @"https://api.weibo.com/oauth2/access_token";
    
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    必选	类型及范围	说明
//    client_id	true	string	申请应用时分配的AppKey。
//    client_secret	true	string	申请应用时分配的AppSecret。
//    grant_type	true	string	请求的类型，填写authorization_code
//    
//    grant_type为authorization_code时
//    必选	类型及范围	说明
//    code	true	string	调用authorize获得的code值。
//    redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
    params[@"client_id"] = CLIENT_ID;
    params[@"client_secret"] = APP_SECRET;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = REDIRECT_URL;

    
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        LBLAccount *account = [[LBLAccount alloc] init];
        [account setValuesForKeysWithDictionary:responseObject];
        //_expires_in	NSInteger	157679999	157679999
       // account.createDate = [NSDate date];
        
        //NSLog(@"成功%@",account);
        
        //归档
        [LBLAccountTool saveAccount:account];
        //跳转主页面
        LBLTabBarController *tabbarCtrl = [[LBLTabBarController alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = tabbarCtrl;
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"失败%@",error);
    }];
}




@end
