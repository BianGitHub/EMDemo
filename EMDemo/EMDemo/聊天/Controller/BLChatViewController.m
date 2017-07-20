//
//  BLChatViewController.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/19.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLChatViewController.h"
#import <EaseMob.h>
#import <Masonry.h>

@interface BLChatViewController ()
@property(nonatomic, weak) UITextView *textV;
@property(nonatomic, weak) UIView *bottomV;
@property(nonatomic, weak) UITableView *tableV;
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
    
    UIView *bottomV = [[UIView alloc] init];
    bottomV.backgroundColor = [UIColor lightGrayColor];
    self.bottomV = bottomV;
    
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-40-64) style:UITableViewStylePlain];
    tableV.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableV = tableV;
    
    UIButton *speechBtn = [self createBtnWithImage:@"chatBar_record"];
    UIButton *emojBtn = [self createBtnWithImage:@"chatBar_face"];
    UIButton *moreBtn = [self createBtnWithImage:@"chatBar_more"];
    
    UITextView *textV = [[UITextView alloc] init];
    textV.backgroundColor = [UIColor grayColor];
    [textV setFont:[UIFont systemFontOfSize:15]];
    textV.layer.cornerRadius = 7;
    textV.clipsToBounds = YES;
    self.textV = textV;
    
    [self.view addSubview:bottomV];
    [self.view insertSubview:tableV atIndex:0];
    [bottomV addSubview:speechBtn];
    [bottomV addSubview:emojBtn];
    [bottomV addSubview:moreBtn];
    [bottomV addSubview:textV];
    
    
    // masonry布局
    [bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    [speechBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomV.mas_left).offset(3);
        make.bottom.equalTo(bottomV.mas_bottom).offset(-3);
        make.size.equalTo(@33);
    }];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomV.mas_right).offset(-3);
        make.bottom.equalTo(bottomV.mas_bottom).offset(-3);
        make.size.equalTo(@33);
    }];
    
    [emojBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moreBtn.mas_left).offset(-6);
        make.bottom.equalTo(bottomV.mas_bottom).offset(-3);
        make.size.equalTo(@33);
    }];
    
    [textV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(speechBtn.mas_right).offset(5);
        make.right.equalTo(emojBtn.mas_left).offset(-5);
        make.bottom.equalTo(bottomV.mas_bottom).offset(-3);
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
