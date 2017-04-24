//
//  QAAlertView.h
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/9.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QAAlertView;

@protocol QAAlertViewDelegate <NSObject>

- (void)alertView:(QAAlertView *)alertView tag:(NSInteger)tag;

@end
@interface QAAlertView : UIView
/* 设置*/
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
/* 好*/
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
@property (nonatomic, assign) id<QAAlertViewDelegate> delegate;

@end
