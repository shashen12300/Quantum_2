//
//  QAPasswordViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2017/1/13.
//  Copyright © 2017年 宋冲冲. All rights reserved.
//

#import "QAPasswordViewController.h"

@interface QAPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwardTextField;

@end

@implementation QAPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endKeyBoard)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = UIColorFromRGB(0x4DDFFE);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endKeyBoard {
    [_passwardTextField resignFirstResponder];
}
- (IBAction)loginBtnClick:(id)sender {
    
    if ([_passwardTextField.text isEqualToString:@"000000"]) {
        [self popoverPresentationController];
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
