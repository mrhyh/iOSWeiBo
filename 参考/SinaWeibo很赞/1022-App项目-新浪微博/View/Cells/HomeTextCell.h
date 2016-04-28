//
//  HomeCell.h
//  1022-App项目-新浪微博
//
//  Created by Ibokan on 15/10/22.
//  Copyright © 2015年 yulu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapButtonOfHeadImageBlock)(id obj);
@interface HomeTextCell : UITableViewCell
//点击头像按钮执行一段代码
-(void)setTapButtonOfHeadImageBlock:(TapButtonOfHeadImageBlock)aBlock;

@end
