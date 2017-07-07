//
//  BLSharedEM.h
//  EMDemo
//
//  Created by 边雷 on 2017/7/7.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLSharedEM : NSObject

//@property (nonatomic ,assign) NSInteger newFriend;
@property (nonatomic ,strong) NSMutableArray *friendCount;

+ (instancetype)sharedInstance;
@end
