//
//  BLConversationVC.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/4.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLConversationVC.h"
#import <EaseMob.h>
#import "BLSharedEM.h"
#import "BLConversationTableView.h"
#import "BLChatViewController.h"

@interface BLConversationVC ()<EMChatManagerDelegate, BLConversationTableViewDelegate>
@property(nonatomic, strong)NSArray *conversations;
@property(nonatomic, strong)BLConversationTableView *tableview;
@end

@implementation BLConversationVC {
    
    NSMutableDictionary *_dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"聊天";
    _dict = [NSMutableDictionary dictionaryWithCapacity:0];
    // 设置代理
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    // 显示历史会话
    [self loadConversation];
    
    BLConversationTableView *tableview = [[BLConversationTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableview = tableview;
    self.tableview.delegatePush = self;
    tableview.conversations = self.conversations;
    [self.view addSubview:tableview];
    
    // 显示tabbarBage
    [self showTabBarbadge];
}

- (void)loadConversation {
    // 先从内存中获取
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    
    // 如果内存中没有, 从服务器中获取
    if (conversations.count == 0) {
        conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    }
    self.conversations = conversations;
    NSLog(@"conversation====== %@", conversations);
}

// 监听网络状态
-(void)didConnectionStateChanged:(EMConnectionState)connectionState {
    switch (connectionState) {
        case eEMConnectionConnected:
            NSLog(@"连接网络");
            self.navigationItem.title = @"正在连接...";
            break;
        case eEMConnectionDisconnected:
            NSLog(@"网络断开, 未连接");
            self.navigationItem.title = @"未连接...";
            break;
            
        default:
            break;
    }
}

/*
 @brief 将要发起自动重连操作时发送该回调
 */
- (void)willAutoReconnect {
    NSLog(@"将要发起自动重连操作时发送该回调");
    self.navigationItem.title = @"连接中...";
}

/*
 @brief 自动重连操作完成后的回调（成功的话，error为nil，失败的话，查看error的错误信息）
 */
- (void)didAutoReconnectFinishedWithError:(NSError *)error {
    NSLog(@"自动重连操作完成后的回调 - %@", error);
    self.navigationItem.title = @"聊天";
}


/*!
 @brief 接收到好友请求时的通知
 @param username 发起好友请求的用户username
 @param message  收到好友请求时的say hello消息
 */
- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:username forKey:@"username"];
    [dict setValue:message forKey:@"message"];
    [[BLSharedEM sharedInstance].friendCount addObject:dict];

}

// 历史会话列表改变
- (void)didUpdateConversationList:(NSArray *)conversationList {
    
    self.tableview.conversations = conversationList;
    [self.tableview reloadData];
    // 显示tabbarBage
    [self showTabBarbadge];
}

// 未读消息数改变
- (void)didUnreadMessagesCountChanged {
    [self.tableview reloadData];
    
    // 显示tabbarBage
    [self showTabBarbadge];
}

// 显示tabbarBage
- (void)showTabBarbadge{
    // 遍历所有会话记录, 将未读消息累加
    NSInteger totalInter = 0;
    for (EMConversation *conversation in self.conversations) {
        totalInter += [conversation unreadMessagesCount];
    }
    
    if (totalInter == 0) {
        return;
    }
    self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", totalInter];
}

- (void)pushChatVCWithInter:(NSInteger)interger {
    // push时隐藏tabbar, 返回来时tabbar恢复正常
    self.hidesBottomBarWhenPushed = YES;
    BLChatViewController *chatVC = [[BLChatViewController alloc] init];
    chatVC.integerRow = interger;
    chatVC.buddy = [[EaseMob sharedInstance].chatManager buddyList][interger];
    [self.navigationController pushViewController:chatVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
    // 显示tabbarBage
    [self showTabBarbadge];
}

@end
