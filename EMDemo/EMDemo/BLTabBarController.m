//
//  BLTabBarController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/4.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLTabBarController.h"
#import "BLNavController.h"
#import "BLConversationVC.h"
#import "BLConfigVC.h"
#import "BLAddressBookVC.h"

@interface BLTabBarController ()

@end

@implementation BLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *vc1 = [self controllerWith:@"BLConversationVC" title:@"聊天"];
    UIViewController *vc2 = [self controllerWith:@"BLAddressBookVC" title:@"通讯录"];
    UIViewController *vc3 = [self controllerWith:@"BLConfigVC" title:@"设置"];
    self.viewControllers = @[vc1,vc2,vc3];
}

// 当控制器是sb创建的时候
-(UIViewController *)controllerWithStoryboard:(NSString *)storyboardName title:(NSString*) title {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    // 初始化箭头所指向的控制器
    //    UIViewController *vc = [sb instantiateInitialViewController];
    
    // 根据storyBoardID加载sb
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"businesses"];
    
    return [self controller:vc title:title];
}

-(UIViewController *)controllerWith:(NSString *)className title:(NSString *)title {
    Class clz = NSClassFromString(className);
    UIViewController *vc = [[clz alloc] init];
    
    return [self controller:vc title:title];
}

-(UIViewController *)controller:(UIViewController *)vc title:(NSString *)title {
    
//    vc.title = title;
    BLNavController *nav = [[BLNavController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    
    return nav;
}


@end
