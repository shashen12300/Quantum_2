//
//  QAAlertView.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/9.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAAlertView.h"

@implementation QAAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"QAAlertView" owner:self options:nil].firstObject;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewHiden)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)viewHiden {
    self.hidden = YES;
}

- (IBAction)btnClick:(UIButton *)sender {
    self.hidden = YES;
    
    if (sender.tag == 0) {
        //设置
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

    }else {
        [self viewHiden];
    }

}
@end
