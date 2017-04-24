//
//  QAWebViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/7.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAWebViewController.h"
#import <GRMustache.h>
#import "DataBase.h"
#import "HealthModel.h"
#import <objc/runtime.h>
#import "HealthReportManager.h"

@interface QAWebViewController ()

@end

@implementation QAWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_reportList) {
        self.title = _reportList.reportName;
    }
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DScreenWidth, DScreenHeight)];

    [self.view addSubview:webView];
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    webView.scalesPageToFit=YES;
    
    webView.multipleTouchEnabled=YES;
    
    webView.userInteractionEnabled=YES;
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:_reportList.reportName ofType:@"htm"];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    if (_htmlString) {
        [webView loadHTMLString:_htmlString baseURL:baseURL];
        
    }
    
//    else {
//        Person *person = [[DataBase sharedDataBase] getCurrentLoginUser];
//
//        NSString *appString = [self demoFormatWithPerson:person];
//        [webView loadHTMLString:appString baseURL:baseURL];
//        
//    }
    
}

//- (NSString *)demoFormatWithPerson:(Person *)person {
//    HealthModel *health = [[HealthModel alloc] init];
//    health.sex = person.sex;
//    health.name = person.name;
//    health.age = [self getAgeDate:person.date];
//    health.weight = person.weight;
//    health.stature = person.stature;
//    health.time = person.date;
//    health.health = person.health;
//    NSString *str = [[HealthReportManager sharedManager] getCheckReportHtml:_reportList.reportID];
//    health.table = str;
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:_reportList.reportName ofType:@"htm"];
//    NSString *template = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    template = [template stringByReplacingOccurrencesOfString:@"{{table}}" withString:str];
//    NSDictionary *renderObject = [CommonCore dictionaryWithModel:health];
//    NSString *content = [GRMustacheTemplate renderObject:renderObject fromString:template error:nil];
//    return content;
//}


- (NSString *)getAgeDate:(NSString *)date {
    NSString *birthYear = [date substringToIndex:4];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate* dt = [NSDate date];
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: NSCalendarUnitYear
                                          fromDate:dt];
    //    NSInteger age = comp.year - [birthYear integerValue];
    NSString *age = [NSString stringWithFormat:@"%ld",comp.year - [birthYear integerValue]];
    return age;
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
