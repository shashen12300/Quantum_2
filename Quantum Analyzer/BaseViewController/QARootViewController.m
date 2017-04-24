//
//  QARootViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QARootViewController.h"
#import "QAAddViewController.h"
#import "QAHomeViewController.h"
#import "QABeginCheckViewController.h"
#import "QAHealthViewController.h"
#import "QASettingViewController.h"
#import "QANavigationController.h"

@interface QARootViewController ()

@end

@implementation QARootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加设备
    QAAddViewController *addVC = [[QAAddViewController alloc] init];
    addVC.tabBarItem.image = [[UIImage imageNamed:@"添加设备"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    addVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"添加设备-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    addVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    QANavigationController *addNav = [[QANavigationController alloc] initWithRootViewController:addVC];
    //开始检测
    QABeginCheckViewController *beginVC = [[QABeginCheckViewController alloc] init];
    beginVC.tabBarItem.image = [[UIImage imageNamed:@"开始检测"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    beginVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"开始检测-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    beginVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    QANavigationController *beginNav = [[QANavigationController alloc] initWithRootViewController:beginVC];
    //首页
    QAHomeViewController *homeVC = [[QAHomeViewController alloc] init];
    homeVC.tabBarItem.image = [[UIImage imageNamed:@"首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"首页-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    QANavigationController *homeNav = [[QANavigationController alloc] initWithRootViewController:homeVC];
//    //健康检测
//    QAHealthViewController *healthVC = [[QAHealthViewController alloc] init];
//    healthVC.tabBarItem.image = [[UIImage imageNamed:@"健康评估"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    healthVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"健康评估-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    healthVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//    QANavigationController *healthNav = [[QANavigationController alloc] initWithRootViewController:healthVC];
    //设置
    QASettingViewController *settingVC = [[QASettingViewController alloc] init];
    settingVC.tabBarItem.image = [[UIImage imageNamed:@"设备"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    settingVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"设备-1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    settingVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    QANavigationController *settingNav = [[QANavigationController alloc] initWithRootViewController:settingVC];

    NSArray *array = [NSArray arrayWithObjects:addNav,beginNav,homeNav,settingNav, nil];
    self.viewControllers = array;
    self.selectedIndex = 0;
    self.tabBar.translucent = NO;
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
