//
//  QANewHealthCollectionViewCell.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2017/4/2.
//  Copyright © 2017年 宋冲冲. All rights reserved.
//

#import "QANewHealthCollectionViewCell.h"

@implementation QANewHealthCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"QANewHealthCollectionViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    return self;
}

@end
