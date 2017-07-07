//
//  BLLoginController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/4.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLLoginController.h"
#import <EaseMob.h>
#import "BLTabBarController.h"

@interface BLLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation BLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - 登录
- (IBAction)LoginClick:(UIButton *)sender {
    // 登录成功后，自动去取好友列表
    // SDK获取结束后，会回调
    // - (void)didFetchedBuddyList:(NSArray *)buddyList error:(EMError *)error方法。
    [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
    
    if (self.username.text.length == 0 || self.password.text.length == 0) {
        NSLog(@"请输入正确的用户名或密码");
        return;
    }
    
    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
    if (!isAutoLogin) {

        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.username.text password:self.password.text completion:^(NSDictionary *loginInfo, EMError *error) {
            
            if (error) {
                NSLog(@"登录失败 - %@", error);
            } else {
                
                // 设置自动登录
                [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                
                NSLog(@"登录成功 - %@", loginInfo);
                
                // 跳转主界面
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    BLTabBarController *tabbarVC = [[BLTabBarController alloc] init];
                    self.view.window.rootViewController = tabbarVC;
                    [self.view.window makeKeyAndVisible];
                }];
                
            }
        } onQueue:nil];
    }
}

#pragma mark - 注册
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
