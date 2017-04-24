//
//  MacroDefine.h
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h

/*--------------------------------开发中常用到的宏定义--------------------------------------*/

#define mAlertAPIErrorInfo(error)  [mAppUtils showHint:[[error.userInfo objectForKey:ERRORMSG] length]>0?[error.userInfo objectForKey:ERRORMSG] :kNetWorkUnReachableDesc]
//系统目录
#define KDocuments  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define IS_IOS_7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)
#define COLOR(R,G,B,A)      [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:A]
#define IMAGE(ImageName)    [[[UIImageView alloc] initWithImage:[UIImage imageNamed:ImageName]] autorelease]
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
#define IOS_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
#define IOS_VERSION_9_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)? (YES):(NO))
//图片最大上传大小
#define kMaxImageUploadSize (200*1024)
#define KMaxLongImageUploadSize (1024*1024)
#define kMESImageQuality 0.8 //图片压缩比例
#define kMBorderWidth 1

//颜色转换
#define mRGBColor(r, g, b)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define mRGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//rgb颜色转换（16进制->10进制）
#define mRGBToColor(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]
// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

#define myx [UIScreen mainScreen].bounds.size.width/375.0
#define myy [UIScreen mainScreen].bounds.size.height/667.0

/*----------方法简写-----------*/
#define DAppDelegate        ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define DWindow             [[[UIApplication sharedApplication] windows] lastObject]
#define DUserDefaults       [NSUserDefaults standardUserDefaults]
#define DNotificationCenter [NSNotificationCenter defaultCenter]
#define DBundleId           [[NSBundle mainBundle] bundleIdentifier]
#define DAppUtils           [AppUtils sharedAppUtilsInstance]
#define DAFHTTPClient(url,type)       [AFHTTPClientUtil sharedClient:(url) type:(type)]
#define mAFHTTPClientForiOS6OrLower(url,type) [AFHTTPClientForiOS6OrLower sharedClient:(url) type:(type)]
#define mAppUtils           [AppUtils sharedAppUtilsInstance]
#define hNetWorkOperation   [NetworkOperation shareInstance]
#define mAppCache           [LocalCache sharedCache]
#define mConfigUtil         [ConfigUtil sharedConfigUtil]
#define DPayZFB             [PayZFBReuqest sharedInstance]

/*----------页面设计相关--------*/
#define DNavBarHeight         (self.navigationController.navigationBar.height)
#define DTabBarHeight         (self.tabBarController.tabBar.height)
#define DStatusBarHeight      ([UIApplication sharedApplication].statusBarFrame.size.height)
#define DScreenWidth          ([UIScreen mainScreen].bounds.size.width)
#define DScreenHeight         ([UIScreen mainScreen].bounds.size.height)
#define kMainBoundsWidth      ([UIScreen mainScreen].bounds.size.width)
#define kMainBoundsHeight     ([UIScreen mainScreen].bounds.size.height)
#define ImageRot               2.4
// add by pk at 20151031
#define AdaptXiShuWith320     (DScreenWidth/320.0)
#define AdaptWidth(width)     (AdaptXiShuWith320 * width)
#define AdaptHeight(height)   (AdaptXiShuWith320 * height)

#define BorderColorRefForDetail       [[UIColor lightGrayColor] CGColor]
#define BorderCornerRadiosForDetail    10.0


/*----------设备系统相关---------*/
#define DRetina   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define DIsiP5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)
#define DIS_IPAD    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define DIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define DIOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_6P ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )

// device verson
#define CURRENT_SYS_VERSION [[UIDevice currentDevice] systemVersion]
// device verson float value
#define CURRENT_SYS_VERSION_FLOAT [[[UIDevice currentDevice] systemVersion] floatValue]
//设置TableView cell选中时的颜色
#define DTABLE_CELL_SELECT_BGCOLOR [UIColor colorWithRed:235.0/255.0 green:236.0/255.0 blue:238.0/255.0 alpha:1]
#define mAPPVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(r,g,b,a)               [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define RGB(r,g,b)                  [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1.0f]
#define Image_Name(name)                  [UIImage imageNamed:(name)]



#endif /* MacroDefine_h */
