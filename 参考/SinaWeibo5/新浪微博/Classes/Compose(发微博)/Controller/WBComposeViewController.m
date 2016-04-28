//
//  WBComposeViewController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/14.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBEmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "WBComposeToolBar.h"
#import "WBComposePhotosView.h"
#import "WBEmotionKeyboard.h"
#import "WBEmotion.h"
#import "WBHTTPTool.h"

@interface WBComposeViewController () <UITextViewDelegate, WBComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 输入框 */
@property (nonatomic, weak) WBEmotionTextView *textView;
/** 工具条 */
@property (nonatomic, weak) WBComposeToolBar *toolBar;
/** 相册 */
@property (nonatomic, weak) WBComposePhotosView *photosView;
/** 表情键盘 */
@property (nonatomic, strong) WBEmotionKeyboard *emotionKeyboard;
/** 标记是否正在切换键盘 */
@property (nonatomic, assign, getter=isSwitchingKeyboard) BOOL switchingKeyboard;
@end

@implementation WBComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置输入框
    [self setupTextView];
    
    // 设置工具条
    [self setupToolBar];
    
    // 设置相册
    [self setupAlbum];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 设置导航栏
    [self setupNavigation];
    
    // 用户进这里就是为了发微博，所以设置输入框为第一响应者
    [self.textView becomeFirstResponder];
    
    // 显示前先检测是否有文字设置按键是否可用
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - 懒加载
- (WBEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[WBEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
    }
    return _emotionKeyboard;
}
#pragma mark - 初始化控件
/** 设置相册 */
- (void)setupAlbum
{
    WBComposePhotosView *photosView = [[WBComposePhotosView alloc] init];
    photosView.x = 10;
    photosView.y = 100;
    photosView.width = self.view.width - 20;
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

/** 设置工具条 */
- (void)setupToolBar
{
    WBComposeToolBar *toolBar = [[WBComposeToolBar alloc] init];
    toolBar.x = 0;
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.y = self.view.height - toolBar.height;
    // 设置代理
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    // 为使键盘退下工具条能停留在窗口底部，故此反感不可行
//    self.textView.inputAccessoryView = toolBar;
}
/** 设置输入框 */
- (void)setupTextView
{
    WBEmotionTextView *textView = [[WBEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事......";
    textView.font = [UIFont systemFontOfSize:16];
    // 设置输入框垂直方向始终可伸缩
    textView.alwaysBounceVertical = YES;
    self.textView = textView;
    textView.delegate = self;
    [self.view addSubview:textView];
    
    // 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:textView];
    
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 监听表情按钮被按下
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionButtonDidClicked:) name:WBEmotionButtonDidClickedNotification object:nil];
    
    // 监听表情删除删除按钮
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDeleteButtonDidClicked) name:WBEmotionDeleteButtonDidClickedNotification object:nil];
}

/** 设置导航栏 */
- (void)setupNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 设置titleView
    NSString *prefixStr = @"发微博";
    NSString *username = [WBAccountTool account].username;
    if (username) {
        UILabel *labelView = [[UILabel alloc] init];
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefixStr, username];
        NSMutableAttributedString *attrsStr = [[NSMutableAttributedString alloc] initWithString:str];
        NSRange prefixRange = [str rangeOfString:prefixStr];
        NSRange nameRange = [str rangeOfString:username];
        [attrsStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:prefixRange];
        [attrsStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:nameRange];
        [attrsStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:nameRange];
        labelView.numberOfLines = 0;
        labelView.textAlignment = NSTextAlignmentCenter;
        labelView.attributedText = attrsStr;
        labelView.width = 200;
        labelView.height = 35;
        self.navigationItem.titleView = labelView;
    } else {
        self.title = prefixStr;
    }
    
}
#pragma mark - 自定义方法
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 发送有图片微博 */
- (void)composeWithImage
{
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic true binary 微博的配图。*/
    /**	access_token true string*/
    // 获得请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 设置请求参数
    NSString *url = @"https://upload.api.weibo.com/2/statuses/upload.json";
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.fullText;
    // 取出最前面的微博（最新的微博，ID最小的微博）
    // 发送请求
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 取出图片
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"pretty.jpg" mimeType:@"image/jpeg"];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 提示用户成功
        [MBProgressHUD showSuccess:@"发送成功"];
        WJLog(@"请求成功----");
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        WJLog(@"请求失败----%@", error);
        // 提示用户失败
        [MBProgressHUD showSuccess:@"发送失败"];
    }];
}
/** 发送没有图片微博 */
- (void)composeWithoutImage
{
    // 设置请求参数
    NSString *url = @"https://api.weibo.com/2/statuses/update.json";
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.fullText;
    // 取出最前面的微博（最新的微博，ID最小的微博）
    // 发送请求
    [WBHTTPTool POST:url params:params success:^(id responseObject) {
        // 提示用户成功
        [MBProgressHUD showSuccess:@"发送成功"];
        WJLog(@"请求成功----");
    } failure:^(NSError *error) {
        WJLog(@"请求失败----%@", error);
        // 提示用户失败
        [MBProgressHUD showSuccess:@"发送失败"];
    }];
}
- (void)send
{
    if (self.photosView.photos.count) { // 有图片
        [self composeWithImage];
    } else {
        [self composeWithoutImage];
    }
    // 移除当前控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 监听方法
/** 监听表情删除按钮被按下 */
- (void)emotionDeleteButtonDidClicked
{
    // 调用系统方法
    [self.textView deleteBackward];
}

/** 监听表情按钮被按下 */
- (void)emotionButtonDidClicked:(NSNotification *)notification
{
    // 取出表情模型
    WBEmotion *emotion = notification.userInfo[WBEmotionButtonDidClickedKey];
    
    // 插入表情
    [self.textView insertEmotion:emotion];
    
    // 解决默认图片表情被选中不触发监听textView文字改变的通知，主动触发设置发送按钮的enable
    [self textChanged];
   }

/** 监听文字改变 */
- (void)textChanged
{
    // 有文字就可以点击
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

/** 监听键盘尺寸变化 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 如果正在切换键盘就不要变换工具条的位置
    if (self.isSwitchingKeyboard == YES) return;
    
   NSDictionary *userInfo =  notification.userInfo;
    // 键盘弹出、隐藏动画持续时间
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘弹出、隐藏的最终的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画改变工具条y值
    [UIView animateWithDuration:duration animations:^{
        // 工具条Y值 = 键盘的Y值 - 工具条的高度
        self.toolBar.y = keyboardF.origin.y - self.toolBar.height;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - UIImagePickerControllerDelegate代理方法
/** 选择完图片后调用 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 移除控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 拿到图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
    //    WJLog(@"%@", info);
    

}
#pragma mark - WBComposeToolBarDelegate代理方法
/** 点击了工具条按钮 */
- (void)composeToolBar:(WBComposeToolBar *)toolrBar didClickedButton:(WBComposeToolBarButtonType)buttonType
{
    switch (buttonType) {
        case WBComposeToolBarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case WBComposeToolBarButtonTypeAlbum: // 相册
            [self openAlbum];
            break;
            
        case WBComposeToolBarButtonTypeMention: // @
            WJLog(@"提及@");
            break;
            
        case WBComposeToolBarButtonTypeTrend: // #
            WJLog(@"话题#");
            break;
            
        case WBComposeToolBarButtonTypeEmotion: // 表情
            // 切换键盘
            [self switchKeyboard];
            break;
    }
}

#pragma mark - 私有方法
/** 切换键盘 */
- (void)switchKeyboard
{
    if (self.textView.inputView == nil) {   // 切换为表情键盘
        self.textView.inputView = self.emotionKeyboard;
        self.toolBar.showEmotionButton = YES;
    } else {    // 切换为系统键盘
        self.textView.inputView = nil;
        self.toolBar.showEmotionButton = NO;
    }
    // 标记开始切换键盘
    self.switchingKeyboard = YES;
    // 结束编辑
    [self.textView endEditing:YES];
    
    // 标记结束切换键盘
    self.switchingKeyboard = NO;
    
    // 成为第一响应者叫除键盘
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
   
}

/** 打开相机 */
- (void)openCamera
{
    [self chooseImageFrom:UIImagePickerControllerSourceTypeCamera];
}

/** 打开相册 */
- (void)openAlbum
{
    [self chooseImageFrom:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)chooseImageFrom:(UIImagePickerControllerSourceType)sourceType
{
    // 先判断可用，不可用直接返回
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = sourceType;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
@end
