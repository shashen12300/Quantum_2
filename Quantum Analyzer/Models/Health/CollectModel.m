//
//  CollectModel.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2017/1/3.
//  Copyright © 2017年 宋冲冲. All rights reserved.
//

#import "CollectModel.h"

@implementation CollectModel

@end

@implementation NewCollectModel

- (id)init {
    self = [super init];
    if (self) {
        _graphData = [[ReportGraphData alloc] init];
    }
    return self;
}
@end
