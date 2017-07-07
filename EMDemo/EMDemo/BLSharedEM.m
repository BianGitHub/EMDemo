//
//  BLSharedEM.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/7.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLSharedEM.h"
static BLSharedEM *sem = nil;
@implementation BLSharedEM

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sem = [self new];
    });
    return sem;
}

//- (NSInteger)newFriend {
//    if (!_newFriend) {
//        _newFriend = 0;
//    }
//    return _newFriend;
//}

- (NSMutableArray *)friendCount {
    if (!_friendCount) {
        _friendCount = [NSMutableArray arrayWithCapacity:0];
    }
    return _friendCount;
}

@end
