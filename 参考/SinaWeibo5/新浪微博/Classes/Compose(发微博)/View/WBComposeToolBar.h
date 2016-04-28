//
//  WBComposeToolBar.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/15.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBComposeToolBar;

typedef enum {
    WBComposeToolBarButtonTypeCamera,   // 拍照
    WBComposeToolBarButtonTypeAlbum,    // 相册
    WBComposeToolBarButtonTypeMention,  // @
    WBComposeToolBarButtonTypeTrend,    // #
    WBComposeToolBarButtonTypeEmotion   // 表情
} WBComposeToolBarButtonType;

@protocol WBComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(WBComposeToolBar *)toolrBar didClickedButton:(WBComposeToolBarButtonType)buttonType;

@end
@interface WBComposeToolBar : UIView
/** 代理 */
@property (nonatomic, weak) id<WBComposeToolBarDelegate> delegate;
/** 是否显示表情图标 */
@property (nonatomic, assign, getter=isShowEmotionButton) BOOL showEmotionButton;
@end
