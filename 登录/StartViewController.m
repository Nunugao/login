//
//  StartViewController.m
//  登录
//
//  Created by NuNu on 16/6/13.
//  Copyright © 2016年 NuNu. All rights reserved.
//

#import "StartViewController.h"
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "ViewController.h"


@interface StartViewController ()
@property (nonatomic) UIImageView *backImage;
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backImage];
}
//将要显示的时候,然后在做动画
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:4.0 animations:^{
        _backImage.alpha = 1.0;
        self.view.backgroundColor = [UIColor colorWithRed:219.0/255.0 green:241.0/255.0 blue:255.0/255.0 alpha:1.0];
        [_backImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(300);
            make.centerY.equalTo(self.view.mas_centerY).equalTo(-120);
        }];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        ViewController *vc = [ViewController new];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载 lazy load
- (UIImageView *)backImage {
    if(_backImage == nil) {
        _backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"launch_logo05"]];
        _backImage.alpha = 0.0;
        self.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_backImage];
        [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(500);
            make.centerX.equalTo(self.view.mas_centerX).equalTo(0);
            make.centerY.equalTo(self.view.mas_centerY).equalTo(200);
        }];
        
    }
    return _backImage;
}



@end
