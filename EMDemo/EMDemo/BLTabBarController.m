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
#import <EaseMob.h>

@interface BLTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.delegate = self;
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

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSLog(@"%@", item.title);
    if ([item.title isEqualToString:@"通讯录"]) {
        // 重新获取好友
        [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
            if (!error) {
                NSLog(@"获取成功 -- %@",buddyList);
            }
        } onQueue:nil];
        
        id vc = self.viewControllers[1];
        [vc popToRootViewControllerAnimated:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadcontroller" object:nil];
    }
}


@end
