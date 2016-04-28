//
//  DWPublishButton.m
//  DWCustomTabBarDemo
//
//  Created by Damon on 10/20/15.
//  Copyright © 2015 damonwong. All rights reserved.
//

#import "DWPublishButton.h"
#import "BHBItem.h"
#import "BHBPopView.h"
@interface DWPublishButton ()

@end

@implementation DWPublishButton


#pragma mark -
#pragma mark - Public Methods

+(instancetype)publishButton{
    
    DWPublishButton *button = [[DWPublishButton alloc]init];
    
    [button setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];

    [button sizeToFit];
    
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}


#pragma mark -
#pragma mark - Event Response

- (void)clickPublish
{
    
    BHBItem *item0 = [[BHBItem alloc] initWithTitle:@"文字" Icon:@"tabbar_compose_idea"];
    BHBItem *item1 = [[BHBItem alloc] initWithTitle:@"照片/视频" Icon:@"tabbar_compose_photo"];
    BHBItem *item2 = [[BHBItem alloc] initWithTitle:@"长微博" Icon:@"tabbar_compose_weibo"];
    BHBItem *item3 = [[BHBItem alloc] initWithTitle:@"签到" Icon:@"tabbar_compose_lbs"];
    BHBItem *item4 = [[BHBItem alloc] initWithTitle:@"点评" Icon:@"tabbar_compose_review"];
    BHBItem *item5 = [[BHBItem alloc] initWithTitle:@"更多" Icon:@"tabbar_compose_more"];
    item5.isMore = YES;
    
    BHBItem *item6 = [[BHBItem alloc] initWithTitle:@"好友圈" Icon:@"tabbar_compose_friend"];
    BHBItem *item7 = [[BHBItem alloc] initWithTitle:@"微博相机" Icon:@"tabbar_compose_wbcamera"];
    BHBItem *item8 = [[BHBItem alloc] initWithTitle:@"音乐" Icon:@"tabbar_compose_music"];
    BHBItem *item9 = [[BHBItem alloc] initWithTitle:@"收款" Icon:@"tabbar_compose_transfer"];
    BHBItem *item10 = [[BHBItem alloc] initWithTitle:@"红包" Icon:@"tabbar_compose_envelope"];
    BHBItem *item11 = [[BHBItem alloc] initWithTitle:@"录像" Icon:@"tabbar_compose_shooting"];
    //添加popview
    [BHBPopView showToView:[UIApplication sharedApplication].keyWindow  withItems:@[item0,item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11]andSelectBlock:^(BHBItem *item, NSInteger index) {
        NSLog(@"%ld,选中%@",index,item.title);
    }];

    
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %ld", buttonIndex);
}


@end
