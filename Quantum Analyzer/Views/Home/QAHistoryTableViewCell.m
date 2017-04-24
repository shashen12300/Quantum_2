//
//  QAHistoryTableViewCell.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/8.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAHistoryTableViewCell.h"

@implementation QAHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"QAHistoryTableViewCell" owner:self options:nil]firstObject];
        self.textLabel.textColor = lightGrayFontColor;
        self.textLabel.font = fontSize15;
        self.detailTextLabel.textColor = grayFontColor;
        self.detailTextLabel.font = fontSize13;
    }
    return self;
}

@end
