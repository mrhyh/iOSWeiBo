//
//  WBEmotionSinglePageView.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/16.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBEmotionSinglePageView.h"
#import "WBEmotion.h"
#import "WBEmotionPopView.h"
#import "WBEmotionButton.h"
#import "WBEmotionTool.h"

@interface WBEmotionSinglePageView ()
/** 放大镜,只需要创建一次 */
@property (nonatomic, strong) WBEmotionPopView *popView;
/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;
@end


@implementation WBEmotionSinglePageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        // 设置图片
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        // 监听点击
        [deleteButton addTarget:self action:@selector(deleteClicked) forControlEvents:UIControlEventTouchUpInside];
        
        // 手势监听
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressedSinglePageView:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

#pragma mark - 懒加载
- (WBEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [WBEmotionPopView popView];
    }
    return _popView;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
//    WJLog(@"%zd", emotions.count);
    NSUInteger emotionNumber = emotions.count;
    
    for (NSUInteger i = 0; i<emotionNumber; i++) {
        WBEmotionButton *emotionButton = [[WBEmotionButton alloc] init];
        
        // 给emotionButton传递模型
        emotionButton.emotion = emotions[i];
                
        // 监听按钮点击
        [emotionButton addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:emotionButton];
    }
}

/**
 *     布局表情
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 10;
    CGFloat btnMargin = 5;
    CGFloat btnW = (self.width - 2 * inset - (WBEmotionMaxCols - 1) * btnMargin) / WBEmotionMaxCols;
    CGFloat btnH = (self.height - inset - (WBEmotionMaxRows - 1) * btnMargin) / WBEmotionMaxRows;
    NSUInteger emotionNumber = self.subviews.count - 1;
    
    for (NSUInteger i = 0; i < emotionNumber; i++) {
        WBEmotionButton *emotionButton = self.subviews[i + 1];
        
        // 设置每个表情按钮frame
        emotionButton.width = btnW;
        emotionButton.height = btnH;
        emotionButton.x = inset + (i % WBEmotionMaxCols) * (btnMargin + btnW);
        emotionButton.y = inset + (i / WBEmotionMaxCols) * (btnMargin + btnH);
    }
    // 删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.x = self.width - inset - btnW;
    self.deleteButton.y = self.height - btnH;
    
    // 设置放大镜的frame
    self.popView.width = 64;
    self.popView.height = 91;
}

#pragma mark - 监听方法
/** 按钮被按下后调用 */
- (void)btnClicked:(WBEmotionButton *)btn
{
    // 从某个表情按钮显示放大镜
    [self.popView showFrom:btn];
    
    // 移除放大镜
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });

    // 发布通知
    [self postEmotionButtonDidClickedNotificationWithEmotionButton:btn];
}

/** 点击了删除按钮 */
- (void)deleteClicked
{
//    WJLog(@"deleteClicked-----");
    // 发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:WBEmotionDeleteButtonDidClickedNotification object:nil];
}

/**
 *     根据手指所在位置判断手指在哪个按钮上\不在则为空
 */
- (WBEmotionButton *)emotionButtonWithRecognizerLocation:(CGPoint)location
{
    NSUInteger emotionNumber = self.emotions.count - 1;
    // 遍历所有按钮
    for (NSUInteger i = 0; i < emotionNumber; i++) {
        WBEmotionButton *emotionButton = self.subviews[i + 1];
        // 如果手指所在的点在某个表情按钮范围内
        if (CGRectContainsPoint(emotionButton.frame, location) ) {
            /**
             *     在则返回按钮，不必继续，节约性能
             */
            return emotionButton;
        }
    }
    // 不在按钮上就移除放大镜
    [self.popView removeFromSuperview];
    return nil;
}
/**
 *     长按表情板块控件会调用，长按事件在这里处理
 */
- (void)longPressedSinglePageView:(UILongPressGestureRecognizer *)recognizer
{
    // 取得手指所在的位置
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    // 根据手指所在位置判断手指在哪个按钮上\不在则为空
    WBEmotionButton *btn = [self emotionButtonWithRecognizerLocation:location];
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded: // 手势结束
        case UIGestureRecognizerStateCancelled: // 手势取消
            // 移除放大镜
            [self.popView removeFromSuperview];
            
            if (btn) {  // 如果手指位置仍然在某个表情按钮上就发出通知，输入该表情
                // 发布通知
                [self postEmotionButtonDidClickedNotificationWithEmotionButton:btn];
            }
            break;
            
        case UIGestureRecognizerStateBegan: // 手势开始
        case UIGestureRecognizerStateChanged:   // 手势变化
            [self.popView showFrom:btn];
            break;
            
            default:    // 有情况没列出这里最好写上
            break;
    }
}

/**
 *     发出表情按钮被按下通知
 *
 *     @param btn 被选中的表情
 */
- (void)postEmotionButtonDidClickedNotificationWithEmotionButton:(WBEmotionButton *)btn
{
    // 存储表情到"最近"
    [WBEmotionTool addRecentEmotion:btn.emotion];
    
    // 通知内容
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[WBEmotionButtonDidClickedKey] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:WBEmotionButtonDidClickedNotification object:nil userInfo:userInfo];
}
@end
