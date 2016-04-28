//
//  WBHomeViewController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBTitleButton.h"
#import "WBDropdownMenu.h"
#import "WBTitleMenuViewController.h"
#import "WBAccountTool.h"
#import "WBAccount.h"
#import "UIImageView+WebCache.h"
#import "WBUser.h"
#import "WBStatus.h"
#import "MJExtension.h"
#import "WBStatusFrame.h"
#import "WBStatusCell.h"
#import "WBHTTPTool.h"
#import "MJRefresh.h"
#import "WBStatusDataTool.h"

// 系统版本大于8.0
#define resisterApplication float version = [[[UIDevice currentDevice] systemVersion] floatValue];\
if (version >= 8.0) {\
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];\
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];\
}

@interface WBHomeViewController () <WBDropdownMenuDelegate>
/** 微博数据Frames */
@property (nonatomic, strong) NSMutableArray *statusesFrames;
@end

@implementation WBHomeViewController

#pragma mark - 懒加载
- (NSMutableArray *)statusesFrames
{
    if (!_statusesFrames) {
        self.statusesFrames = [NSMutableArray array];
    }
    return _statusesFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = WBColor(211, 211, 211, 1);
    // 设置导航栏
    [self setupNavigation];
    
    // 设置标题
    [self setupUserInfo];
    
    // 集成下拉刷新控件
    [self setupDropDownRefresh];
    
    // 集成上拉刷新控件
    [self setupDropUpRefresh];
    
    // 每隔60秒，获取一次未读微博数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadStatusCount) userInfo:nil repeats:YES];
     // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/** 获取未读微博数 */
- (void)setupUnreadStatusCount
{
    // 设置请求参数
    NSString *url = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 发送请求
    [WBHTTPTool GET:url params:params success:^(id responseObject) {
        WJLog(@"获取未读微博数成功----%@", [responseObject[@"status"] description]);
        // 获得未读微博数
        NSString *unreadCount = [responseObject[@"status"] description];
        
        // 判断系统版本
        resisterApplication;
        
        // 是0则不用设置
        if ([unreadCount isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = unreadCount;
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount.intValue;
        }
    } failure:^(NSError *error) {
        WJLog(@"请求失败----%@", error);
    }];
}
/** 集成上拉刷新控件 */
- (void)setupDropUpRefresh
{
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatuses)];
}
/** 集成下拉刷新控件 */
- (void)setupDropDownRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(refreshStateData)];
    
    // 开始请求数据
    [self.tableView headerBeginRefreshing];
}
/**
 *  将WBStatus模型转为WBStatusFrame模型
 */
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (WBStatus *status in statuses) {
        WBStatusFrame *f = [[WBStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}
/**
 *     下拉刷新数据
 *
 *     @param refreshController 刷新控件
 */
- (void)refreshStateData
{
    // 设置请求参数
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    // 取出最前面的微博（最新的微博，ID最大的微博）
    WBStatusFrame *firstStatusFrame = [self.statusesFrames firstObject];
    // 设置获取大于之前最大微博ID的微博
    if (firstStatusFrame) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatusFrame.status.idstr;
    }
    
    // 定义一个处理返回数据的block
    void (^dealingWithResult)(NSArray *)= ^(NSArray * statuses){
        // 将 "微博字典"数组 转为 "微博Frame模型"数组
        NSArray *newStatuses = [WBStatus objectArrayWithKeyValuesArray:statuses];
        
        // 将WBStatus 转为WBStatusFrame
        NSArray *newStatusFrames = [self stausFramesWithStatuses:newStatuses];
        
        // 将最新数据插到frame数组最前面
        NSRange range = NSMakeRange(0, newStatusFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrames insertObjects:newStatusFrames atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        // 停止刷新，移除圈圈
        [self.tableView headerEndRefreshing];
        
        // 提示用户最新微博数据数量
        [self showNewStatusesConut:newStatuses.count];
    };
    
    // 先尝试从数据库中加载数据
    NSArray *statuses = [WBStatusDataTool statusesWithParams:params];
    if (statuses.count) {
        // 处理数据
        dealingWithResult(statuses);
    } else {
        // 发送请求
        [WBHTTPTool GET:url params:params success:^(id responseObject) {
            //                WJLog(@"%@", responseObject[@"statuses"]);
            // 存储微博数据到沙盒数据库中
            [WBStatusDataTool saveStatuses:responseObject[@"statuses"]];
            
            // 处理数据
            dealingWithResult(responseObject[@"statuses"]);
        } failure:^(NSError *error) {
            WJLog(@"请求失败----%@", error);
            // 停止刷新，移除圈圈
            [self.tableView headerEndRefreshing];
        }];
    }
}

/** 加载更多微博数据 */
- (void)loadMoreStatuses
{
    // 设置请求参数
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    // 取出最前面的微博（最新的微博，ID最小的微博）
    WBStatusFrame *lastStatusFrame = [self.statusesFrames lastObject];
    // 设置获取大于之前最大微博ID的微博
    if (lastStatusFrame) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxID = lastStatusFrame.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxID);
    }
    
    // 定义一个处理返回数据的block
    void (^dealingWithResult)(NSArray *) = ^(NSArray *statuses){
        // 将 "微博字典"数组 转为 "微博Frame模型"数组
        NSArray *newStatuses = [WBStatus objectArrayWithKeyValuesArray:statuses];
        
        // 将WBStatus 数组转为 WBStatusFrame 数组
        NSArray *newStatusesFrames = [self stausFramesWithStatuses:newStatuses];
        
        // 将最新数据插到数组最后面
        [self.statusesFrames addObjectsFromArray:newStatusesFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        [self.tableView footerEndRefreshing];
    };
    
    // 先尝试从数据库中加载数据
    NSArray *statuses = [WBStatusDataTool statusesWithParams:params];
    if (statuses.count) {
        // 处理数据
        dealingWithResult(statuses);
    }
    else {
        // 发送请求
        [WBHTTPTool GET:url params:params success:^(id responseObject) {
            //        WJLog(@"%@", responseObject[@"statuses"]);
            // 存储微博数据到沙盒数据库中
            [WBStatusDataTool saveStatuses:responseObject[@"statuses"]];
            
            // 处理数据
            dealingWithResult(responseObject[@"statuses"]);
        } failure:^(NSError *error) {
            WJLog(@"请求失败----%@", error);
            
            // 结束刷新(隐藏footer)
            [self.tableView footerEndRefreshing];
        }];
    }
}

/**
 *     显示最新微博数据数量
 *
 *     @param count 数量
 */
- (void)showNewStatusesConut:(NSInteger)count
{
    // 判断系统版本
    resisterApplication;
    // 如果刷新成功，就清除角标
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UILabel *newCountTip = [[UILabel alloc] init];
    newCountTip.width = self.view.width;
    newCountTip.height = 44;
    newCountTip.y = 64 - newCountTip.height;
    // 设置属性
    newCountTip.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    newCountTip.font = [UIFont systemFontOfSize:16];
    newCountTip.textColor = [UIColor whiteColor];
    newCountTip.textAlignment = NSTextAlignmentCenter;
    
    if (count == 0) {
        newCountTip.text = @"没有更新的数据，请稍后再试";
    } else {
        NSString *showText = [NSString stringWithFormat:@"更新了%zd条数据", count];
        newCountTip.text = showText;
    }
    // 添加到导航控制器下面
    [self.navigationController.view insertSubview:newCountTip belowSubview:self.navigationController.navigationBar];
    // 动画
    /** 动画时间 */
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        newCountTip.transform = CGAffineTransformMakeTranslation(0, newCountTip.height);
    } completion:^(BOOL finished) {
        // 停留一秒再缩回
        [UIView animateWithDuration:duration delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            // 清空transform
            newCountTip.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 移除显示，销毁
            [newCountTip removeFromSuperview];
        }];
        
    }];
}
/**
 *     设置用户信息
 */
- (void)setupUserInfo
{
    // 设置请求参数
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = account.uid;
    params[@"access_token"] = account.access_token;
    
    // 发送请求
    [WBHTTPTool GET:url params:params success:^(id responseObject) {
        //        WJLog(@"%@", responseObject);
        // 设置控制器名称为用户昵称
        WBTitleButton *btn = (WBTitleButton *)self.navigationItem.titleView;
        // 取出模型
        WBUser *user = [WBUser objectWithKeyValues: responseObject];
        [btn setTitle:user.name forState:UIControlStateNormal];
        
        // 存储用户昵称到沙盒中
        account.username = user.name;
        [WBAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        WJLog(@"请求失败----%@", error);
    }];
}

/**
 *     设置导航栏
 */
- (void)setupNavigation
{
    // 设置左上角图标
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self SEL:@selector(left) image:@"navigationbar_friendsearch" highlightImage:@"navigationbar_friendsearch_highlighted"];
    
    // 设置右上角图标
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self SEL:@selector(right) image:@"navigationbar_pop" highlightImage:@"navigationbar_pop_highlighted"];
    
    // 设置中间按钮
    // 获得沙盒中存储的用户昵称
    NSString *name = [WBAccountTool account].username;
    WBTitleButton *titleBtn = [WBTitleButton buttonWithTitle:name?name:@"首页" image:@"navigationbar_arrow_down" selectedImage:@"navigationbar_arrow_up"];
    // 监听点击
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
    WJLog(@"%@-----viewDidLoad", self);
}
/**
 *     点击了标题
 */
- (void)titleClick:(UIButton *)btn
{
    // 创建下拉菜单
    WBDropdownMenu *menu = [WBDropdownMenu menu];
    // 设置代理
    menu.delegate = self;
    
    // 设置下拉菜单内容
    WBTitleMenuViewController *vc = [[WBTitleMenuViewController alloc] init];
    vc.view.height = 350;
    vc.view.width = 200;
    menu.contentVc = vc;
    
    // 显示菜单
    [menu showFrom:btn];
}

#pragma mark - WBDropdownMenuDelegate代理方法
/**
 *     让按钮图片朝下
 */
- (void)dropdownMenuDidDismiss:(WBDropdownMenu *)menu
{
    WBTitleButton *titleBtn = (WBTitleButton *)self.navigationItem.titleView;
    titleBtn.selected = NO;
}

/**
 *     让按钮图片朝上
 */
- (void)dropdownMenuDidShow:(WBDropdownMenu *)menu
{
    WBTitleButton *titleBtn = (WBTitleButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
}

- (void)left
{
    WJLog(@"点击了主页---left的item");
}
- (void)right
{
    WJLog(@"点击了主页---right的item");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.statusesFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建cell
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    // 给cell传递模型数据
    cell.statusFrame = self.statusesFrames[indexPath.row];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 如果tableView还没有数据，就直接返回
    if (self.statusesFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatuses];
    }
}

/**
 *     返回cell高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusFrame *statusFrame = self.statusesFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WJLog(@"点击了第%zd行", indexPath.row);
}
@end