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

@interface BLConversationVC ()<EMChatManagerDelegate>
@property(nonatomic, strong)NSArray *conversations;
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
    tableview.conversations = self.conversations;
    [self.view addSubview:tableview];
    
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

@end
