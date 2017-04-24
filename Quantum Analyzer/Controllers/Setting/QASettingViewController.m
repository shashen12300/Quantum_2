//
//  QASettingViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QASettingViewController.h"

@interface QASettingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic,assign) BOOL isShowing;
@property (nonatomic,assign) BOOL isSave;
@end

@implementation QASettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTitleLabel:@"设置"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endKeyBoard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endKeyBoard {
    [self.view endEditing:YES];
}
- (IBAction)saveBtnClick:(id)sender {
        [self.view endEditing:YES];
    if (_timeTextField.text.length>0) {
        [CommonCore SaveMessageObject:_timeTextField.text key:CheckTime];
    }
    
    if (_passwordField.text.length>0) {
        [CommonCore SaveMessageObject:_passwordField.text key:PassWord];
    }
    
    if (![CommonCore isBlankString:_timeTextField.text]||![CommonCore isBlankString:_passwordField.text]) {
        [self showHint:@"修改成功"];
    }


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
