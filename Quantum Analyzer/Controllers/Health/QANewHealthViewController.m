//
//  QANewHealthViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2017/4/2.
//  Copyright © 2017年 宋冲冲. All rights reserved.
//

#import "QANewHealthViewController.h"
#import "ReportList.h"
#import "ReportListManager.h"
#import "QAWebViewController.h"
#import "QANewHealthCollectionViewCell.h"

@interface QANewHealthViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation QANewHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self initTitleLabel:@"健康评估"];
    [_collectionView registerClass:[QANewHealthCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((DScreenWidth-5)/4, (DScreenWidth-5)/4);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    _collectionView.collectionViewLayout = layout;
    _collectionView.backgroundColor = UIColorFromRGB(0xf1f1f1);
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
    [_collectionView reloadData];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _sourceArray.count;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QANewHealthCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"JLZ检测\r\n综合报告单";
    }else {
        ReportList *reportList = _sourceArray[indexPath.row-1];
        cell.titleLabel.text = [reportList.reportName stringByReplacingOccurrencesOfString:@"检测报告" withString:@"\r\n检测报告"];//reportList.reportName;
    }
    

    return cell;
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    QAWebViewController *webViewVC = [[QAWebViewController alloc] init];
    
    if (_dictionary) {
        if (indexPath.row == 0) {
            webViewVC.htmlString = _dictionary[@"JLZ检测综合报告单"];
            webViewVC.title = @"JLZ检测\r\n综合报告单";
            
        }else {
            ReportList *reportList = _sourceArray[indexPath.row-1];
            webViewVC.reportList = reportList;
            webViewVC.htmlString = _dictionary[reportList.reportName];
        }
    }
    
    webViewVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewVC animated:YES];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return (CGSize){100,100};
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
