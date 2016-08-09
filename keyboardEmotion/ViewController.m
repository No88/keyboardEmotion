//
//  ViewController.m
//  keyboardEmotion
//
//  Created by lenhart on 16/7/11.
//  Copyright © 2016年 lenhart. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardVC.h"
#import "KeyboardEmoticonTextView.h"
#import "KeyboardEmoticonPackage.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet KeyboardEmoticonTextView *textView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;


@property (nonatomic, strong) KeyboardVC *keyboardVC;

@property (nonatomic, strong) NSArray *models;
@end

@implementation ViewController
- (IBAction)inputEmoticon:(UIBarButtonItem *)sender {
    
    [self.textView resignFirstResponder];
    
    if (self.textView.inputView) {
        self.textView.inputView = nil;
    } else {
        self.textView.inputView = self.keyboardVC.view;
    }
    
    [self.textView becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meinv"]];
    image.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = image;
    
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)keyboardWillChange:(NSNotification *)notice {
    CGRect rect = [notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat screenHetght = [UIScreen mainScreen].bounds.size.height;
    CGFloat offSetY = screenHetght - rect.origin.y;
    self.toolBarBottom.constant = offSetY;
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom = offSetY + 44;
    self.tableView.contentInset = contentInset;
    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationCurve:7];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - lazy 

- (KeyboardVC *)keyboardVC {
    if (!_keyboardVC) {
        _keyboardVC = [[KeyboardVC alloc] initWithCallBack:^(KeyboardEmoticonModel *keyboardEmoticon) {
            [self.textView insertEmoticon:keyboardEmoticon];
        }];
    }
    return _keyboardVC;
}


- (NSArray *)models {
    if (!_models) {
        _models = @[@"[YY][YY][喜欢][YY][亲][YY][YY][爱心][YY][无聊][YY][小便][YY][YY][快乐][YY]dasdas",
                    @"[噗。。][噗。。][噗。。][噗。。][噗。。][噗。。][噗。。][噗。。]俺就是道具卡上的课",
                    @"[爱心][爱心][爱心]的发送到发送到[爱心][爱心][爱心][爱心]",
                    @"[亲亲][亲亲][亲亲][亲亲]",
                    @"[拍桌子]爱心][爱心]地方暗室逢灯[爱心][拍桌子][拍桌子]",
                    @"[娇羞]",
                    @"[娇羞2]",
                    @"[快乐][爱心][拍桌子]",
                    @"[无聊][娇羞2][织女]",
                    @"[无奈][娇羞2][织女]",
                    @"[喜欢][娇羞2][织女]",
                    @"[吹风扇]",
                    @"[狂汗][狂汗][狂汗][狂汗][狂汗]",
                    @"[小便][狂汗][狂汗]",
                    @"[学习] 大事发生发[狂汗][狂汗]",
                    @"[织女]发送到发送到",
                    @" 答复啊[我不听]是打发第三方",
                    @"[拖]",
                    @"[受伤]范德萨发的",];
    }
    return _models;
}

#pragma mark - 代理


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.textLabel.numberOfLines = 0;
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.attributedText = [[KeyboardEmoticonPackage shareInstance] attributedString:self.models[indexPath.row] font:[UIFont systemFontOfSize:40]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textView resignFirstResponder];
}

@end
