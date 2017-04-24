//
//  QACreatUserViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/7.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QACreatUserViewController.h"
#import "DateAndTimePickerView.h"
#import "DataBase.h"
#import "Person.h"

typedef NS_ENUM(NSInteger,SexType) {
    SexTypeMan = 0,
    SexTypeWoman = 1
};

@interface QACreatUserViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottom;
/* 男*/
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
/* 女*/
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
/* 头像*/
@property (weak, nonatomic) IBOutlet UIButton *photoSelectBtn;
/* 姓名*/
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/* 出生日期*/
@property (weak, nonatomic) IBOutlet UIButton *birthDateBtn;
/* 身高*/
@property (weak, nonatomic) IBOutlet UITextField *statureTextField;
/* 体重*/
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
/* 联系电话*/
@property (weak, nonatomic) IBOutlet UITextField *photoNumberTextField;
/* 备注*/
@property (weak, nonatomic) IBOutlet UITextField *remarkTextField;
/* 时间选择器*/
@property (nonatomic, strong)DateAndTimePickerView *pickerView;
@end

@implementation QACreatUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新建用户";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //时间选择器
    DateAndTimePickerView *pickerView = [[DateAndTimePickerView alloc] initWithFrame:CGRectMake(0, 0, DScreenWidth, DScreenHeight)];
    pickerView.hidden = YES;
    [self.view addSubview:pickerView];
    _pickerView = pickerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self subscribeToKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self an_unsubscribeKeyboard];
}

/** 取消键盘*/
- (void)cancelKeyboard{
    [self.view endEditing:YES];
}
/* 键盘回调*/
- (void)subscribeToKeyboard {
    [self an_subscribeKeyboardWithAnimations:^(CGRect keyboardRect, NSTimeInterval duration, BOOL isShowing) {
        NSLog(@"高度:%f",_scrollViewBottom.constant);
        if (isShowing == YES) {
            _scrollViewBottom.constant = CGRectGetHeight(keyboardRect) - 44;
        }else {
            _scrollViewBottom.constant = 0;
        }
        
    } completion:nil];
}

/* 性别选择*/
- (IBAction)sexSelectBtnClick:(UIButton *)sender {
    sender.selected = YES;
    if (sender.tag == SexTypeMan) {
        //男
        _womanBtn.selected = NO;
        _photoSelectBtn.selected = NO;
    }else if (sender.tag == SexTypeWoman) {
        //女
        _manBtn.selected = NO;
        _photoSelectBtn.selected = YES;
    }
}
/* 日期选择*/
- (IBAction)dateSelectBtnClick {
    [self.view endEditing:YES];
    _pickerView.hidden = NO;
    [_pickerView returnText:^(NSString *dateTime) {
        [_birthDateBtn setTitle:dateTime forState:UIControlStateNormal];
    }];
}

/* 注册用户*/
- (IBAction)registerUserBtnClick {
    [self.view endEditing:YES];
    if ([CommonCore isBlankString:_nameTextField.text]||[CommonCore isBlankString:_birthDateBtn.titleLabel.text]||[CommonCore isBlankString:_statureTextField.text]||[CommonCore isBlankString:_weightTextField.text]||[CommonCore isBlankString:_photoNumberTextField.text]) {
        [self showHint:@"信息填写不完整"];
    }else {
        
        [self addData];
    }
}

- (void)addData{
    
    Person *person = [[Person alloc] init];
    person.name = _nameTextField.text;
    person.date = _birthDateBtn.titleLabel.text;
    if (_manBtn.selected) {
        person.sex = @"男";
    }else {
        person.sex = @"女";
    }
    person.stature = _statureTextField.text;
    person.weight = _weightTextField.text;
    person.phoneNumber = _photoNumberTextField.text;
    if (_remarkTextField.text.length>0) {
        person.remark = _remarkTextField.text;
    }else {
        person.remark = @"无";
    }
    //健康情况
    person.health = [self getPersonKg:person];
    //年龄
    person.age = [CommonCore getAgeDate:person.date];
    //添加用户到数据库
    [[DataBase sharedDataBase] addPerson:person];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getPersonKg:(Person *)person {
    CGFloat height = [person.stature floatValue]/100.0;
    CGFloat weight = [person.weight floatValue];
    CGFloat standard = 0;
    if ([person.sex isEqualToString:@"男"]) {
        standard = height * height *22;
    }else {
        standard = height * height *20;
    }
    if (weight > standard*1.2) {
        return @"重胖";
    }else if ((weight <= 1.2*standard)&&(weight>=1.1*standard)) {
        return @"轻胖";
    }else if ((weight <1.1*standard)&&(weight>0.9*standard)){
        return @"标准";
    }else if ((weight<=0.9*standard)&&(weight>=0.8*standard)) {
        return @"轻瘦";
    }else {
        return @"重瘦";
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
