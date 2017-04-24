//
//  QAHomeViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAHomeViewController.h"
#import "QACreatUserViewController.h"
#import "QAManageViewController.h"
#import "QAHistoryViewController.h"
#import "QADeleteViewController.h"

@interface QAHomeViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation QAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTitleLabel:@"首页"];
    self.scrollView.contentSize = CGSizeMake(DScreenWidth, DScreenHeight);
    self.nameLabel.text = @"Quantum Resonant \n Magnetic Analyzer";
    //提交git测试
}

- (IBAction)userBtnClick:(UIButton *)sender {
    if (sender.tag == 0) {
        QACreatUserViewController *creatVC = [[QACreatUserViewController alloc] init];
        creatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:creatVC animated:YES];
    }else if (sender.tag == 1) {
        QAManageViewController *manageVC = [[QAManageViewController alloc] init];
        manageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:manageVC animated:YES];
    }else if (sender.tag == 2) {
        QAHistoryViewController *historyVC = [[QAHistoryViewController alloc] init];
        historyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:historyVC animated:YES];
    }else {
        QADeleteViewController *deleteVC = [[QADeleteViewController alloc] init];
        deleteVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:deleteVC animated:YES];
    }

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
