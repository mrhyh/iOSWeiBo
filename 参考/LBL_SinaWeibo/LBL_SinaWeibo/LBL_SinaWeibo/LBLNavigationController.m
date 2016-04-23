//
//  LBLNavigationController.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface LBLNavigationController ()


@end

@implementation LBLNavigationController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    //[super pushViewController:viewController animated:animated];

    
    if (self.viewControllers.count != 0) {
        
//        viewController.hidesBottomBarWhenPushed = YES;
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    
    
    
    
    UIViewController *ctrl = self.viewControllers.firstObject;
    
    if (self.viewControllers.count >= 1) {
        NSString *title = @"返回";
        if (self.viewControllers.count == 1) {
            title = ctrl.title;
//            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" higtImage:@"navigationbar_back_withtext_highlighted" target:nil action:nil title:ctrl.title];
        }else{
//            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" higtImage:@"navigationbar_back_withtext_highlighted" target:nil action:nil title:@"返回"];
            
        }
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back_withtext" higtImage:@"navigationbar_back_withtext_highlighted" target:self action:@selector(back) title:title];
    }
  
    [super pushViewController:viewController animated:animated];

}

- (void)back{
    [self popViewControllerAnimated:YES];
}



@end
