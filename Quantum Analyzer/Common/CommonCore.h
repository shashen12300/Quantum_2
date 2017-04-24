//
//  CommonCore.h
//  Calculus
//
//  Created by 宋冲冲 on 16/3/25.
//  Copyright © 2016年 zhangjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface CommonCore : NSObject

/** 保存消息信息*/
+ (void)SaveMessageObject:(id)object key:(NSString *)key;
/** 查询消息*/
+ (id)queryMessageKey:(NSString *)key;
/** 根据经纬度，计算两点间距离*/
/** 计算时间间隔*/
+ (NSTimeInterval)timeToString:(NSString *)timeStr;

+(NSData *)returnDataWithDictionary:(NSDictionary *)dict;
/** 保存图片到相册*/
- (void)saveImageToPhotos:(UIImage *)savedImage;
/** 获取内容的高度或者宽度*/
+ (CGFloat) getContentHeight:(NSString *)content size:(CGSize)size fontSize:(NSInteger)fontSize;
+ (CGFloat) getContentWidth:(NSString *)content size:(CGSize)size fontSize:(NSInteger)fontSize;
/** 对象转json字符串*/
+ (NSString *)jsonWithArray:(id) object;
/** json串转字典或者数组*/
+ (id)objectWithJson:(NSString *)jsonString;
/** 获取系统当前时间*/
+ (NSString *)currentTime;
////模型转字典
+ (NSDictionary *)dictionaryWithModel:(id)model;
/*图片背景虚化模糊*/
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
/** 保存玩家信息到本地*/
+ (void)saveMemberMessage:(NSDictionary *)dic;
//非空判断
+ (BOOL)isBlankString:(NSString *)string;
/** 设置导航栏返回按钮*/
+ (void)setNavLeftBack:(UIViewController *)viewController;
/** 设置导航栏返回按钮并触发事件*/
+ (void)setNavLeftBack:(UIViewController *)viewController action:(SEL)action;
/** 设置导航栏右侧按钮*/
+ (void)setNavRight:(UIViewController *)viewController image:(NSString *)normalImg  title:(NSString *)title action:(SEL)action;
/** 将十六进制的字符串转换成NSString则可使用如下方式*/
+ (NSString *)convertHexStrToString:(NSString *)str;
//将十六进制的NSData转换成NSString则可使用如下方式:
+ (NSString *)convertDataToHexStr:(NSData *)data;
/** 获取年龄*/
+ (NSString *)getAgeDate:(NSString *)date;
+ (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath;

@end
