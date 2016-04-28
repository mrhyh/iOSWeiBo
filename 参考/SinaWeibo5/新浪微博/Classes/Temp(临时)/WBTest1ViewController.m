//
//  WBTest1ViewController.m
//  新浪微博
//
//  Created by 王万杰 on 15/10/8.
//  Copyright © 2015年 王万杰. All rights reserved.
//

#import "WBTest1ViewController.h"
#import "WBTest2ViewController.h"

@interface WBTest1ViewController ()

@end

@implementation WBTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 若是不想要左右上角图标，可直接覆盖，因为viewDidLoad调用在被push之后
    //    self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:0 target:nil action:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WBTest2ViewController *test2 = [[WBTest2ViewController alloc] init];
    test2.title = @"第二个测试控制器";
    [self.navigationController pushViewController:test2 animated:YES];
}

@end
