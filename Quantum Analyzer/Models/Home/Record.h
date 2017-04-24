//
//  Record.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Record : NSObject
/**
 *  所有者
 */
@property(nonatomic,strong ) NSNumber *own_id;

/**
 *  记录的ID
 */
@property(nonatomic,strong) NSNumber *record_id;
/* 记录时间*/
@property(nonatomic,copy) NSString *time;
/* 检测报告*/
@property(nonatomic,copy) NSString *report;

@end
