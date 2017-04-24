//
//  QANavigationController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QANavigationController.h"

@interface QANavigationController ()

@end

@implementation QANavigationController

+ (void)initialize{
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
//    //设置状态栏颜色
//    [navBar setBackgroundImage:[UIImage imageNamed:@"nav_box"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    navBar.barTintColor = RGB(67, 218, 254);
    navBar.translucent = NO;
    // 3.标题颜色和大小
    [navBar setTitleTextAttributes:@{NSFontAttributeName:fontSize20,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //4.隐藏导航栏黑线
//    [navBar setShadowImage:[UIImage new]];
    //5.设置返回按钮
    //设置导航栏返回按钮的颜色
    [navBar setTintColor:[UIColor whiteColor]];
    //隐藏导航栏的返回按钮文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
