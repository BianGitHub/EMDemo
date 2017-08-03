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
#import "BLChatCell.h"
#import "BLChatSendCell.h"

static NSString *chatCell = @"chatCell";
static NSString *chatSendCell = @"chatSendCell";

@interface BLChatViewController ()<UITextViewDelegate, EMChatManagerDelegate>
@property(nonatomic, strong) UITextView *textV;
@property(nonatomic, strong) UIView *bottomV;
//@property(nonatomic, strong) BLCharView *tableV;
@property(nonatomic, strong) BLCharView *tableV;
@end

@implementation BLChatViewController {
    NSMutableArray *_arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.buddy.username;
    EMBuddy *buddy = [[EaseMob sharedInstance].chatManager buddyList][self.integerRow];
    self.navigationItem.title = buddy.username;
    _arr = [NSMutableArray array];
    [self loadChatMessageData];
    [self setupUI];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
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
//        [self.tableV mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.bottomV.mas_top);
//            make.height.equalTo(@(self.view.bounds.size.height-40-64-keyboardF.size.height));
//        }];
        [self.view layoutIfNeeded];
    }];
    [UIView animateWithDuration:duration animations:^{
        [self scrollToLastIndex];
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
    self.tableV.buddy = self.buddy;
    self.tableV.messageArr = _arr;
    [self.tableV registerClass:[BLChatCell class] forCellReuseIdentifier:chatCell];
    [self.tableV registerClass:[BLChatSendCell class] forCellReuseIdentifier:chatSendCell];
    
    UIButton *speechBtn = [self createBtnWithImage:@"chatBar_record"];
    UIButton *emojBtn = [self createBtnWithImage:@"chatBar_face"];
    UIButton *moreBtn = [self createBtnWithImage:@"chatBar_more"];
    
    self.textV = [[UITextView alloc] init];
    self.textV.delegate = self;
    self.textV.backgroundColor = [UIColor grayColor];
    [self.textV setFont:[UIFont systemFontOfSize:15]];
    self.textV.layer.cornerRadius = 7;
    self.textV.clipsToBounds = YES;
    self.textV.returnKeyType = UIReturnKeySend;
    
    [self.view addSubview:self.bottomV];
    [self.view insertSubview:self.tableV atIndex:0];
    [self.bottomV addSubview:speechBtn];
    [self.bottomV addSubview:emojBtn];
    [self.bottomV addSubview:moreBtn];
    [self.bottomV addSubview:self.textV];
    
    
    // masonry布局
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomV.mas_top);
    }];
    
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

- (void)viewWillAppear:(BOOL)animated {
    [self scrollToLastIndex];
    [self.tableV reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.textV endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextVeiwDelegeate
- (void)textViewDidChange:(UITextView *)textView {
    
    NSLog(@"%@", textView.text);
    // 监听换行就是监听发送按钮
    if ([textView.text hasSuffix:@"\n"]) {
        NSLog(@"发送");
        NSString *str = self.textV.text;
        self.textV.text = @"";
        [self sendTextWithText:str];
    }
}

- (void)sendTextWithText:(NSString *)text {
    text = [text substringToIndex:text.length-1];
    if ([text isEqualToString:@""]) {
        return;
    }
    
    // 发送消息
    EMChatText *chatTet = [[EMChatText alloc] initWithText:text];
    EMTextMessageBody *textBody = [[EMTextMessageBody alloc] initWithChatObject:chatTet];
    EMMessage *message = [[EMMessage alloc] initWithReceiver:self.buddy.username bodies:@[textBody]];
    message.messageType = eMessageTypeChat; // 单聊  (默认)
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"path -----%@", path);
    [[EaseMob sharedInstance].chatManager asyncSendMessage:message progress:nil prepare:^(EMMessage *message, EMError *error) {
        NSLog(@"准备发送 %@-%@", error, self.buddy.username);
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        NSLog(@"发送成功 %@", error);
        // 添加到数据源, 刷新表格显示
        [_arr addObject:message];
        [self.tableV reloadData];
        // 发送完消息向上滚动
        [self scrollToLastIndex];
    } onQueue:nil];
    
    
}

- (void)loadChatMessageData {
    // 会话对象 ---  获取本地聊天记录
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self
                                    .buddy.username conversationType:eConversationTypeChat];
    // 加载所有聊天记录
    NSArray *messages = [conversation loadAllMessages];
    [_arr addObjectsFromArray:messages];
}

// 滚动到最后一行
- (void)scrollToLastIndex {
    
    if (_arr.count == 0) {
        return;
    }
    
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:_arr.count - 1 inSection:0];
    [self.tableV scrollToRowAtIndexPath:indexP atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - EMChatManagerDelegate   
// 接受到消息
- (void)didReceiveMessage:(EMMessage *)message {
    [_arr addObject:message];
    [self.tableV reloadData];
    [self scrollToLastIndex];
}

@end
