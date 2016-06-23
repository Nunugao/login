//
//  ViewController.m
//  登录
//
//  Created by NuNu on 16/6/12.
//  Copyright © 2016年 NuNu. All rights reserved.
//


#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic) NSArray *imageNames;
@property (nonatomic) UIScrollView *sc;
@property (nonatomic) UIPageControl *pageControl;
@end

@implementation ViewController
#pragma mark - UIScrollView Delegate
//当发生滚动操作时,触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //lroundf() 把浮点型->整形, 四舍五入
    long int page = lroundf(scrollView.contentOffset.x/scrollView.frame.size.width);
    //currentPage 当前页数
    self.pageControl.currentPage = page;
    
}
#pragma mark - <#生命周期#> Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self sc];
    [self pageControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 方法 Methods
//隐藏状态栏, 重写
- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void) enterBtnClick {
    LoginViewController *vc = [LoginViewController new];
    //可以选择VC出现的方式...
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - <#懒加载#> lazy load

- (UIScrollView *)sc {
    if(_sc == nil) {
        _sc = [[UIScrollView alloc] init];
        [self.view addSubview:_sc];
        [_sc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        //翻页滚动模式
        _sc.pagingEnabled = YES;
        //隐藏横向滚动提示
        _sc.showsHorizontalScrollIndicator = NO;
        //设置代理, 来实时接受当前滚动状态
        _sc.delegate = self;
        
        
        UIView *lastView = nil;
        NSInteger count = self.imageNames.count;
        for (int i = 0; i < count; i++) {
            NSString *imageName=self.imageNames[i];
            UIImage *image=[UIImage imageNamed:imageName];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            [_sc addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(_sc);
                make.top.bottom.equalTo(0);
                if (i == 0) {
                    make.left.equalTo(0);
                }else{
                    make.left.equalTo(lastView.mas_right).equalTo(0);
                    if (i == count - 1) {
                        make.right.equalTo(0);
                    }
                }
            }];
            lastView = imageView;
            
            if (i == count-1) {
                imageView.userInteractionEnabled = YES; //因为默认imageview上的button不能点击,所以需要开启imageview的用户交互
                UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
                [button setTitle:@"立即体验" forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:23];//设置字体大小
                [button.layer setCornerRadius:5.0];// 设置圆角
                [button.layer setBorderWidth:3]; //设置边框宽度
                [button.layer setBorderColor:[UIColor whiteColor].CGColor];//设置边框颜色
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//设置字体颜色
                [imageView addSubview:button];
                [button addTarget:self action:@selector(enterBtnClick) forControlEvents:UIControlEventTouchUpInside];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(imageView);
                    make.bottom.equalTo(imageView.mas_bottom).equalTo(-80); //距离底部的距离
                    make.width.equalTo(130);
                    make.height.equalTo(45);
                }];
            }
            
        }
        
    }
    return _sc;
}

- (NSArray *)imageNames {
    if (!_imageNames) {
        _imageNames = @[@"02欢迎页1", @"02欢迎页2", @"02欢迎页3", @"02欢迎页4"];
    }
    return _imageNames;
}
- (UIPageControl *)pageControl {
    if(_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        //页数--点的个数
        _pageControl.numberOfPages = self.imageNames.count;
        [self.view addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(-35);
        }];
        //关闭与用户的交流
        _pageControl.userInteractionEnabled = NO;
        //修改颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}



@end
