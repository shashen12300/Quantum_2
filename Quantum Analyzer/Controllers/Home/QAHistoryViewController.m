//
//  QAHistoryViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/8.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAHistoryViewController.h"
#import "QAHistoryTableViewCell.h"
#import "DataBase.h"
#import "QAHealthViewController.h"
#import "QANewHealthViewController.h"

@interface QAHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) Person *person;
@end

@implementation QAHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"历史记录";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DScreenWidth, DScreenHeight) style:UITableViewStylePlain];
    tableView.tableFooterView = [UIView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _person = [[DataBase sharedDataBase]getPersonWithID:[CommonCore queryMessageKey:CurrentUserID]];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.sourceArray = [[DataBase sharedDataBase] getAllRecordsFromPerson:_person];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    QAHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[QAHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    Record *record = _sourceArray[indexPath.row];
    cell.textLabel.text = record.time;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Record *record = _sourceArray[indexPath.row];
    QANewHealthViewController *healthVC = [[QANewHealthViewController alloc] init];
//    QAHealthViewController *healthVC = [[QAHealthViewController alloc] init];
    healthVC.report = record.report;
    [self.navigationController pushViewController:healthVC animated:YES];
}

#pragma mark -getter
- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [[NSMutableArray alloc] init];
    }
    return _sourceArray;
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
