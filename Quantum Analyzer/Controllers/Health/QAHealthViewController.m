//
//  QAHealthViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAHealthViewController.h"
#import "QAHealthTableViewCell.h"
#import "QAWebViewController.h"
#import "ReportList.h"
#import "ReportListManager.h"

@interface QAHealthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation QAHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleLabel:@"健康评估"];
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    _sourceArray = [[NSArray alloc] init];
    if (_report) {
        _dictionary = [[NSDictionary alloc] init];
        _dictionary = [CommonCore objectWithJson:_report];
    }
    

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        Person *person = [[DataBase sharedDataBase] getCurrentLoginUser];
        if ([person.age intValue] <= 14) {
            _sourceArray = [[ReportListManager sharedManager] getAllChildrenReport];
        }else if ([person.sex isEqualToString:@"男"]) {
            _sourceArray = [[ReportListManager sharedManager] getAllManReport];
        }else {
            _sourceArray = [[ReportListManager sharedManager] getAllWomanReport];
        }
        [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _sourceArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    QAHealthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[QAHealthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.row == _sourceArray.count) {
        cell.textLabel.text = @"量子检测综合报告单";
    }else {
        ReportList *reportList = _sourceArray[indexPath.row];
        cell.textLabel.text = reportList.reportName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QAWebViewController *webViewVC = [[QAWebViewController alloc] init];

    if (_dictionary) {
        if (indexPath.row == _sourceArray.count) {
            webViewVC.htmlString = _dictionary[@"量子检测综合报告单"];
            webViewVC.title = @"量子检测综合报告单";

        }else {
            ReportList *reportList = _sourceArray[indexPath.row];
            webViewVC.reportList = reportList;
            webViewVC.htmlString = _dictionary[reportList.reportName];
        }
    }
    webViewVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewVC animated:YES];
    
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
