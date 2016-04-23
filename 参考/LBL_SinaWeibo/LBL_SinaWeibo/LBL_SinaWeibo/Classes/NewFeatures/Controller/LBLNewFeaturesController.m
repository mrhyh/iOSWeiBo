//
//  LBLNewFeaturesController.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/3.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLNewFeaturesController.h"
#import "LBLTabBarController.h"
#import "UIWindow+SwitchRootviewCtrl.h"

#define kPageCount 4

@interface LBLNewFeaturesController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,weak) UIPageControl *pageControl;


@end

@implementation LBLNewFeaturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpScrollView];
    
    [self setUpPageControl];
}

- (void)setUpScrollView{
    //初始化 scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = [UIColor redColor];
    
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    //NSInteger pageCount = 4;
    
    for (int i = 0; i < kPageCount; i++) {
        
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i+1];
        UIImage *image = [UIImage imageNamed:name];
        
        //初始化ImageView
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.size = scrollView.size;
        imageView.x = i * scrollView.width;
        [scrollView addSubview:imageView];
        
        if (i == kPageCount - 1) {
            [self setUpLastPageWithView:imageView];
        }
    }
    [scrollView setContentSize:CGSizeMake(kPageCount*scrollView.width, scrollView.height)];

}

/**
 *  初始化pagecontrol
 */
- (void)setUpPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kPageCount;
    pageControl.size = CGSizeMake(SCREENW, 30);
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.y = SCREENH - 100;
    
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
}
/**
 *  设置最后一页
 *
 *  @param lastView <#lastView description#>
 */
- (void)setUpLastPageWithView:(UIView *)lastView{
    lastView.userInteractionEnabled = YES;
    //初始化分享按钮
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    
    [shareBtn setTitle:@"分享到微博" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareBtn sizeToFit];
    
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.centerX = SCREENW / 2;
    shareBtn.y = SCREENH - 200;
    
    [lastView addSubview:shareBtn];
    //进入微博按钮
    UIButton *enterBtn = [[UIButton alloc] init];
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    [enterBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [enterBtn setTitle:@"进入微博" forState:UIControlStateNormal];
    
    enterBtn.size = enterBtn.currentBackgroundImage.size;
    enterBtn.centerX = shareBtn.centerX;
    enterBtn.y = CGRectGetMaxY(shareBtn.frame) + 10;
    
    [enterBtn addTarget:self action:@selector(enterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [lastView addSubview:enterBtn];
    
    
    
    
}

- (void)shareBtnClick:(UIButton *)btn{
    btn.selected = !btn.isSelected;
}

- (void)enterBtnClick:(UIButton *)btn{
    CGFloat currentVersion = [LBLUtils appVersion];
    //保存到偏好设置
    [[NSUserDefaults standardUserDefaults] setObject:@(currentVersion) forKey:KEY_VERSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //进入主页
    //LBLTabBarController *tabBarCtrl = [[LBLTabBarController alloc] init];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
   // [window setRootViewController:tabBarCtrl];
    [window switchRootviewCtrl];
    
    
    
    
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"%f",scrollView.contentOffset.x);
    
    CGFloat page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
    
}




@end
