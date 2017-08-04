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

- (UIImageView *)imageView {
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)alertViewShow:(NSString *)str controller:(UIViewController *)vc handler:(void(^)())handler{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    if (handler == nil) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:handler];
        [alertC addAction:alertAction];
    } else {
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
        [alertC addAction:alertAction];
    }
    [vc presentViewController:alertC animated:YES completion:nil];
}


- (void)animateWithlabel:(UILabel *)lab frame:(CGRect)frame imageName:(NSString *)imageName {
    
    self.imageView.frame = frame;
    [lab addSubview:self.imageView];
    self.imageView.animationImages = @[[UIImage imageNamed:[NSString stringWithFormat:@"%@000", imageName]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"%@001", imageName]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"%@002", imageName]],
                               [UIImage imageNamed:[NSString stringWithFormat:@"%@003", imageName]]];
    self.imageView.animationDuration = 1;
    [self.imageView startAnimating];
}

- (void)stopAnimate {
    [self.imageView stopAnimating];
    [self.imageView removeFromSuperview];
}

@end
