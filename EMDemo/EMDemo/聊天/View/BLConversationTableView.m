//
//  BLConversationTableView.m
//  EMDemo
//
//  Created by 边雷 on 2017/8/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLConversationTableView.h"
#import <EaseMob.h>

static NSString *cellID = @"cellID";
@interface BLConversationTableView ()<UITableViewDataSource>

@end

@implementation BLConversationTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.conversations = [NSArray array];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    EMConversation *consat = self.conversations[indexPath.row];
    
    // 显示用户名
    
    NSInteger inter = consat.unreadMessagesCount;
    if (inter == 0) {
        cell.textLabel.text = consat.chatter;
    } else {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@          未读消息数:%ld", consat.chatter, [consat unreadMessagesCount]];
    }
    
    // 显示最后一行数据到副标题
    id body = consat.latestMessage.messageBodies[0];
    
    if ([body isKindOfClass:[EMTextMessageBody class]]) {
        EMTextMessageBody *textbody = body;
        cell.detailTextLabel.text = textbody.text;
    }else if([body isKindOfClass:[EMVoiceMessageBody class]]) {
        EMVoiceMessageBody *voicebody = body;
        cell.detailTextLabel.text = voicebody.displayName;
    }else if([body isKindOfClass:[EMImageMessageBody class]]){
        EMImageMessageBody *imageBody = body;
        cell.detailTextLabel.text = imageBody.displayName;
    }else {
        cell.detailTextLabel.text = @"未知类型";
    }
    
    cell.imageView.image = [UIImage imageNamed:@"user"];
    
    return cell;
}

@end
