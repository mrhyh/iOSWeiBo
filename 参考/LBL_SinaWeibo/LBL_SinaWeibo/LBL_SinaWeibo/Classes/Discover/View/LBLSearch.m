//
//  LBLSearch.m
//  LBL_SinaWeibo
//
//  Created by apple on 15/10/1.
//  Copyright © 2015年 LBL. All rights reserved.
//

#import "LBLSearch.h"



@interface LBLSearch ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldRightMarin;

@end



@implementation LBLSearch

+ (instancetype)search
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LBLSearch" owner:nil options:nil] lastObject];
    
}


- (void)awakeFromNib
{
    
    [self setupChildView];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        //显示样式
        self.textField.leftView = leftView;
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        //圆角
//        [self.textField.layer setCornerRadius:5];
//        [self.textField.layer setMasksToBounds:YES];
    }
    return self;
}

- (void)setupChildView
{
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
//    拉伸样式
    leftView.contentMode = UIViewContentModeCenter;
    leftView.width = self.height;
    
    self.textField.leftView = leftView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;

    self.textField.delegate = self;
    //圆角
    [self.textField.layer setCornerRadius:5];
    [self.textField.layer setMasksToBounds:YES];

    
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    
    [self.textField endEditing:YES];
    self.textFieldRightMarin.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        //调整距离右边距离
        [self layoutIfNeeded];
    }];
    self.cancelButton.hidden = YES;
    
}


#pragma mark -UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //右边距离
    self.textFieldRightMarin.constant = self.cancelButton.width;
    
    [UIView animateWithDuration:0.25 animations:^{
        //
        [self layoutIfNeeded];
    }];
    
    self.cancelButton.hidden = NO;
}

@end
