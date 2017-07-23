//
//  BLChatViewController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/19.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLChatViewController.h"
#import "BLCharView.h"
#import <EaseMob.h>
#import <Masonry.h>

@interface BLChatViewController ()
@property(nonatomic, strong) UITextView *textV;
@property(nonatomic, strong) UIView *bottomV;
@property(nonatomic, strong) BLCharView *tableV;
@end

@implementation BLChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    EMBuddy *buddy = [[EaseMob sharedInstance].chatManager buddyList][self.integerRow];
    self.navigationItem.title = buddy.username;
    [self setupUI];
    
    // 监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    // 监听键盘退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 监听键盘弹出方法
- (void)keyboardWillShow:(NSNotification *)noti {
    
    // 获取键盘frame
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 获取键盘动画时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-keyboardF.size.height);
        }];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 监听键盘收回
- (void)keyboardWillHide:(NSNotification *)noti {
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.bottomV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        [self.view layoutIfNeeded];
    }];
}

- (void)setupUI {
    
    self.bottomV = [[UIView alloc] init];
    self.bottomV.backgroundColor = [UIColor lightGrayColor];
    
    self.tableV = [[BLCharView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-40-64) style:UITableViewStylePlain];
    
    UIButton *speechBtn = [self createBtnWithImage:@"chatBar_record"];
    UIButton *emojBtn = [self createBtnWithImage:@"chatBar_face"];
    UIButton *moreBtn = [self createBtnWithImage:@"chatBar_more"];
    
    self.textV = [[UITextView alloc] init];
    self.textV.backgroundColor = [UIColor grayColor];
    [self.textV setFont:[UIFont systemFontOfSize:15]];
    self.textV.layer.cornerRadius = 7;
    self.textV.clipsToBounds = YES;
    
    [self.view addSubview:self.bottomV];
    [self.view insertSubview:self.tableV atIndex:0];
    [self.bottomV addSubview:speechBtn];
    [self.bottomV addSubview:emojBtn];
    [self.bottomV addSubview:moreBtn];
    [self.bottomV addSubview:self.textV];
    
    
    // masonry布局
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    [speechBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomV.mas_left).offset(3);
        make.bottom.equalTo(self.bottomV.mas_bottom).offset(-3);
        make.size.equalTo(@33);
    }];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomV.mas_right).offset(-3);
        make.bottom.equalTo(self.bottomV.mas_bottom).offset(-3);
        make.size.equalTo(@33);
    }];
    
    [emojBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moreBtn.mas_left).offset(-6);
        make.bottom.equalTo(self.bottomV.mas_bottom).offset(-3);
        make.size.equalTo(@33);
    }];
    
    [self.textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(speechBtn.mas_right).offset(5);
        make.right.equalTo(emojBtn.mas_left).offset(-5);
        make.bottom.equalTo(self.bottomV.mas_bottom).offset(-3);
        make.height.equalTo(@33);
    }];
    
}

// 创建按钮
- (UIButton *)createBtnWithImage:(NSString *)imageStr {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@Selected", imageStr]] forState:UIControlStateSelected];
    return btn;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.textV endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
