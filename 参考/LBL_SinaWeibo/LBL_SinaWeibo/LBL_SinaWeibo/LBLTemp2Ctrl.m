//
//  LBLTemp2Ctrl.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLTemp2Ctrl.h"
#import "UIBarButtonItem+Extension.h"
#import "LBLTemp3Ctrl.h"

@interface LBLTemp2Ctrl ()

@end



@implementation LBLTemp2Ctrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LBLTemp2Ctrl";
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    LBLTemp3Ctrl *ctrl = [[LBLTemp3Ctrl alloc] init];
    
    [self.navigationController pushViewController:ctrl animated:YES];
    
    
}




@end
