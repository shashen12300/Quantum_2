//
//  DataBase.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Record.h"

@interface DataBase : NSObject

@property(nonatomic,strong) Person *person;


+ (instancetype)sharedDataBase;


#pragma mark - Person
/**
 *  添加person
 *
 */
- (void)addPerson:(Person *)person;
/**
 *  删除person
 *
 */
- (void)deletePerson:(Person *)person;
/**
 *  更新person
 *
 */
- (void)updatePerson:(Person *)person;
/**
 *  根据person_id获取person
 *
 */
- (Person *)getPersonWithID:(NSNumber *)person_id;

/**
 *  获取所有数据
 *
 */
- (NSMutableArray *)getAllPerson;
/**
 *  获取当前用户Person
 *
 */
- (Person *)getCurrentLoginUser;

#pragma mark - Car


/**
 *  给person添加记录
 *
 */
- (void)addRecord:(Record *)record toPerson:(Person *)person;
/**
 *  给person删除记录
 *
 */
- (void)deleteRecord:(Record *)record fromPerson:(Person *)person;
/**
 *  获取person的所有记录
 *
 */
- (NSMutableArray *)getAllRecordsFromPerson:(Person *)person;
/**
 *  删除person的所有记录
 *
 */
- (void)deleteAllRecordsFromPerson:(Person *)person;


@end
