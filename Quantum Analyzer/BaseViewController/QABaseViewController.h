//
//  QABaseViewController.h
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIViewController+HUD.h>

@interface QABaseViewController : UIViewController

-(void)initTitleLabel:(NSString *)title;
//提示框
- (void)showHint:(NSString *)hint;
@end
