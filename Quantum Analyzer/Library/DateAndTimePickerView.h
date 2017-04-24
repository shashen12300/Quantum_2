//  练手
//
//  Created by H.G on 16/1/12.
//  Copyright © 2016年 H.G. All rights reserved.
//  QQ交流:297505427
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(NSString *dateTime);
@class DateAndTimePickerView;
@protocol DateAndTimePickerViewDelegate <NSObject>

- (void)dateAndTimePickerView:(DateAndTimePickerView *)pickerView dateTime:(NSString *)dateTime;

@end

@interface DateAndTimePickerView : UIView

/** 代理*/
@property (nonatomic, assign) id<DateAndTimePickerViewDelegate> delegate;
/** black*/
@property (nonatomic, readwrite,copy) ClickBlock dateTimleBlack;

- (void)returnText:(ClickBlock)block;

- (void)showInView:(UIView *)view;
@end
