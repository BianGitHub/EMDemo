//
//  BLAddFriendController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/6.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLAddFriendController.h"
#import <EaseMob.h>
#import "BLSharedEM.h"

@interface BLAddFriendController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation BLAddFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI {
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, self.view.bounds.size.width - 90, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"请输入好友名称";
    [self.view addSubview:self.textField];
    
    self.addBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.textField.bounds.size.width + 20, 30, 60, 30)];
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.addBtn];
    [self.addBtn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addFriend{
    [self.textField endEditing:YES];
    
    NSString *friendname = self.textField.text;
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:friendname message:[NSString stringWithFormat:@"%@想添加您为好友 ", [EaseMob sharedInstance].chatManager.loginInfo[@"username"]] error:&error];
    if (isSuccess && !error) {
        NSLog(@"添加成功");
        
//        [self alertViewShow:@"添加成功"];
        [[BLSharedEM sharedInstance] alertViewShow:@"添加成功" controller:self handler:nil];
    }else {
        NSLog(@"添加失败 - %@", error);
        
//        [self alertViewShow:@"添加失败"];
        [[BLSharedEM sharedInstance] alertViewShow:@"添加失败" controller:self handler:nil];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField endEditing:YES];
}

@end
