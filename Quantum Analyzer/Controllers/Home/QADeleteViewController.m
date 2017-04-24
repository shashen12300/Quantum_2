//
//  QADeleteViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/8.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QADeleteViewController.h"
#import "QAManageTableViewCell.h"
#import "DataBase.h"

@interface QADeleteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QADeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"删除用户";
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Person *person = self.sourceArray[indexPath.row];
    [CommonCore SaveMessageObject:person.ID key:CurrentUserID];
    [_tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Person *person = _sourceArray[indexPath.row];
        [[DataBase sharedDataBase]deletePerson:person];
        self.sourceArray = [[DataBase sharedDataBase] getAllPerson];
        [_tableView reloadData];
    }
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
