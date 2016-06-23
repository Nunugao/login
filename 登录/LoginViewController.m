//
//  LoginViewController.m
//  登录
//
//  Created by NuNu on 16/6/12.
//  Copyright © 2016年 NuNu. All rights reserved.
//

#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "LoginViewController.h"
//三原色的设置
#define kRGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface LoginViewController ()
@property (nonatomic) UILabel *nameLb;
@property (nonatomic) UILabel *postLb;
@property (nonatomic) UITextField *nameTF;
@property (nonatomic) UITextField *postTF;
@property (nonatomic) UIImageView *iocn;
@property (nonatomic) UIButton *loginBtn;

@end

@implementation LoginViewController

#pragma mark - <#生命周期#> Life circle

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self nameTF];
    [self nameLb];
    [self postTF];
    [self postLb];
    [self iocn];
    [self loginBtn];
        self.view.backgroundColor = kRGBA(197, 213, 227, 1);
    //监听了键盘将要出现跟键盘将要隐藏两个事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardStateChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//当键盘状态被修改时,触发
- (void)keyboardStateChanged:(NSNotification *)sender{
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [sender userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        // 修改下边距约束
        [_loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-keyboardHeight);
        }];
        [_iocn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(90);
            make.centerX.equalTo(0);
            make.top.equalTo(90);
        }];
        [self.view layoutIfNeeded];
    }];
}
//将要隐藏的时候,把约束还原成刚开始的样子.
- (void)keyboardWillHideNotification:(NSNotification *)sender {
    // 获得键盘动画时长
    NSDictionary *userInfo = [sender userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        // 修改为以前的约束（距下边距0）
        [_loginBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
        }];
        [_iocn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(140);
            make.centerX.equalTo(0);
            make.top.equalTo(100);
        }];
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 方法 Methods
- (void)loginAction:(UIButton *)sender {
    
}

#pragma mark - 懒加载 lazy load
- (UILabel *)nameLb {
    if (!_nameLb) {
        _nameLb = [UILabel new];
        _nameLb .backgroundColor = [UIColor clearColor];
        _nameLb.textColor = [UIColor blackColor];
        _nameLb.text = @"登录账号";
        _nameLb.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:_nameLb];
        [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(40);
            make.width.equalTo(100);
            make.height.equalTo(40);
//            make.centerY.equalTo(0);
            make.top.equalTo(self.iocn.mas_bottom).equalTo(50);
        }];
    }
    return _nameLb;
}
- (UILabel *)postLb {
    if (!_postLb) {
        _postLb = [UILabel new];
        _postLb .backgroundColor = [UIColor clearColor];
        _postLb.textColor = [UIColor blackColor];
        _postLb.text = @"登录密码";
        _postLb.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:_postLb];
        [_postLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(40);
            make.width.equalTo(100);
            make.height.equalTo(40);
            make.top.equalTo(self.nameLb.mas_bottom).equalTo(15);
        }];
    }
    return _postLb;
}
- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [UITextField new];
        [self.view addSubview:_nameTF];
        _nameTF.borderStyle = UITextBorderStyleNone;
//        _nameTF.layer.borderWidth = 1;
        _nameTF.placeholder = @"请输入您的账号";
        _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nameTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _nameTF.backgroundColor = kRGBA(197, 213, 227, 1);
        [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLb.mas_right).equalTo(0);
//            make.centerY.equalTo(0);
            make.right.equalTo(-40);
            make.height.equalTo(40);
            make.top.equalTo(self.iocn.mas_bottom).equalTo(50);
        }];
    }
    return _nameTF;
}
- (UITextField *)postTF {
    if (!_postTF) {
        _postTF = [UITextField new];
        [self.view addSubview:_postTF];
        _postTF.borderStyle = UITextBorderStyleNone;
        _postTF.secureTextEntry = YES;
//        _postTF.layer.borderWidth = 1;
        _postTF.placeholder = @"请输入您的密码";
        _postTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _postTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _postTF.backgroundColor = kRGBA(197, 213, 227, 1);
        [_postTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.postLb.mas_right).equalTo(0);
            make.top.equalTo(self.nameTF.mas_bottom).equalTo(15);
            make.right.equalTo(-40);
            make.height.equalTo(40);
        }];
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:@"ic_question"];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(70);
        }];
        icon.contentMode = UIViewContentModeCenter;
        self.postTF.rightView = icon;
        self.postTF.rightViewMode = UITextFieldViewModeAlways;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(40);
            make.right.equalTo(-40);
            make.top.equalTo(self.nameLb.mas_bottom).equalTo(3);
            make.height.equalTo(1);
        }];
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(40);
            make.right.equalTo(-40);
            make.top.equalTo(self.postLb.mas_bottom).equalTo(3);
            make.height.equalTo(1);
        }];
    }
    return _postTF;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_loginBtn];
        [_loginBtn setImage:[UIImage imageNamed:@"ic_forward_white"] forState:UIControlStateNormal];
        _loginBtn.backgroundColor = kRGBA(48, 184, 188, 1);
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
            make.left.right.equalTo(0);
            make.height.equalTo(40);
        }];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
- (UIImageView *)iocn {
    if (!_iocn) {
        _iocn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
        [self.view addSubview:_iocn];
        [_iocn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.width.height.equalTo(140);
            make.top.equalTo(100);
        }];
    }
    return _iocn;
}

@end
