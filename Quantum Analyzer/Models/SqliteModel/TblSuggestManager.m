// =======================================================
// This file is auto generated by [Convert Excel To .plist and .sqlite] convertor,
// do not edit by youself!
// >>>> by HuMinghua <<<<  2017年1月3日 下午3:54:55
// ======================================================


#import "TblSuggest.h"
#import "TblSuggestManager.h"
#import <FMDB.h>
#import "TblSuggest.h"

#pragma mark - 
#define AUTO_PLIST_TBLSUGGEST_PATH   [[NSBundle mainBundle] pathForResource:@"TblSuggest" ofType:@"plist"]

#pragma mark - 
#define AUTO_PLIST_TBLSUGGEST_INDEX_REPORTNO      0   // ReportNo
#define AUTO_PLIST_TBLSUGGEST_INDEX_REPORTID      1   // ReportID
#define AUTO_PLIST_TBLSUGGEST_INDEX_TYPE      2   // Type
#define AUTO_PLIST_TBLSUGGEST_INDEX_SYSTEM      3   // System
#define AUTO_PLIST_TBLSUGGEST_INDEX_SUGGEST      4   // Suggest

#pragma mark - 
@implementation TblSuggestManager{
    FMDatabase  *_db;
}

static TblSuggestManager *_sTblSuggestManager = nil;

#pragma mark -
+ (TblSuggestManager *) sharedManager
{
    @synchronized(self) {
        if (!_sTblSuggestManager) {
            _sTblSuggestManager = [[self alloc] init];
        }
    }
    return _sTblSuggestManager;
}
- (id)init
{
    self = [super init];
    if (self) {
        // 文件路径
        NSString *filePath = [DocumentFile ProductPath:@"TblSuggest.sqlite"];
        // 实例化FMDataBase对象
        _db = [FMDatabase databaseWithPath:filePath];
    }
    return self;
}

#pragma mark -
- (NSArray *)allTblSuggests
{

    NSString *sqliteStr = @"SELECT * FROM TblSuggest";
    return [self queryAllSqlite:sqliteStr];
}

/* 获取对应报告的专家建议*/
- (TblSuggest *)getSuggests:(NSString *)reportID {
    NSString *sqliteStr = [NSString stringWithFormat:@"SELECT * FROM TblSuggest where ReportID = %@",reportID];
    NSArray *array = [self queryAllSqlite:sqliteStr];
    return array[0];
}

- (NSMutableArray *)queryAllSqlite:(NSString *)sqliteStr {
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:sqliteStr];
    
    while ([res next]) {
        TblSuggest *suggest = [[TblSuggest alloc] init];
        suggest.reportNo = [res stringForColumn:@"reportNo"];
        suggest.reportID = [res stringForColumn:@"reportID"];
        suggest.type = [res stringForColumn:@"type"];
        suggest.system = [res stringForColumn:@"system"];
        suggest.suggest = [res stringForColumn:@"suggest"];
        
        [dataArray addObject:suggest];
    }
    
    [_db close];
    
    return dataArray;
}



@end
