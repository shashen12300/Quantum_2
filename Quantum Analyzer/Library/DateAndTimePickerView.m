//  练手
//
//  Created by H.G on 16/1/12.
//  Copyright © 2016年 H.G. All rights reserved.
//  QQ交流:297505427
//
#import "DateAndTimePickerView.h"
#define currentMonth [currentMonthString integerValue]


@interface DateAndTimePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

#pragma mark - IBActions

//@property (weak, nonatomic) IBOutlet UITextField *textFieldEnterDate;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;

@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;
/** 遮挡层*/
@property (weak, nonatomic) IBOutlet UIView *clearView;

#pragma mark - IBActions

- (IBAction)actionCancel:(id)sender;

- (IBAction)actionDone:(id)sender;

@end

@implementation DateAndTimePickerView
{
    
    NSMutableArray *yearArray;
    NSMutableArray *monthArray;
    NSMutableArray *hourArray;
    NSMutableArray *minuteArray;
    NSMutableArray *DaysArray;
    NSString *currentMonthString;
    
    NSInteger selectedYearRow;
    NSInteger selectedMonthRow;
    NSInteger selectedDayRow;
    
    BOOL firstTimeLoad;
    
    NSInteger m ;
    int year;
    int month;
    int day;
    int hour;
    int minute;
    
}

- (id)init {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DateAndTimePickerView" owner:nil options:nil]lastObject];
        _customPicker.delegate = self;
        _customPicker.dataSource = self;
        [self creatViewUI];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"DateAndTimePickerView" owner:nil options:nil]lastObject];
        _customPicker.delegate = self;
        _customPicker.dataSource = self;
        [self creatViewUI];
    }
    return self;
}

- (void)creatViewUI
{
    NSDate *date = [NSDate date];
    // Get Current Year
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                    [formatter stringFromDate:date]];
    year =[currentyearString intValue];
    // Get Current  Month
    [formatter setDateFormat:@"MM"];
    currentMonthString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    month=[currentMonthString intValue];
    // Get Current  Date
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    day =[currentDateString intValue];
    //Get Current HH
    [formatter setDateFormat:@"HH"];
    NSString *currentHourString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    hour = [currentHourString intValue];
    //Get Current mm
    [formatter setDateFormat:@"mm"];
    NSString *currentMinuteString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    minute = [currentMinuteString intValue];
    //初始化
    yearArray = [[NSMutableArray alloc]init];
    DaysArray = [[NSMutableArray alloc]init];
    monthArray = [[NSMutableArray alloc]init];
    hourArray = [[NSMutableArray alloc]init];
    minuteArray = [[NSMutableArray alloc]init];
    for (int i = 1900; i <= year; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i=1; i<=12; ++i) {
        [monthArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    for (int i = 1; i <= 31; i++)
    {
        [DaysArray addObject:[NSString stringWithFormat:@"%02d",i]];
        
    }
    for (int i = 0; i <24; ++i) {
        [hourArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    for (int i = 0; i <60; ++i) {
        [minuteArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    // 设置初始默认值
    [self.customPicker selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
    [self.customPicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
    [self.customPicker selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
//    [self.customPicker selectRow:[hourArray indexOfObject:currentHourString] inComponent:3 animated:YES];
//    [self.customPicker selectRow:[minuteArray indexOfObject:currentMinuteString] inComponent:4 animated:YES];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearHandle)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_clearView addGestureRecognizer:tap];

}

- (void)clearHandle {
    self.hidden = YES;
}



#pragma mark - UIPickerViewDelegate


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if (component == 0)
    {
        selectedYearRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 1)
    {
        selectedMonthRow = row;
        [self.customPicker reloadAllComponents];
    }
    else if (component == 2)
    {
        selectedDayRow = row;
        
        [self.customPicker reloadAllComponents];
        
    }
    
}


#pragma mark - UIPickerViewDatasource

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    
    // Custom View created for each component
    
    UILabel *pickerLabel = (UILabel *)view;
    
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 50, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    
    
    
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row]; // Year
    }
    else if (component == 1)
    {
        pickerLabel.text =  [monthArray objectAtIndex:row];  // Month
    }
    else if (component == 2)
    {
        pickerLabel.text =  [DaysArray objectAtIndex:row]; // Date
        
    }else if (component == 3) {
        pickerLabel.text = [hourArray objectAtIndex:row]; //hour
    }else if (component == 4) {
        pickerLabel.text = [minuteArray objectAtIndex:row];//minute
    }
    
    return pickerLabel;
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;

}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        return [yearArray count];
        
    }
    else if (component == 1)
    {

        return [monthArray count];

    }
    else if (component == 2)
    {
        if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
        {
            return 31;
        }
        else if (selectedMonthRow == 1)
        {
            int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
            
            if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                return 29;
            }
            else
            {
                return 28; // or return 29
            }
            
            
            
        }
        else
        {
            return 30;
        }
        
    }else if (component == 3) {
        return hourArray.count;
        //小时
    }else if (component == 4) {
        //分钟
        return minuteArray.count;
    }else {
        return 60;
    }
    
}


- (void)returnText:(ClickBlock)block {
    self.dateTimleBlack = block;
}



- (IBAction)actionCancel:(id)sender
{
    
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.hidden = YES;

                     }
                     completion:^(BOOL finished){
 
                     }];

    
}

- (IBAction)actionDone:(id)sender
{

    NSString *dateTime = [NSString stringWithFormat:@"%@-%@-%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
    NSLog(@"日期： %@",dateTime);
   

    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         if (self.dateTimleBlack != nil) {
                             self.hidden = YES;
                             self.dateTimleBlack(dateTime);
                         }
                     }
                     completion:^(BOOL finished){
                      
                         [self clearHandle];
                         
                     }];
    
  
    
}

- (void)showInView:(UIView *)view
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}



@end
