// =======================================================
// This file is auto generated by [Convert Excel To .plist and .sqlite] convertor,
// do not edit by youself!
// >>>> by HuMinghua <<<<  2017年1月3日 下午3:54:55
// ======================================================


#import <Foundation/Foundation.h>

#pragma mark - 
@class TblSuggest;
@interface TblSuggestManager : NSObject
{
    NSMutableArray  *_tblSuggests;
}
+ (TblSuggestManager *) sharedManager;

- (NSArray *)allTblSuggests;
/* 获取对应报告的专家建议*/
- (TblSuggest *)getSuggests:(NSString *)reportID;

@end
