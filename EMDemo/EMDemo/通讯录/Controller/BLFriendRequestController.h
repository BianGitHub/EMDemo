//
//  BLFriendRequestController.h
//  EMDemo
//
//  Created by 边雷 on 2017/7/7.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLFriendRequestControllerDelegate <NSObject>

- (void)didSelectAgreeAction;

@end

@interface BLFriendRequestController : UITableViewController
@property (nonatomic, weak) id<BLFriendRequestControllerDelegate> delegate;
@end
