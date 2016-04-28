//
//  WBNewFeatureViewController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/9.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBNewFeatureViewController.h"
#import "WBTabBarViewController.h"

#define WBNewFeatureImageCount 4

@interface WBNewFeatureViewController () <UIScrollViewDelegate>
/**
 *  pageControl
 */
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation WBNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 窗口的尺寸
    CGFloat screenW = self.view.width;
    CGFloat screenH = self.view.height;
    
    // 创建scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.contentSize = CGSizeMake(WBNewFeatureImageCount * screenW, 0);
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES; /* 自动分页 */
    scrollView.showsHorizontalScrollIndicator = NO; /* 不允许竖直方向滚动 */
    scrollView.bounces = NO;    /* 关闭边缘滚动弹簧效果 */
    // 设置代理，监听滚定位置设置分页
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 添加图片
    for (int i = 0; i<WBNewFeatureImageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.width = screenW;
        imageView.height = screenH;
        imageView.x = i * screenW;
        [scrollView addSubview:imageView];
        
        if (i == WBNewFeatureImageCount -1) {   // 最后一张图片
            [self setupLastImageView:imageView];
        }
    }
    // 添加pageController
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = WBNewFeatureImageCount;
    pageControl.currentPageIndicatorTintColor = WBColor(253, 98, 42, 1);
    pageControl.pageIndicatorTintColor = WBColor(189, 189, 189, 1);
    pageControl.centerX = screenW * 0.5;
    pageControl.y = screenH - 50;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    
}

/**
 *     设置最后一个imageView
 *
 *     @param imageView scrollView的最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 设置图片（父控件）能交互
    imageView.userInteractionEnabled = YES;
    
    // 分享给大家按钮
    UIButton *shareBtn = [[UIButton alloc] init];
    // 设置状态图片和文字属性
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // 设置子控件内边距
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    // 按钮监听
    [shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.width = 150;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [imageView addSubview:shareBtn];
    
    // 开始微博按钮
    UIButton *startBtn = [[UIButton alloc] init];
    // 设置状态图片和文字属性
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    
    // 事件监听
    [startBtn addTarget:self action:@selector(startBntClicked) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

/**
 *     点击了分享给大家按钮
 */
- (void)shareBtnClicked:(UIButton *)btn
{
    // 状态取反
    btn.selected = !btn.isSelected;
}

/**
 *     点击了开始微博按钮
 */
- (void)startBntClicked
{
    // 获取主窗口
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    
    // 切换根控制器，销毁新特性界面
    mainWindow.rootViewController = [[WBTabBarViewController alloc] init];
}

#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   CGFloat page =  scrollView.contentOffset.x / scrollView.width;
//    WJLog(@"%f", page);
    self.pageControl.currentPage = (int)(page + 0.5);
}

- (void)dealloc
{
    WJLog(@"新特性界面控制器已挂-----dealloc");
}
@end
