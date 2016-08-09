//
//  KeyboardEmoticonPackage.m
//  keyboardEmotion
//
//  Created by lenhart on 16/7/11.
//  Copyright © 2016年 lenhart. All rights reserved.
//

#import "KeyboardEmoticonPackage.h"
#import "KeyboardEmoticonModel.h"
#import "KeyboardEmoticonAttachment.h"

static NSArray *_packages = nil;

@implementation KeyboardEmoticonPackage

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}



+ (NSArray *)packages {
    return _packages;
}

+ (NSArray *)loadPackages {
    if (_packages) {
        return _packages;
    }
    
    NSMutableArray *models = [NSMutableArray array];
    KeyboardEmoticonPackage *packge = [[KeyboardEmoticonPackage alloc] init];
//    packge.emoticons = [NSMutableArray array];
//    [models addObject:packge];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *array = dict[@"packages"];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"emotion.plist" ofType:nil];
//    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in array) {
        KeyboardEmoticonPackage *package = [[KeyboardEmoticonPackage alloc] initWithDict:dict];
        [packge loadEmoticons];
        [packge appendEmptyEmoticon];
        [models addObject:package];
    }
    
    _packages = models;
    return models;
}


/**
 *  加载当前组所有的表情
 */
- (void)loadEmoticons {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emotion.plist" ofType:nil];
    
//    NSString *filePath = [path stringByAppendingPathComponent:@"emotion.plist"];
    
//    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    
//    self.group_name_cn = dict[@"group_name_cn"];
//    
//    NSArray *array = dict[@"emoticons"];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *models = [NSMutableArray array];
    
    NSInteger index = 0;
    
    for (NSDictionary *dict in array) {
        KeyboardEmoticonModel *emotion = [[KeyboardEmoticonModel alloc] initWithDict:dict];
        emotion.id = self.id;
        [models addObject:emotion];
        index ++;
    }
    
    self.emoticons = models;
}


/**
 根据字符串查找表情模型
 
 - parameter str: 指定字符串
 
 - returns: 表情模型
 */
- (KeyboardEmoticonModel *)findEmoticon:(NSString *)string {
    __block KeyboardEmoticonModel *emotion;
    for (KeyboardEmoticonPackage *package in [KeyboardEmoticonPackage loadPackages]) {
        [package.emoticons enumerateObjectsUsingBlock:^(KeyboardEmoticonModel *item, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item.name isEqualToString:string]) {
                emotion = item;
            }
        }];
        
        if (emotion) {
            break;
        }
    }
    return emotion;
}


/**
 *  追加空白按钮, 当当前组的数据不能被8整除时, 就追加空白按钮, 让当前组能够被8整除
 */
- (void)appendEmptyEmoticon {
    NSInteger count = self.emoticons.count % 8;
    if (!count) return;
    for (NSInteger i = count; i < 8; i++) {
        [self.emoticons addObject:[KeyboardEmoticonModel new]];
    }
}

#pragma mark - lazy 

- (NSMutableArray *)emoticons {
    if (!_emoticons) {
        _emoticons = [NSMutableArray array];
    }
    return _emoticons;
}

#pragma mark - 外部方法
- (NSAttributedString *)attributedString:(NSString *)string font:(UIFont *)font {
    NSString *pattern = @"\\[\\w+\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *array = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    NSMutableAttributedString *stringM = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSInteger index = array.count;
    while (index > 0) {
        index --;
        NSTextCheckingResult *result = array[index];
        NSString *temp = [string substringWithRange:result.range];
        KeyboardEmoticonModel *emotion = [self findEmoticon:temp];
        if (!emotion) continue;
        
        NSAttributedString *attrString = [KeyboardEmoticonAttachment emoticonString:emotion font:font];
        
        [stringM replaceCharactersInRange:result.range withAttributedString:attrString];
    }
    
    return stringM;
}


#pragma mark - 单例
+ (instancetype)shareInstance {
    KeyboardEmoticonPackage *instance = [[self alloc] init];
    return instance;
}

static KeyboardEmoticonPackage *_instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}


@end
