//
//  KeyboardEmoticonAttachment.m
//  keyboardEmotion
//
//  Created by lenhart on 16/7/11.
//  Copyright © 2016年 lenhart. All rights reserved.
//

#import "KeyboardEmoticonAttachment.h"
#import "KeyboardEmoticonModel.h"


@implementation KeyboardEmoticonAttachment

+ (NSAttributedString *)emoticonString:(KeyboardEmoticonModel *)emoticon font:(UIFont *)font {
    KeyboardEmoticonAttachment *attachment = [[KeyboardEmoticonAttachment alloc] init];
    attachment.image = [UIImage imageWithContentsOfFile:emoticon.imagePath];
    attachment.chs = emoticon.name;
    
    CGFloat height = font.lineHeight;
    attachment.bounds = CGRectMake(0, -4, height, height);
    return [NSAttributedString attributedStringWithAttachment:attachment];
}

@end
