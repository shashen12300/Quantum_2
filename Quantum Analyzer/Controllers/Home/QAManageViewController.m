//
//  QAManageViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/7.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAManageViewController.h"
#import "QAManageTableViewCell.h"
#import "DataBase.h"
#import "Person.h"

@interface QAManageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation QAManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"管理用户";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DScreenWidth, DScreenHeight) style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.sourceArray = [[DataBase sharedDataBase] getAllPerson];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    QAManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[QAManageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    Person *person = self.sourceArray[indexPath.row];
    cell.textLabel.text = person.name;
    cell.imageView.image = [UIImage imageNamed:person.sex];
    //调整大小
    CGSize itemSize = CGSizeMake(HeadPictureWidth, HeadPictureWidth);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if ([[CommonCore queryMessageKey:CurrentUserID] isEqual:person.ID]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Person *person = self.sourceArray[indexPath.row];
    [CommonCore SaveMessageObject:person.ID key:CurrentUserID];
    [_tableView reloadData];
    
}

#pragma mark -getter
- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [[NSMutableArray alloc] init];
    }
    return _sourceArray;
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
