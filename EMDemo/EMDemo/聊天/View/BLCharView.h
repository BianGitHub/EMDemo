//
//  BLCharView.h
//  EMDemo
//
//  Created by 边雷 on 2017/7/23.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCharView : UITableView
@property(nonatomic, strong) EMBuddy *buddy;
@property(nonatomic, strong) NSMutableArray *messageArr;
@end
