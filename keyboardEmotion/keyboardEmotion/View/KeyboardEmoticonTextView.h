//
//  KeyboardEmoticonTextView.h
//  keyboardEmotion
//
//  Created by lenhart on 16/7/11.
//  Copyright © 2016年 lenhart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyboardEmoticonModel;

@interface KeyboardEmoticonTextView : UITextView

/**
 插入表情
 
 - parameter emoticon: 需要插入的表情模型
 */
- (void)insertEmoticon:(KeyboardEmoticonModel *)emoticon;

/**
 获取属性字符串对应的文本字符串
 
 - returns: 文本字符串
 */
- (NSString *)emoticonString;

@end
