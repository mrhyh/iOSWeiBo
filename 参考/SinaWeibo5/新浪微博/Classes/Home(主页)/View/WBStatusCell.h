//
//  WBStatusCell.h
//  新浪微博
//
//  Created by 王万杰 on 15/10/12.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;

@interface WBStatusCell : UITableViewCell
/** 快速创建WBStatusCell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** WBStatusFrame */
@property (nonatomic, strong) WBStatusFrame *statusFrame;
@end
