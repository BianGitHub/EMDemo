//
//  BLChatCell.m
//  EMDemo
//
//  Created by 边雷 on 2017/7/23.
//  Copyright © 2017年 Mac-b. All rights reserved.
//

#import "BLChatCell.h"
#import <Masonry.h>

@interface BLChatCell ()
@property(nonatomic, strong) UIImageView *iconImage;
@property(nonatomic, strong) UILabel *messageLab;
@end

@implementation BLChatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.str = [NSString string];
        
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
    self.messageLab.lineBreakMode = NSLineBreakByWordWrapping;
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_receiver_bg"]];
    
    [self.contentView addSubview:self.iconImage];
    [self.contentView insertSubview:bgImage atIndex:0];
    [self.contentView addSubview:self.messageLab];
    
    // 布局
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.height.width.equalTo(@30);
    }];
    
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.messageLab).offset(10);
        make.top.left.equalTo(self.messageLab).offset(-10);
    }];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.left.equalTo(self.iconImage.mas_right).offset(20);
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
    }
}

@end
