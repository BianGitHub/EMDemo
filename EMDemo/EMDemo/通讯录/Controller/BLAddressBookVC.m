//
//  BLAddressBookVC.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/4.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLAddressBookVC.h"
#import "BLAddFriendController.h"
#import <EaseMob.h>
#import "BLSharedEM.h"
#import "BLFriendRequestController.h"

@interface BLAddressBookVC ()<EMChatManagerDelegate ,UITableViewDataSource, UITableViewDelegate, BLFriendRequestControllerDelegate>
@property (nonatomic, strong)BLFriendRequestController *frc;
@end

@implementation BLAddressBookVC {
    NSMutableDictionary *_dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"通讯录";
    self.frc = [BLFriendRequestController new];
    self.frc.delegate = self;
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    _dict = [NSMutableDictionary dictionaryWithCapacity:0];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    rightBtn.tintColor = [UIColor whiteColor];
    [rightBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"friendCell"];
}

- (void)leftAction {
    NSLog(@"添加好友");
    
    BLAddFriendController *addF = [[BLAddFriendController alloc] init];
    
    [self.navigationController pushViewController:addF animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return [[EaseMob sharedInstance].chatManager buddyList].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"newFriends"];
    
        if ([BLSharedEM sharedInstance].friendCount.count == 0) {
            
            cell.textLabel.text = @"新添加好友请求";
        }else {
            cell.textLabel.text = [NSString stringWithFormat:@"新添加好友请求 +%zd", [BLSharedEM sharedInstance].friendCount.count];
        }
    } else {
        
        cell.imageView.image = [UIImage imageNamed:@"user"];
        EMBuddy *buddy = [[EaseMob sharedInstance].chatManager buddyList][indexPath.row];
        cell.textLabel.text = buddy.username;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - UItableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSLog(@"点击了llllll");
        NSLog(@"%@", [BLSharedEM sharedInstance].friendCount);
//        self.frc = [BLFriendRequestController new];
        [self.navigationController pushViewController:self.frc animated:YES];
    }
}

- (void)didSelectAgreeAction {
    
    [self.tableView reloadData];
}

@end
