//
//  QAWebViewController.h
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/7.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QABaseViewController.h"
#import "ReportList.h"

@interface QAWebViewController : QABaseViewController

@property (nonatomic, strong) ReportList *reportList;
@property (nonatomic, strong) NSString *htmlString;

@end
