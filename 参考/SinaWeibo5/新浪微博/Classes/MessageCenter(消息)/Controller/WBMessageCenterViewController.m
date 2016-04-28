//
//  WBMessageCenterViewController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBMessageCenterViewController.h"
#import "WBTest1ViewController.h"

@interface WBMessageCenterViewController ()

@end

@implementation WBMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(writeMessage)];
#warning view是懒加载，在这里设置属性要注意view是否在创建之前被使用
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    WJLog(@"%@-----viewDidLoad", self);

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];}

- (void)writeMessage {
    WJLog(@"writeMessage-----");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 新建标识
    static NSString *ID = @"test1";
    // 创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test1数据-----%ld", indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBTest1ViewController *test1 = [[WBTest1ViewController alloc] init];
    test1.title = @"第一个测试控制器";
    [self.navigationController pushViewController:test1 animated:YES];
}
@end
