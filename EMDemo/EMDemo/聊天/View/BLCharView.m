//
//  BLCharView.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/23.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLCharView.h"
#import "BLChatCell.h"

static NSString *chatCell = @"chatCell";
@interface BLCharView ()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation BLCharView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[BLChatCell class] forCellReuseIdentifier:chatCell];
    }
    return self;
}

#pragma mark - UITableviewDatesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLChatCell *cell = [tableView dequeueReusableCellWithIdentifier:chatCell forIndexPath:indexPath];
    cell.str = @"xxxas fasf adasdasdasfasfawfarwaafafawfafetafawafafaw";
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

@end
