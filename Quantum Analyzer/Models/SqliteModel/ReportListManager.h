// =======================================================
// This file is auto generated by [Convert Excel To .plist and .sqlite] convertor,
// do not edit by youself!
// >>>> by HuMinghua <<<<  2016年12月27日 下午3:54:47
// ======================================================


#import <Foundation/Foundation.h>

#pragma mark - 
@class ReportList;
@interface ReportListManager : NSObject

+ (ReportListManager *) sharedManager;

/**** 获取所有报告**/
- (NSMutableArray *)getAllReport;
/**** 获取所有男性报告**/
- (NSMutableArray *)getAllManReport;
/**** 获取所有女性报告**/
- (NSMutableArray *)getAllWomanReport;
/**** 获取所有儿童报告**/
- (NSMutableArray *)getAllChildrenReport;
@end
