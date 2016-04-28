//
//  WBEmotionListView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionListView.h"
#import "WBEmotionSinglePageView.h"

@interface WBEmotionListView () <UIScrollViewDelegate>
/** 可滚动、显示部分 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 指示器 */
@property (nonatomic, weak) UIPageControl *pageControl;
/** 最近使用表情 */
@property (nonatomic, weak) UILabel *recentEmotionTip;
@end

@implementation WBEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景颜色
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加scollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        // 去除边缘弹簧效果，到边缘就不可拉伸
        scrollView.bounces = NO;
        
        scrollView.pagingEnabled = YES;
        // 去掉水平和垂直方向的滚动控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        // 设置代理
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 指示器
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        
        // 设置单页就不显示
        pageControl.hidesForSinglePage = YES;
        // 设置圆点
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        // 最近使用表情提示
        UILabel *recentEmotionTip = [[UILabel alloc] init];
        recentEmotionTip.textColor = [UIColor grayColor];
        recentEmotionTip.text = @"最近使用表情";
        recentEmotionTip.font = [UIFont systemFontOfSize:13];
        recentEmotionTip.textAlignment = NSTextAlignmentCenter;
        [self addSubview:recentEmotionTip];
        
        
        self.recentEmotionTip = recentEmotionTip;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    // 移除所有表情
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
//    WJLog(@"%ld", emotions.count);
    // 显示页数
    NSUInteger pageNumber = (emotions.count + WBEmotionNumbersPerPage - 1) / WBEmotionNumbersPerPage;
    
    self.pageControl.numberOfPages = pageNumber;
    
    for (NSUInteger i=0; i<pageNumber; i++) {
        // 增加每页显示表情的控件
        WBEmotionSinglePageView *singlePageView = [[WBEmotionSinglePageView alloc] init];
        // 给每页显示表情的singlePageView传递模型
        NSRange range = NSMakeRange(i * WBEmotionNumbersPerPage, WBEmotionNumbersPerPage);
        
        // 不足一页的计算
        NSUInteger leftEmotion = emotions.count - range.location;
        if (leftEmotion < WBEmotionNumbersPerPage) {
            range.length = leftEmotion;
        }
        singlePageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:singlePageView];
    }
    // 重新计算frame
    [self setNeedsLayout];
}

/** 布局子控件 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 底部宽度
    CGFloat bottomHeight = 35;
    
    // pageControl
    self.pageControl.height = bottomHeight;
    self.pageControl.width = self.scrollView.width;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // scrollView
    self.scrollView.width = self.width;
    self.scrollView.x = self.scrollView.y = 0;
    self.scrollView.height = self.height - bottomHeight;
    
    // scrollView子控件个数
    NSUInteger pageNumber = self.scrollView.subviews.count;
    for (NSUInteger i=0; i<pageNumber; i++) {
        // 增加每页显示表情的控件
        WBEmotionSinglePageView *singlePageView = self.scrollView.subviews[i];
        singlePageView.y = 0;
        singlePageView.x = i * self.scrollView.width;
        singlePageView.width = self.scrollView.width;
        singlePageView.height = self.scrollView.height;
    }
    
    // 设置scrolView滚动范围
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * pageNumber, 0);
    
    // 最近使用表情
    self.recentEmotionTip.height = 35;
    self.recentEmotionTip.width = self.scrollView.width;
    self.recentEmotionTip.x = 0;
    self.recentEmotionTip.y = self.height - bottomHeight;
}
- (void)setHidePageControl:(BOOL)hidePageControl
{
    _hidePageControl = hidePageControl;
    
    if (self.isHihhenPageControl) { // 移除页码指示器
        [self.pageControl removeFromSuperview];
    } else {    // 移除最近显示表情
        [self.recentEmotionTip removeFromSuperview];
    }
}

#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置指示器页码指示
    double page = self.scrollView.contentOffset.x / self.scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}
@end
