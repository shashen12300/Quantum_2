//
//  CommonCore.m
//  Calculus
//
//  Created by 宋冲冲 on 16/3/25.
//  Copyright © 2016年 zhangjia. All rights reserved.
//

#import "CommonCore.h"
#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>

@implementation CommonCore

/** 保存消息信息*/
+ (void)SaveMessageObject:(id)object key:(NSString *)key{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:object  forKey:key];
    [defaults synchronize];
}
/** 查询消息*/
+ (id)queryMessageKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

/** 计算时间间隔*/
+ (NSTimeInterval)timeToString:(NSString *)timeStr {
    NSDate *today=[NSDate date];
    NSDate *date=[CommonCore stringToDate:timeStr :@"yyyy-MM-dd HH:mm:ss"];
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [date timeIntervalSinceDate:today];
    return time;
}


//字符串转时间
+ (NSDate *)stringToDate:(NSString *)dateString :(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}

/** 获取当前时间*/
+ (NSString *)currentTime {
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateformatter stringFromDate:senddate];
}

+(NSData *)returnDataWithDictionary:(NSDictionary *)dict
{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dict forKey:@"talkData"];
    [archiver finishEncoding];
    
    return data;
}

/** 保存玩家信息到本地*/
+ (void)saveMemberMessage:(NSDictionary *)dic {
    NSArray *keys = [dic allKeys];
    for (NSString *key in keys) {
        [CommonCore SaveMessageObject:dic[key] key:key];
    }
}

+ (NSDictionary *)dictionaryWithModel:(id)model {
    if (model == nil) {
        return nil;
    }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 获取类名/根据类名获取类对象
    NSString *className = NSStringFromClass([model class]);
    id classObject = objc_getClass([className UTF8String]);
    // 获取所有属性
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    // 遍历所有属性
    for (int i = 0; i < count; i++) {
        // 取得属性
        objc_property_t property = properties[i];
        // 取得属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        // 取得属性值
        id propertyValue = nil;
        id valueObject = [model valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
        } else if ([valueObject isKindOfClass:[NSString class]]) {
            propertyValue = [NSString stringWithFormat:@"%@", [model valueForKey:propertyName]];
        } else {
            propertyValue = [model valueForKey:propertyName];
        }
        if(propertyValue==nil){
            propertyValue=@"";
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    return [dict copy];
}

/** 保存图片到相册*/
- (void)saveImageToPhotos:(UIImage *)savedImage {
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

/** 获取内容的高度或者宽度*/
+ (CGFloat) getContentHeight:(NSString *)content size:(CGSize)size fontSize:(NSInteger)fontSize {
    
    CGFloat height = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size.height + fontSize;
    return height;
}

+ (CGFloat) getContentWidth:(NSString *)content size:(CGSize)size fontSize:(NSInteger)fontSize {
    
    CGFloat width = [content boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size.width;
    return width;
}

+ (NSString *)jsonWithArray:(id) object{
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}

/** json串转字典或者数组*/
+ (id)objectWithJson:(NSString *)jsonString {
    if ([CommonCore isBlankString:jsonString]) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (object != nil && error == nil) {
        return object;
    }else {
        //解析错误
        return nil;
    }
    
}

/*图片背景虚化模糊*/
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

//非空判断
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

//将十六进制的字符串转换成十进制的字符串则可使用如下方式:
+ (NSString *)convertHexStrToString:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    NSString *string = [[NSString alloc]initWithData:hexData encoding:NSUTF8StringEncoding];
    return string;
}

//将十六进制的NSData转换成NSString则可使用如下方式:
+ (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}
/** 获取年龄*/
+ (NSString *)getAgeDate:(NSString *)date {
    NSString *birthYear = [date substringToIndex:4];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate* dt = [NSDate date];
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: NSCalendarUnitYear
                                          fromDate:dt];
    //    NSInteger age = comp.year - [birthYear integerValue];
    NSString *age = [NSString stringWithFormat:@"%ld",comp.year - [birthYear integerValue]];
    return age;
}

/*
 设置自定义导航栏左侧按钮
 */
+ (void)setNavLeftBack:(UIViewController *)viewController
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 95, 44)];
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    //设置图片文字偏移量
    CGFloat width = (WIDTH(button) - WIDTH(button.imageView) - WIDTH(button.titleLabel))/2;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -width*2, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -width*2 + 5, 0, 0)];
    [button addTarget:viewController.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationController.navigationBar.translucent = NO;
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([viewController isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableviewController = (UITableViewController *)viewController;
        tableviewController.tableView.backgroundColor = UIColorFromRGB(0xf5f0eb);
    }else {
        viewController.view.backgroundColor = UIColorFromRGB(0xf5f0eb);
    }
}

+ (void)setNavLeftBack:(UIViewController *)viewController action:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 95, 44)];
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    //设置图片文字偏移量
    CGFloat width = (WIDTH(button) - WIDTH(button.imageView) - WIDTH(button.titleLabel))/2;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -width*2, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -width*2 + 5, 0, 0)];
    [button addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    
    viewController.navigationController.navigationBar.translucent = NO;
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if ([viewController isKindOfClass:[UITableViewController class]]) {
        UITableViewController *tableviewController = (UITableViewController *)viewController;
        tableviewController.tableView.backgroundColor = UIColorFromRGB(0xf5f0eb);
    }else {
        viewController.view.backgroundColor = UIColorFromRGB(0xf5f0eb);
    }
}

+ (void)setNavRight:(UIViewController *)viewController image:(NSString *)normalImg  title:(NSString *)title action:(SEL)action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [button setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    //设置图片文字偏移量
    CGFloat width = (WIDTH(button) - WIDTH(button.imageView) - WIDTH(button.titleLabel))/2;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, width*2 - 5, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, width*2, 0, 0)];
    
    [button addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    viewController.navigationController.navigationBar.translucent = NO;
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIImage *)getScreenShotImageFromVideoPath:(NSString *)filePath{
    
    UIImage *shotImage;
    //视频路径URL
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.2, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return shotImage;
    
}



@end
