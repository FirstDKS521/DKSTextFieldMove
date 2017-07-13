//
//  DKSAutoMoveController.m
//  DKSTextFieldMove
//
//  Created by aDu on 2017/7/13.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "DKSAutoMoveController.h"
#import "UIView+FrameTool.h"

@interface DKSAutoMoveController ()

@property (nonatomic, assign) CGFloat totalYOffset;

@end

@implementation DKSAutoMoveController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _totalYOffset = 0;
    }
    return self;
}

#pragma mark ====== 添加键盘的监听 ======
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

#pragma mark ====== 移除键盘的监听 ======
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

#pragma mark ====== 键盘的监听方法 ======
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self.view.layer removeAllAnimations];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    //找到当前页面第一响应者
    UIView *firstResponderView = [keyWindow performSelector:@selector(findFirstResponder)];
    
    CGRect rect = [[UIApplication sharedApplication].keyWindow convertRect:firstResponderView.frame fromView:firstResponderView.superview];
    //获取响应者的最大Y值
    CGFloat maxY = rect.origin.y + rect.size.height;
    //获取键盘的最小Y值
    CGFloat keyboardY = self.view.window.size.height - keyboardHeight;
    if (maxY > keyboardY) {
        _totalYOffset = maxY - keyboardY;
        //键盘的动画时长
        double keyTime = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration:keyTime delay:0 options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] animations:^{
            self.view.y -= _totalYOffset;
        } completion:nil];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    //键盘的动画时长
    double keyTime = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:keyTime
                          delay:0
                        options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
        self.view.y = 0;
    } completion:nil];
    _totalYOffset = 0;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
}

- (void)keyboardDidHide:(NSNotification *)notification {
    
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
