//
//  WBStatusFrame.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/12.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBStatusPhotosView.h"

/** cell边框宽度 */
#define WBCellBorderW 10

@implementation WBStatusFrame
- (void)setStatus:(WBStatus *)status
{
    _status = status;
    
    WBUser *user = status.user;
    
    /** cell的宽度 */
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 头像 */
    CGFloat iconWH = 40;
    CGFloat iconX = WBCellBorderW;
    CGFloat iconY = WBCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + WBCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:WBStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    /** 会员图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + WBCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }

    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + WBCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFont:WBStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + WBCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:WBStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + WBCellBorderW;
    /** 正文最大宽度 */
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.attributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图 */
    // 整体的高度
    CGFloat originalH = 0;
    if (status.pic_urls.count) { // 有配图
        // CGFloat photoX = (cellW - photoWH) * 0.5;   // 居中
        CGFloat photoX = contentX;       // 居左
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + WBCellBorderW;
        CGSize photosSize = [WBStatusPhotosView sizeWithImageCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photoX, photoY}, photosSize};
        
        originalH = CGRectGetMaxY(self.photosViewF) + WBCellBorderW;
    } else { // 没配图
        originalH = CGRectGetMaxY(self.contentLabelF) + WBCellBorderW;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = WBCellMargin;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /** 底部工具条Y值 */
    CGFloat toolBarY = 0;
    /** 转发微博 */
    if (status.retweeted_status) { // 有转发的微博
        /** 被转发的微博 */
        WBStatus *retweetedStatus = status.retweeted_status;
        /** 被转发的微博的作者 */
//        WBUser *retweetedUser = retweetedStatus.user;
        
        /** 被转发微博正文 */
        CGFloat retweetStatusContentX = WBCellBorderW;
        CGFloat retweetStatusContentY = WBCellBorderW;
//        NSString *retweetStatusContentText = [NSString stringWithFormat:@"@%@ : %@", retweetedUser.name, retweetedStatus.text];
        CGSize retweetStatusContentSize = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        self.retweetContentLabelF = (CGRect){{retweetStatusContentX, retweetStatusContentY}, retweetStatusContentSize};
        
        /** 被转发微博整体的宽度（看是否有配图） */
        CGFloat retweetStatusH = 0;
         /** 被转发微博配图 */
        if (retweetedStatus.pic_urls) { // 有配图才设置
            CGFloat retweetPhotosX = retweetStatusContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelF) + WBCellBorderW;
            CGSize reweetPhotosSize = [WBStatusPhotosView sizeWithImageCount:retweetedStatus.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotosX, retweetPhotosY}, reweetPhotosSize};
            
            retweetStatusH = CGRectGetMaxY(self.retweetPhotosViewF) + WBCellBorderW;
           
        } else {
            retweetStatusH = CGRectGetMaxY(self.retweetContentLabelF) + WBCellBorderW;
        }
        /** 被转发微博整体 */
        CGFloat retweetStatusX = 0;
        CGFloat retweetStatusY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetStatusW = cellW;
        self.retweetViewF = CGRectMake(retweetStatusX, retweetStatusY, retweetStatusW, retweetStatusH);

        toolBarY = CGRectGetMaxY(self.retweetViewF);
    } else { // 无转发微博
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /** 底部工具条 */
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    /** cell高度 */
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
//    self.cellHeight = CGRectGetMaxY(self.toolBarF) + WBCellMargin;
}
@end
