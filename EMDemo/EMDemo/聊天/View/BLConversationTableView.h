//
//  BLConversationTableView.h
//  EMDemo
//
//  Created by 边雷 on 2017/8/15.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLConversationTableViewDelegate <NSObject>

- (void)pushChatVCWithInter:(NSInteger)interger;

@end

@interface BLConversationTableView : UITableView

@property(nonatomic, strong) NSArray *conversations;
@property(nonatomic, weak) id<BLConversationTableViewDelegate> delegatePush;
@end
