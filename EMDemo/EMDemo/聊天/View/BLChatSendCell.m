//
//  BLChatSendCell.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/23.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLChatSendCell.h"
#import <Masonry.h>
#import "EMCDDeviceManager.h"

static UIImageView *imageView;

@interface BLChatSendCell ()
@property(nonatomic, strong) UIImageView *iconImage;
@property(nonatomic, strong) UILabel *messageLab;
@end

@implementation BLChatSendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI {
    self.iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
    self.messageLab = [[UILabel alloc] init];
    
    self.messageLab.numberOfLines = [self.messageLab.text length];
    self.messageLab.preferredMaxLayoutWidth = self.frame.size.width - 120;
    self.messageLab.backgroundColor = [UIColor clearColor];
    // 开启用户交互
    self.messageLab.userInteractionEnabled  = YES;
    // 添加点击手势
    UITapGestureRecognizer *tapRecongizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageLabTapRecognizer:)];
    [self.messageLab addGestureRecognizer:tapRecongizer];
    
    self.messageLab.lineBreakMode = NSLineBreakByWordWrapping;
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_sender_bg"]];
    
    [self.contentView addSubview:self.iconImage];
    [self.contentView insertSubview:bgImage atIndex:0];
    [self.contentView addSubview:self.messageLab];
    
    // 布局
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.width.equalTo(@30);
    }];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.messageLab).offset(10);
        make.top.left.equalTo(self.messageLab).offset(-10);
    }];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
//        make.height.equalTo(@(self.rect.size.height));
        make.right.equalTo(self.iconImage.mas_left).offset(-20);
    }];
    
    
    
}

- (void)setStr:(NSMutableString *)str {
    _str = str;
    self.messageLab.text = str;
    
}

- (void)setMessage:(EMMessage *)message {
    _message = message;
    
    id body = message.messageBodies[0];
    
    if ([body isKindOfClass:[EMTextMessageBody class]]) {
        EMTextMessageBody *textbody = body;
        self.messageLab.text = textbody.text;
    }else if([body isKindOfClass:[EMVoiceMessageBody class]]) {
        self.messageLab.attributedText = [self sendVoiceAtt];
    }else if([body isKindOfClass:[EMImageMessageBody class]]){
        self.messageLab.text = @"图片";
    }else {
        self.messageLab.text = @"未知类型";
    }
}

// 发送语音富文本    ---- 时间 + 图片
- (NSAttributedString *)sendVoiceAtt {
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    EMVoiceMessageBody *mesageBody = self.message.messageBodies[0];
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld'", mesageBody.duration];
    NSAttributedString *timeAtt = [[NSAttributedString alloc]initWithString:timeStr];
    [attStr appendAttributedString:timeAtt];
    
    UIImage *image = [UIImage imageNamed:@"chat_sender_audio_playing_full"];
    NSTextAttachment *imageAli = [[NSTextAttachment alloc] init];
    imageAli.image = image;
    imageAli.bounds = CGRectMake(0, -9, 30, 30);
    
    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:imageAli];
    [attStr appendAttributedString:imgStr];
    
    return [attStr copy];
}

// label手势点击事件
- (void)messageLabTapRecognizer:(UITapGestureRecognizer *)recognizer {
    
    // bug:  点击两个语音, 第二个不会停止  ----- 上来就把之前的停止
    if ([[BLSharedEM sharedInstance].imageView isAnimating]) {
        
        [[BLSharedEM sharedInstance] stopAnimate];
    }
    
    id messageBody = self.message.messageBodies[0];
    if ([messageBody isKindOfClass:[EMVoiceMessageBody class]]) {
        
        EMVoiceMessageBody *messageBody = self.message.messageBodies[0];
        // 本地语音路径
        NSString *path = messageBody.localPath;
        NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager fileExistsAtPath:path]) {
            // 服务器语音路径
            path = messageBody.remotePath;
        }
        // 播放语音
        [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:path completion:^(NSError *error) {
            if (!error) {
                NSLog(@"播放语音成功");
                [[BLSharedEM sharedInstance] stopAnimate];
            }
        }];
        
        [[BLSharedEM sharedInstance] animateWithlabel:self.messageLab frame:CGRectMake(self.messageLab.bounds.size.width-30, 0, 30, 30) imageName:@"chat_sender_audio_playing_"];

    }
    
}

@end
