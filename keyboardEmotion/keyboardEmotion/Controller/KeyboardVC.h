//
//  KeyboardVC.h
//  keyboardEmotion
//
//  Created by lenhart on 16/7/11.
//  Copyright © 2016年 lenhart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyboardEmoticonModel;

typedef void(^EmoticonCallBack)(KeyboardEmoticonModel *keyboardEmoticon);


@interface KeyboardVC : UIViewController

/** 回调 */
@property (nonatomic, strong) EmoticonCallBack emoticonCallBack;


- (instancetype)initWithCallBack:(EmoticonCallBack)callBack;

@end
