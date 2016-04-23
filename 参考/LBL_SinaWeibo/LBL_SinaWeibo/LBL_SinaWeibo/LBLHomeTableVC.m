//
//  LBLHomeTableVC.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLHomeTableVC.h"
#import "UIBarButtonItem+Extension.h"
#import "LBLTemp2Ctrl.h"
#import "LBLHomeTitleButton.h"
#import "LBLPopView.h"
#import "LBLAccount.h"
#import "LBLAccountTool.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "LBLStatus.h"
#import "LBLLoadMoreView.h"


static NSString *indentifier = @"cell";

#define LOAD_COUNT 20
@interface LBLHomeTableVC ()


@property (nonatomic,strong) LBLHomeTitleButton *titleButton;

//装LBLStatus对象
@property (nonatomic,strong) NSMutableArray *statuses;

@end

@implementation LBLHomeTableVC

- (NSMutableArray *)statuses
{
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉横线
//    UIView *view = [[UIView alloc] init];
//    view.height = -1;
//    [self.tableView setTableFooterView:view];
    
    //告诉tableView，我这个里面的cell是哪一个类型的cell，去从缓存里面取的identifier是什么
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:indentifier];

    
    //设置刷新
    [self setUpRefreshView];
    
    
    [self setNav];
    
    //加载最新数据
   // [self loadNewStatuses:];
}
//添加刷新控制
- (void)setUpRefreshView{
    //初始化刷新控件
    UIRefreshControl *rereshCtrl = [[UIRefreshControl alloc] init];
    //监听rereshCtrl值改变
    [rereshCtrl addTarget:self action:@selector(loadNewStatuses:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:rereshCtrl];
    
    //开始刷新
    [rereshCtrl beginRefreshing];
    [self loadNewStatuses:rereshCtrl];
    
    //添加上拉加载数据
    LBLLoadMoreView *loadMoreView = [LBLLoadMoreView loadMoreView];
    self.tableView.tableFooterView = loadMoreView;
}



//设置导航栏按钮
- (void)setNav{
    //设置导航栏左右按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" higtImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendsearch:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" higtImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop:)];
    
    LBLHomeTitleButton *titleButton = [[LBLHomeTitleButton alloc] init];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    titleButton.size = CGSizeMake(100, 50);
    [titleButton sizeToFit];
    
    //添加点击事件
    [titleButton addTarget:self action:@selector(showPopView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.navigationItem.titleView = titleButton;

    self.titleButton = titleButton;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.titleButton setTitle:@"呜呜呜" forState:UIControlStateNormal];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    cell.textLabel.text = [self.statuses[indexPath.row] text];
    
    // Configure the cell...
    
    return cell;
}
#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
}



#pragma mark - 私有方法
/**
 *  加载微博数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshCtrl{
    //定义请求地址
    NSString *urlStr = @"https://api.weibo.com/2/statuses/home_timeline.json";
    
    //拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LBLAccountTool account].access_token;
    //刷新微博 判断是否有微博 有 把第一条微博id 作为since_id 参数传入 刷新数据不重复
    if (self.statuses.count>0) {
        LBLStatus *status = [self.statuses firstObject];
        params[@"since_id"] = @(status.id);
    }
    params[@"count"] = @(LOAD_COUNT);
    
    //NSLog(@"%@",[LBLAccountTool account].access_token);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功%@",responseObject);
        
        [refreshCtrl endRefreshing];
        NSArray *statuses = [LBLStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [_statuses addObjectsFromArray:statuses];
        [self.tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [refreshCtrl endRefreshing];
        NSLog(@"请求失败 :%@",error);
    }];
    
}


- (void)showPopView:(LBLHomeTitleButton *)button{
    //定义customView
    UIView *customView = [[UIView alloc] init];
    customView.size = CGSizeMake(100, 100);
    customView.backgroundColor = [UIColor redColor];
    
    LBLPopView *popView = [[LBLPopView alloc] initWithCustomView:customView showWithView:button];
    
    //添加到window
    
    [popView show];
   
}


- (void)friendsearch:(UIButton *)btn
{
    NSLog(@"%s",__func__);
    LBLTemp2Ctrl *ctrl = [[LBLTemp2Ctrl alloc] init];
    
    [self.navigationController pushViewController:ctrl animated:YES];
    
    
}

- (void)pop:(UIButton *)btn
{
    NSLog(@"%s",__func__);

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
