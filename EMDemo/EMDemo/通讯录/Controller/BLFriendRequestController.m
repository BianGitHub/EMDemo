//
//  BLFriendRequestController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/7.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLFriendRequestController.h"
#import "BLSharedEM.h"
#import <EaseMob.h>

@interface BLFriendRequestController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BLFriendRequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"friendRequest"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [BLSharedEM sharedInstance].friendCount.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendRequest"];
    if (cell) {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"friendRequest"];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"user"];
    cell.textLabel.text = [BLSharedEM sharedInstance].friendCount[indexPath.row][@"username"];
    cell.detailTextLabel.text = [BLSharedEM sharedInstance].friendCount[indexPath.row][@"message"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - UItableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd被点击了", indexPath.row);
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@ 是否同意?", [BLSharedEM sharedInstance].friendCount[indexPath.row][@"message"]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        EMError *error = nil;
        BOOL isSuccess = [[EaseMob sharedInstance].chatManager acceptBuddyRequest:[BLSharedEM sharedInstance].friendCount[indexPath.row][@"username"] error:&error];
        if (isSuccess && !error) {
            [[BLSharedEM sharedInstance] alertViewShow:@"添加成功" controller:self];
        }
    }];
    
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        EMError *error = nil;
        BOOL isSuccess = [[EaseMob sharedInstance].chatManager rejectBuddyRequest:[BLSharedEM sharedInstance].friendCount[indexPath.row][@"username"]  reason:nil error:&error];
        if (isSuccess && !error) {
            [[BLSharedEM sharedInstance] alertViewShow:@"拒绝成功" controller:self];
        }
    }];
    
    [alertC addAction:alertAction1];
    [alertC addAction:alertAction2];
    [self presentViewController:alertC animated:YES completion:nil];
}

@end
