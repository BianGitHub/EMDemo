//
//  BLFriendRequestController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/7.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLFriendRequestController.h"
#import "BLSharedEM.h"

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

@end
