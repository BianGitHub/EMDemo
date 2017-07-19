//
//  BLChatViewController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/19.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLChatViewController.h"
#import <EaseMob.h>

@interface BLChatViewController ()

@end

@implementation BLChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    EMBuddy *buddy = [[EaseMob sharedInstance].chatManager buddyList][self.integerRow];
    self.navigationItem.title = buddy.username;
    
}

@end
