//
//  WBStatusFrame.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/12.
//  Copyright © 2015年 王万杰. All rights reserved.
//  一个WBStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型WBStatus

#import <Foundation/Foundation.h>
@class WBStatus;

/** cell间距 */
#define WBCellMargin 15
/** cell的边框宽度 */
#define WBStatusCellBorderW 10
/** 昵称字体 */
#define WBStatusCellNameFont [UIFont systemFontOfSize:15]
/** 时间字体 */
#define WBStatusCellTimeFont [UIFont systemFontOfSize:12]
/** 来源字体 */
#define WBStatusCellSourceFont WBStatusCellTimeFont
/** 正文字体 */
#define WBStatusCellContentFont [UIFont systemFontOfSize:15]

// 被转发微博的正文字体
#define WBStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

@interface WBStatusFrame : NSObject
/** WBStatus数据模型 */
@property (nonatomic, strong) WBStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像frame */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标frame */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图frame */
@property (nonatomic, assign) CGRect photosViewF;
/** 昵称frame */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间frame */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源frame */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文frame */
@property (nonatomic, assign) CGRect contentLabelF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotosViewF;

/** 底部工具条 */
@property (nonatomic, assign) CGRect toolBarF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
@end
