#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

//设置边框
-(void)setBorderWithWidth:(CGFloat)width color:(UIColor *)color;
-(void)setBorderWithWidth:(CGFloat)width color:(UIColor *)color radian:(CGFloat)radian;

/**
 *  view显示动画与否
 *
 *  @param hidden
 */
- (void)viewHiddenAnimate:(BOOL)hidden;
- (void)viewAlphaAnimate:(CGFloat)initVal targetVal:(CGFloat)targetVal;
/**
 *  view显示时透明度变化
 *
 *  @param initVal   初始透明度
 *  @param targetVal 显示完成后的透明度
 *  @param finish    显示完成后block回调
 */
- (void)viewAlphaAnimate:(CGFloat)initVal targetVal:(CGFloat)targetVal finish:(void(^)())finish;

/**
 *  view旋转动画
 *
 *  @param f 旋转角度
 */
- (void)rotationAnimation:(CGFloat)f;
//隐藏拖动webview时黑色背景
- (void)hideGradientBackground:(UIView*)theView;

/**
 *  view动画
 *
 *  @param animate 完成后block回掉
 *  @param time    动画执行时间
 */
+ (void)viewAnimate:(void(^)())animate time:(float)time;
@end
