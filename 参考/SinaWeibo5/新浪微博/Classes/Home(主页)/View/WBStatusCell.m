//
//  WBStatusCell.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/12.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBStatus.h"
#import "WBStatusFrame.h"
#import "WBUser.h"
#import "WBPhoto.h"
#import "UIImageView+WebCache.h"
#import "WBStatusToolBar.h"
#import "WBStatusPhotosView.h"
#import "WBIconView.h"
#import "WBStatusTextView.h"

@interface WBStatusCell ()
/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) WBIconView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView * vipView;
/** 配图 */
@property (nonatomic, weak) WBStatusPhotosView * photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) WBStatusTextView *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) WBStatusTextView *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) WBStatusPhotosView *retweetPhotosView;

/** 底部工具条 */
@property (nonatomic, weak) WBStatusToolBar *toolBarView;
@end
@implementation WBStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *     返回一个微博cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    // 新建标识
    static NSString *ID = @"status";
    // 创建cell
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[WBStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;

}
/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加cell内部可能出现的所有的子控件,以及子控件的一次性设置
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /** 初始化原创微博 */
        [self setupOriginalStatus];
        
        /** 初始化转发微博 */
        [self setupRetweetStatus];
        
        /** 初始化工具条 */
        [self setupToolBar];
    }
    return self;
}

/**
 *     初始化工具条
 */
- (void)setupToolBar
{
    /** 转发微博整体 */
    WBStatusToolBar *toolBarView = [WBStatusToolBar toolBar];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
}

/**
 *     初始化原创微博
 */
- (void)setupOriginalStatus
{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像 */
    WBIconView *iconView = [[WBIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    // 设置图片居中防止拉升
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图 */
    WBStatusPhotosView *photosView = [[WBStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    // 设置字体和frame设置里的统一
    nameLabel.font = WBStatusCellNameFont;
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    // 设置字体和frame设置里的统一
    timeLabel.font = WBStatusCellTimeFont;
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    // 设置字体和frame设置里的统一
    sourceLabel.font = WBStatusCellSourceFont;
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    WBStatusTextView *contentLabel = [[WBStatusTextView alloc] init];
    // 换行
    // 设置字体和frame设置里的统一
//    contentLabel.font = WBStatusCellContentFont;
//    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;

}

/**
 *     初始化转发的微博
 */
- (void)setupRetweetStatus
{
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = WBColor(247, 247, 247, 1);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称 */
    WBStatusTextView *retweetContentLabel = [[WBStatusTextView alloc] init];
//    retweetContentLabel.numberOfLines = 0;
//    retweetContentLabel.font = WBStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    WBStatusPhotosView *retweetPhotosView = [[WBStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}
/**
 *     在这里设置cell内部子控件的frame
 *      设置子控件的属性，内容
 */
- (void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 取出微博和用户
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 会员图标 */
    if (user.isVip) {
        // cell循环利用，所以要重新设置
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        // 设置会员昵称颜色
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        // cell循环利用，所以要重新设置
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 配图 */
    if (status.pic_urls.count) {    // 数组不空
        self.photosView.frame = statusFrame.photosViewF;
//        WBPhoto *photo = status.pic_urls[0];
        /** 将模型地址传递给图片 */
        self.photosView.photos = status.pic_urls;
#warning 设置图片
        // 下载配图显示
//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photosView.hidden = NO;
    } else {    // 没有配图
        self.photosView.hidden = YES;
    }
    
    
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 时间 */
    // 设置时间显示颜色
    self.timeLabel.textColor = [UIColor orangeColor];
    NSString *timeText = status.created_at;
    CGFloat timeLabelX = statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(statusFrame.nameLabelF) + WBStatusCellBorderW;
    CGSize timeLabelSize = [timeText sizeWithFont:WBStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    self.timeLabel.text = timeText;
    
    /** 来源 */
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + WBStatusCellBorderW;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:WBStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    self.sourceLabel.text = status.source;
    
    /** 正文 */
//    status.text --> self.attattributedText
//        self.contentLabel.attributedText = status.attributedText;
    self.contentLabel.attributedText = status.attributedText;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    /** 被转发的微博 */
    if (status.retweeted_status) {  // 有转发的微博
        // 取出微博
        WBStatus *retweeted_status = status.retweeted_status;
//        WBUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        /** 被转发的微博整体 */
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 被转发的微博正文 */
//        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        self.retweetContentLabel.attributedText = status.retweetedAttributedText;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 被转发的微博配图 */
        if (retweeted_status.pic_urls.count) { // 有配图
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
//            WBPhoto *retweetedPhoto = [retweeted_status.pic_urls lastObject];
            
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
#warning 设置图片
//            [self.retweetPhotosView sd_setImageWithURL:[NSURL URLWithString:retweetedPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
            self.retweetPhotosView.hidden = NO;
        } else { // 无配图
            self.retweetPhotosView.hidden = YES;
        }
    } else { // 无转发微博
        self.retweetView.hidden = YES;
    }
    
    /** 底部工具条 */
    self.toolBarView.frame = statusFrame.toolBarF;
    /** 给工具条传递WBStatus模型数据 */
    self.toolBarView.status = status;
}
@end
