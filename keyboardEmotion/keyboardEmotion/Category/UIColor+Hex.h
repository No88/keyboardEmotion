//
//  UIColor+Hex.h
//  keyboardEmotion
//
//  Created by lenhart on 16/7/12.
//  Copyright © 2016年 lenhart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 
 colorWithHexString("#ff00dd")
 
 colorWithHexString("ff00dd")
 
 - parameter hex:   颜色
 - parameter alpha: 透明度
 */
+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hex;

@end
