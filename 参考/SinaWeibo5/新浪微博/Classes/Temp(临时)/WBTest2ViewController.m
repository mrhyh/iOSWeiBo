//
//  WBTest2ViewController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTest2ViewController.h"
#import "WBTest3TableViewController.h"

@interface WBTest2ViewController ()

@end

@implementation WBTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WBTest3TableViewController *test3 = [[WBTest3TableViewController alloc] init];
    test3.title = @"第三个测试控制器";
    [self.navigationController pushViewController:test3 animated:YES];
}
@end
