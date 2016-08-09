//
//  KeyboardEmoticonTextView.m
//  keyboardEmotion
//
//  Created by lenhart on 16/7/11.
//  Copyright © 2016年 lenhart. All rights reserved.
//

#import "KeyboardEmoticonTextView.h"
#import "KeyboardEmoticonAttachment.h"
#import "KeyboardEmoticonModel.h"

@implementation KeyboardEmoticonTextView

- (void)insertEmoticon:(KeyboardEmoticonModel *)emoticon {
    NSString *temp = emoticon.emojiStr;
    if (temp && ![temp isEqualToString:@"\0"]) {
        [self replaceRange:self.selectedTextRange withText:temp];
    }
    
    if (emoticon.imagePath) {
        NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        NSAttributedString *emoticonStr = [KeyboardEmoticonAttachment emoticonString:emoticon font:[UIFont systemFontOfSize:40]];
        
        NSRange range = self.selectedRange;
        [stringM replaceCharactersInRange:range withAttributedString:emoticonStr];
        
        [stringM addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(range.location, 1)];
        
        self.attributedText = stringM;
        
        self.selectedRange = NSMakeRange(range.location + 1, 0);
        return;
    }
}

- (NSString *)emoticonString {
    NSString *string;
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary* attrs, NSRange range, BOOL * stop) {
        if (attrs[@"NSAttachment"]) {
            KeyboardEmoticonAttachment *attachment = attrs[@"NSAttachment"];
            [string stringByAppendingString:attachment.chs];
        } else {
            [string stringByAppendingString:[self.attributedText.string substringWithRange:range]];
        }
    }];
    
    return string;
}

@end
