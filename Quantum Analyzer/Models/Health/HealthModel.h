//
//  HealthModel.h
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/9.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthModel : NSObject

/* 姓名*/
@property(nonatomic,copy) NSString *name;
/* 检测时间*/
@property(nonatomic,copy) NSString *time;
/* 性别*/
@property(nonatomic,copy) NSString *sex;
/* 身高*/
@property(nonatomic,copy) NSString *stature;
/* 体重*/
@property(nonatomic,copy) NSString *weight;
/* 年龄*/
@property(nonatomic,copy) NSString *age;
/* 表格*/
@property(nonatomic,copy) NSString *table;
/* 健康*/
@property(nonatomic,copy) NSString *health;
@end
