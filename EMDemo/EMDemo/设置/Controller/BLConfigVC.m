//
//  BLConfigVC.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/4.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLConfigVC.h"
#import <EaseMob.h>

@interface BLConfigVC ()

@end

@implementation BLConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";
    
    // 添加退出按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 20, self.view.frame.size.width - 40, 40);
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.clipsToBounds = 10;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    NSString *str = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    [btn setTitle:[NSString stringWithFormat:@"退出(%@)", str] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction {
    
    NSLog(@"退出");
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            NSLog(@"退出成功");
            self.view.window.rootViewController = [UIStoryboard storyboardWithName:@"BLLoginController" bundle:nil].instantiateInitialViewController;
        }
    } onQueue:nil];
}

@end
