//
//  BLNavController.m
//  ProjectConstructDemo
//
//  Created by 边雷 on 17/4/10.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLNavController.h"

@interface BLNavController ()

@end

@implementation BLNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // barTintColor 导航条颜色
    self.navigationBar.barTintColor = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
    
    // 取消导航条下方黑线
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 如果隐藏了黑线(空背景图片和空阴影图片),必须要设置translucent透明效果为no才能够看到背景颜色
    self.navigationBar.translucent = NO;
    
    // 设置标题文字颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 设置导航条barbuttonItem颜色
    self.navigationBar.tintColor = [UIColor whiteColor];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
/*
  1.如果控制器被添加到导航控制器的时候, 它自己默认不能再设置状态栏, 需要让导航控制器统一设置
  2.如果设置下面这段代码,导航控制器中preferredStatusBarStyle方法就没有效果了!!!
  3.childViewControllerForStatusBarStyle这个方法是导航控制器不在统一设置状态栏样式了, 显示的那个控制器, 就由他们自己设置
 - (UIViewController *)childViewControllerForStatusBarStyle {
     return self.topViewController;
 }
 */

@end
