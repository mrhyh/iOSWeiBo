//
//  YLHomeVC.m
//  iOSWeiBo
//
//  Created by ylgwhyh on 16/3/23.
//  Copyright © 2016年 com.ylgwhyh.iOSWeiBo. All rights reserved.
//

#import "YLHomeVC.h"
#import "YLMeVC.h"

@interface YLHomeVC ()

@end

@implementation YLHomeVC

- (void)viewDidLoad{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 40, 40)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
   
}

- (void)test{
    YLMeVC *next = [[YLMeVC alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

@end
