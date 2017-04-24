//
//  Person.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject

/* 用户ID*/
@property(nonatomic,strong) NSNumber *ID;
/* 姓名*/
@property(nonatomic,copy) NSString *name;
/* 出生日期*/
@property(nonatomic,copy) NSString *date;
/* 记录数量*/
@property(nonatomic,assign) NSInteger number;
/* 性别*/
@property(nonatomic,copy) NSString *sex;
/* 身高*/
@property(nonatomic,copy) NSString *stature;
/* 体重*/
@property(nonatomic,copy) NSString *weight;
/* 联系电话*/
@property(nonatomic,copy) NSString *phoneNumber;
/* 备注*/
@property(nonatomic,copy) NSString *remark;
/* 健康状况*/
@property(nonatomic,copy) NSString *health;
/* 年龄*/
@property(nonatomic,copy) NSString *age;

/**
 *  一个人可以拥有多条检测记录
 */
@property(nonatomic,strong) NSMutableArray *recordArray;



@end
