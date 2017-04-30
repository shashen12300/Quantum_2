//
//  CollectModel.h
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2017/1/3.
//  Copyright © 2017年 宋冲冲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportContentData.h"

@interface CollectModel : NSObject


//@property(nonatomic,copy) NSString *str_SystemName;
@property(nonatomic,copy) NSString *n_MainItemID;
@property(nonatomic,copy) NSString *str_SubItemName;
@property(nonatomic,copy) NSString *db_SbuItemRange;
@property(nonatomic,copy) NSString *db_subItemReal;
@property(nonatomic,copy) NSString *str_Record_Time;
@property(nonatomic,copy) NSString *n_Result;
//@property(nonatomic,copy) NSString *str_Suggestion;

@end

/* 绘制曲线图*/
@interface NewCollectModel : NSObject

/** 曲线报告*/
@property(nonatomic, strong) ReportGraphData *graphData;
/** 报告名称*/
@property(nonatomic, copy) NSString *reportName;

/** 报告生成时间*/
@property(nonatomic, copy) NSString *record_time;
/** 报告id*/
@property(nonatomic, copy) NSString *n_MainItemID;
/** 异常指数*/
@property(nonatomic, copy) NSString *n_Result;


@end
