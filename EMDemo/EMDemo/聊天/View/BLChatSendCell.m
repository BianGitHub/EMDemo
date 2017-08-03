//
//  BLChatSendCell.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/23.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLChatSendCell.h"
#import <Masonry.h>

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
//    self.messageLab.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
//    
//    self.rect = [self.messageLab.text boundingRectWithSize:CGSizeMake(self.bounds.size.width - 120, 300) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    
    
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
    }else if([body isKindOfClass:[EMVideoMessageBody class]]) {
        self.messageLab.text = @"[语音]";
    }else if([body isKindOfClass:[EMImageMessageBody class]]){
        self.messageLab.text = @"图片";
    }else {
        self.messageLab.text = @"未知类型";
    }
}

@end
