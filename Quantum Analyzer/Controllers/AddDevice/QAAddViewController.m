//
//  QAAddViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAAddViewController.h"
#import "QABLEAdapter.h"
#import "QAConfigViewController.h"
#import "QAPasswordViewController.h"
#import "QACeShiViewController.h"

@interface QAAddViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *autoHeight;
@property (nonatomic, strong) QAConfigViewController *configVC;

@end

@implementation QAAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleLabel:@"添加设备"];
    // Do any additional setup after loading the view from its nib.
    self.addBtn.layer.cornerRadius = 18;
    self.autoHeight.constant = DScreenWidth/381*253;
    [QABLEAdapter sharedBLEAdapter].addViewController = self;
    [CommonCore setNavRight:self image:@"" title:@"s测试" action:@selector(ceshiWebView)];

}

- (void)ceshiWebView {
    QACeShiViewController *ceshiVC = [[QACeShiViewController alloc] init];
    ceshiVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ceshiVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
}
- (IBAction)addDeviveBtnClick:(id)sender {
    
//    [[QABLEAdapter sharedBLEAdapter] controlSetup:1];
    if (!_configVC) {
        _configVC = [[QAConfigViewController alloc] init];
        _configVC.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:_configVC animated:YES];
    
}

- (QAAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[QAAlertView alloc] init];
        _alertView.frame = self.view.window.bounds;
        [self.view.window addSubview:_alertView];
        _alertView.hidden = YES;
    }
    return _alertView;
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
