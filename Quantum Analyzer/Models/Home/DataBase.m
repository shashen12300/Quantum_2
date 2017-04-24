//
//  DataBase.m
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>

#import "Person.h"
#import "Record.h"

static DataBase *_DBCtl = nil;

@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}




@end

@implementation DataBase

+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    NSString *personSql = @"CREATE TABLE 'person' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'person_id' VARCHAR(255),'person_name' VARCHAR(255),'person_date' VARCHAR(255),'person_number' VARCHAR(255),'person_sex' VARCHAR(255),'person_stature' VARCHAR(255),'person_weight' VARCHAR(255),'person_phoneNumber' VARCHAR(255),'person_remark' VARCHAR(255),'person_health' VARCHAR(255),'person_age' VARCHAR(255)) ";
    NSString *recordSql = @"CREATE TABLE 'record' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'own_id' VARCHAR(255),'record_id' VARCHAR(255),'record_time' VARCHAR(255),'record_report' TEXT) ";
    [_db executeUpdate:personSql];
    [_db executeUpdate:recordSql];

    
    
    [_db close];

}
#pragma mark - 接口

- (void)addPerson:(Person *)person{
    [_db open];
    
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"person_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"person_id"] integerValue] ) ;
        }
        
    }
    maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO person(person_id,person_name,person_date,person_number,person_sex,person_stature,person_weight,person_phoneNumber,person_remark,person_health,person_age)VALUES(?,?,?,?,?,?,?,?,?,?,?)",maxID,person.name,person.date,@(person.number),person.sex,person.stature,person.weight,person.phoneNumber,person.remark,person.health,person.age];
    [_db close];
    
}

- (void)deletePerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM person WHERE person_id = ?",person.ID];

    [_db close];
}

- (void)updatePerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"UPDATE 'person' SET person_name = ?  WHERE person_id = ? ",person.name,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_date = ?  WHERE person_id = ? ",person.date,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_number = ?  WHERE person_id = ? ",@(person.number + 1),person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_sex = ?  WHERE person_id = ? ",person.sex,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_stature = ?  WHERE person_id = ? ",person.stature,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_weight = ?  WHERE person_id = ? ",person.weight,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_phoneNumber = ?  WHERE person_id = ? ",person.phoneNumber,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_remark = ?  WHERE person_id = ? ",person.remark,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_health = ?  WHERE person_id = ? ",person.health,person.ID];
    [_db executeUpdate:@"UPDATE 'person' SET person_age = ?  WHERE person_id = ? ",person.age,person.ID];
   
    [_db close];
}

- (NSMutableArray *)getAllPerson{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person"];
    
    while ([res next]) {
        Person *person = [[Person alloc] init];
        person.ID = @([[res stringForColumn:@"person_id"] integerValue]);
        person.name = [res stringForColumn:@"person_name"];
        person.date = [res stringForColumn:@"person_date"];
        person.number = [[res stringForColumn:@"person_number"] integerValue];
        person.sex = [res stringForColumn:@"person_sex"];
        person.stature = [res stringForColumn:@"person_stature"];
        person.weight = [res stringForColumn:@"person_weight"];
        person.phoneNumber = [res stringForColumn:@"person_phoneNumber"];
        person.remark = [res stringForColumn:@"person_remark"];
        person.health = [res stringForColumn:@"person_health"];
        person.age = [res stringForColumn:@"person_age"];

        [dataArray addObject:person];
    }
    
    [_db close];
    
    return dataArray;
    
}

/* 根据person_id 获取person*/
- (Person *)getPersonWithID:(NSNumber *)person_id {
    [_db open];
//    FMResultSet *res = [_db executeQuery:@"SELECT * FROM person WHERE person_id = ？",person_id];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM person where person_id = %@",person_id]];
    [res next];
    Person *person = [[Person alloc] init];
    person.ID = @([[res stringForColumn:@"person_id"] integerValue]);
    person.name = [res stringForColumn:@"person_name"];
    person.date = [res stringForColumn:@"person_date"];
    person.number = [[res stringForColumn:@"person_number"] integerValue];
    person.sex = [res stringForColumn:@"person_sex"];
    person.stature = [res stringForColumn:@"person_stature"];
    person.weight = [res stringForColumn:@"person_weight"];
    person.phoneNumber = [res stringForColumn:@"person_phoneNumber"];
    person.remark = [res stringForColumn:@"person_remark"];
    person.health = [res stringForColumn:@"person_health"];
    person.age = [res stringForColumn:@"person_age"];
    [_db close];
    return person;
}
/* 获取当前用户Person*/
- (Person *)getCurrentLoginUser{
       NSNumber *userID = [CommonCore queryMessageKey:CurrentUserID];
    if (!userID) {
        UIAlertView *userAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录账户，再进行操作" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [userAlert show];
        return nil;
    }
   Person *person = [self getPersonWithID:userID];

    return person;
}

/**
 *  给person添加记录
 *
 */
- (void)addRecord:(Record *)record toPerson:(Person *)person{
    [_db open];
    
    //根据person是否拥有record来添加record_id
    NSNumber *maxID = @(0);
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM record where own_id = %@ ",person.ID]];
    
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"record_id"] integerValue]) {
             maxID = @([[res stringForColumn:@"record_id"] integerValue]);
        }
       
    }
     maxID = @([maxID integerValue] + 1);
    
    [_db executeUpdate:@"INSERT INTO record(own_id,record_id,record_time,record_report)VALUES(?,?,?,?)",person.ID,maxID,record.time,record.report];
    
    
    [_db close];
    
}
/**
 *  给person删除记录
 *
 */
- (void)deleteRecord:(Record *)record fromPerson:(Person *)person {
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM record WHERE own_id = ?  and record_id = ? ",person.ID,record.record_id];

    [_db close];
    
    
    
}
/**
 *  获取person的所有记录
 *
 */
- (NSMutableArray *)getAllRecordsFromPerson:(Person *)person{
    
    [_db open];
    NSMutableArray  *recordArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM record where own_id = %@",person.ID]];
    while ([res next]) {
        Record *record = [[Record alloc] init];
        record.own_id = person.ID;
        record.record_id = @([[res stringForColumn:@"record_id"] integerValue]);
        record.time = [res stringForColumn:@"record_time"];
        record.report = [res stringForColumn:@"record_report"];
        
        [recordArray addObject:record];
    }
    [_db close];
    
    return recordArray;
    
}

- (void)deleteAllRecordsFromPerson:(Person *)person{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM record WHERE own_id = ?",person.ID];
    
    [_db close];
}

@end
