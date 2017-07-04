//
//  BLLoginController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/4.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLLoginController.h"
#import <EaseMob.h>

@interface BLLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation BLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)LoginClick:(UIButton *)sender {
    
    if (self.username.text.length == 0 || self.password.text.length == 0) {
        NSLog(@"请输入正确的用户名或密码");
        return;
    }
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.username.text password:self.password.text completion:^(NSDictionary *loginInfo, EMError *error) {
        
        if (error) {
            NSLog(@"登录失败 - %@", error);
        } else {
            NSLog(@"登录成功 - %@", loginInfo);
        }
    } onQueue:nil];
}

- (IBAction)registerClick:(UIButton *)sender {
    
    if (self.username.text.length == 0 || self.password.text.length == 0) {
        NSLog(@"请输入正确的用户名或密码");
        return;
    }
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.username.text password:self.password.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
       
        if (error) {
            NSLog(@"注册失败 - %@", error);
        } else {
            NSLog(@"注册成功");
        }
    } onQueue:nil];
}

@end
