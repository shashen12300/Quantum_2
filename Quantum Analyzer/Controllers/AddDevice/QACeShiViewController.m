//
//  QACeShiViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2017/4/5.
//  Copyright © 2017年 宋冲冲. All rights reserved.
//

#import "QACeShiViewController.h"

@interface QACeShiViewController ()

@end

@implementation QACeShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, DScreenWidth, DScreenHeight)];
    [self.view addSubview:webView];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1-心脑血管检测报告的-副本6" ofType:@"htm"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:html baseURL:baseURL];
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    webView.scalesPageToFit=YES;
    
    webView.multipleTouchEnabled=YES;
    
    webView.userInteractionEnabled=YES;
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:_reportList.reportName ofType:@"htm"];
//    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    
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
