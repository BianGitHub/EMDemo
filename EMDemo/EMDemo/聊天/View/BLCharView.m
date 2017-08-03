//
//  BLCharView.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/23.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLCharView.h"
#import "BLChatCell.h"
#import "BLChatSendCell.h"

static NSString *chatCell = @"chatCell";
static NSString *chatSendCell = @"chatSendCell";
@interface BLCharView ()<UITableViewDataSource>
@end

@implementation BLCharView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.estimatedRowHeight = 200;
        self.rowHeight = UITableViewAutomaticDimension;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        self.dataSource = self;
        self.messageArr = [NSMutableArray array];
        [self registerClass:[BLChatCell class] forCellReuseIdentifier:chatCell];
        [self registerClass:[BLChatSendCell class] forCellReuseIdentifier:chatSendCell];
    }
    return self;
}

#pragma mark - UITableviewDatesource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMMessage *message = self.messageArr[indexPath.row];
    if ([message.from isEqualToString:self.buddy.username]) {
        
        BLChatCell *cell = [tableView dequeueReusableCellWithIdentifier:chatCell forIndexPath:indexPath];
        
        cell.message = message;
        cell.backgroundColor = [UIColor grayColor];
        return cell;
    } else {
        BLChatSendCell *cell = [tableView dequeueReusableCellWithIdentifier:chatSendCell forIndexPath:indexPath];
        
        cell.message = message;
        cell.backgroundColor = [UIColor lightGrayColor];
        
        return cell;
    }
    
}



@end
