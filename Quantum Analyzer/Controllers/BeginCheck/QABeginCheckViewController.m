//
//  QABeginCheckViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/4.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QABeginCheckViewController.h"
#import "GifView.h"
#import "UIView+SDExtension.h"
#import "GraphView.h"
#import "DataBase.h"
#import "QABLEAdapter.h"
#import "HealthReportManager.h"
#import "QAHealthViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry.h>
#import "ReportListManager.h"
#import "ReportList.h"
#import "QANewHealthViewController.h"

typedef NS_ENUM(NSInteger,Buttonype) {
    WaitCheck  = 0,
    BeginCheck = 1,
    PauseCheck = 2,
    ContinueCheck = 3,
    StopCheck  = 4,
    SaveCheck  = 5
};

@interface QABeginCheckViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) GifView *gifView;
/* 曲线根视图*/
@property (weak, nonatomic) IBOutlet UIView *graphViewBg;
/* 曲线视图*/
@property (nonatomic, strong) GraphView *graphView;
/* 视频窗口*/
@property (weak, nonatomic) IBOutlet UIView *videoView;
/* 器官根视图*/
@property (weak, nonatomic) IBOutlet UIView *organView;
/* 时间视图*/
@property (weak, nonatomic) IBOutlet UIView *timeView;
/* 开始检测*/
@property (weak, nonatomic) IBOutlet UIButton *beginBtn;
/* 停止检测*/
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
/* 查看报告*/
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
/* 距离底部高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnBottom;
/* 视频宽度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoWidth;
/* 报告检测状态*/
@property (weak, nonatomic) IBOutlet UILabel *reportResultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *geImageView;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *checkTimer;
@property (nonatomic, strong) UIButton *lastBtn;
@property (nonatomic, assign) Buttonype buttonType;
@property (nonatomic, strong) QABLEAdapter *t;
@property (nonatomic,assign) NSInteger checkTime;
@property (nonatomic, strong) Person *person;
@property (nonatomic,strong) Record *record;
@property (nonatomic, strong) NSArray *sourceArray;

@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;

@property (weak, nonatomic) IBOutlet UIImageView *checkPeopleImageView;


/* 曲线背景图*/
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation QABeginCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleLabel:@"开始检测"];
    self.view.backgroundColor = UIColorFromRGB(0xD49203);
    
    [QABLEAdapter sharedBLEAdapter].beginViewController = self;
    _t = [QABLEAdapter sharedBLEAdapter];
    _t.beginViewController = self;
    _videoWidth.constant = (myx*250);
//    self.view.clipsToBounds=YES;
    _sourceArray = [[NSArray alloc] init];
    //视频
    NSURL *urlString = [[NSBundle mainBundle] URLForResource:@"man_1" withExtension:@"mov"];
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlString];
    _moviePlayer.repeatMode = MPMovieRepeatModeOne;
    // 设置播放视图的frame
    self.moviePlayer.view.frame = CGRectMake(0, 0, 250*myx, 360*myx);
    // 设置播放视图控制样式
    self.moviePlayer.controlStyle = MPMovieControlStyleNone;
    // 添加播放视图到要显示的视图
    [_videoView addSubview:self.moviePlayer.view];
    _moviePlayer.view.hidden = YES;
    //曲线图
    _graphView = [[GraphView alloc]initWithFrame:CGRectMake(0, 0, 125*myx, 150*myx)];
    [_graphView setBackgroundColor:[UIColor clearColor]];
    [_graphView setSpacing:10];
    [_graphView setFill:NO];
    [_graphView setStrokeColor:navbackgroundColor];
    [_graphView setZeroLineStrokeColor:[UIColor greenColor]];
    [_graphView setFillColor:[UIColor orangeColor]];
    [_graphView setLineWidth:1];
    [_graphView setCurvedLines:YES];
    [_graphViewBg addSubview:_graphView];
    //器官图
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"end.gif" ofType:nil];
    _gifView = [[GifView alloc] initWithFrame:CGRectMake(0, 0, 120*myx, 100*myx) filePath:filePath];
    [_organView addSubview:_gifView];
    [_gifView stop];

   _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setPointButtonAction) userInfo:nil repeats:YES];
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    
    _checkTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:[QABLEAdapter sharedBLEAdapter] selector:@selector(voltageCheck) userInfo:nil repeats:YES];
    [_checkTimer setFireDate:[NSDate distantFuture]];
    
    /* 修复webView加载慢的问题*/
    UIWebView *webView = [[UIWebView alloc] init];
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"JLZ检测综合报告单"ofType:@"htm"];
    NSString *template = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:template baseURL:baseURL];

}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    _videoWidth.constant = 250*myx;
    _btnBottom.constant = 50*myx;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([CommonCore queryMessageKey:CurrentUserID]) {
        NSString *fileName;
        _person = [[DataBase sharedDataBase] getCurrentLoginUser];
        [self initTitleLabel:_person.name];
        int rand = arc4random() % 3 + 1;
        if ([_person.sex isEqualToString:@"女"]) {
            fileName = [NSString stringWithFormat:@"nv_%d.mp4",rand];
        }else {
            fileName = [NSString stringWithFormat:@"man_%d.mp4",rand];
        }
        _moviePlayer.contentURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        NSString *fileString = [DocumentFile ProductPath:fileName];
        _checkPeopleImageView.image = [CommonCore getScreenShotImageFromVideoPath:fileString];
    }else {

        _moviePlayer.contentURL = [[NSBundle mainBundle] URLForResource:@"man_1.mp4" withExtension:nil];
        NSString *fileString = [DocumentFile ProductPath:@"man_1.mp4"];
        _checkPeopleImageView.image = [CommonCore getScreenShotImageFromVideoPath:fileString];
    }

    Person *person = [[DataBase sharedDataBase] getCurrentLoginUser];
    if ([person.age intValue] <= 14) {
        _sourceArray = [[ReportListManager sharedManager] getAllChildrenReport];
    }else if ([person.sex isEqualToString:@"男"]) {
        _sourceArray = [[ReportListManager sharedManager] getAllManReport];
    }else {
        _sourceArray = [[ReportListManager sharedManager] getAllWomanReport];
    }

}

/*
- (IBAction)checkBtnClick:(UIButton *)sender {
        if (sender.tag==0) {
            _checkTime = 0;
            _shiImageView.image = [UIImage imageNamed:@"6"];
            _geImageView.image = [UIImage imageNamed:@"0"];
            
            _buttonType = StopCheck;
            [_timer setFireDate:[NSDate distantFuture]];
            [[QABLEAdapter sharedBLEAdapter] stopCheck];
            [self.moviePlayer stop];
            [_gifView stop];
            _moviePlayer.view.hidden = YES;
            _beginBtn.selected =NO;
            _stopBtn.selected = NO;
            //保存结果
            _buttonType = SaveCheck;
            NSNumber *userID = [CommonCore queryMessageKey:CurrentUserID];
            _record = [[Record alloc] init];
            _record.time = [CommonCore currentTime];
            _record.own_id = userID;
            _record.report = [[HealthReportManager sharedManager]saveUserDataToSqlite:_record.time];
            [[DataBase sharedDataBase] addRecord:_record toPerson:_person];
            _reportResultLabel.text = @"全部检测完成";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"报告生成成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertView show];
            
            return;
        }else if (sender.tag==2) {
            _beginBtn.selected = NO;
            _stopBtn.selected = NO;
            _saveBtn.selected = NO;
            //查看检测报告
            QAHealthViewController *healthVC = [[QAHealthViewController alloc] init];
            healthVC.report = _record.report;
            healthVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:healthVC animated:YES];
            return;
        }
        
    }

*/

- (IBAction)checkBtnClick:(UIButton *)sender {
    if (![CommonCore queryMessageKey:CurrentUserID]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录账户，再进行检测" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    else if (!_t.activePeripheral) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先通过蓝牙连接硬件设备" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    
    if (sender.selected == YES) {
        return;
    }
    if (sender.tag == 0) {
        [self resetAllState];
        _saveBtn.enabled = NO;
        _stopBtn.selected = NO;
        _saveBtn.backgroundColor = grayFontColor;
        _beginBtn.backgroundColor = grayFontColor;
        _stopBtn.backgroundColor = UIColorFromRGB(0x4DDFFE);
        //开启定时器
        _buttonType = WaitCheck;
        [_checkTimer setFireDate:[NSDate distantPast]];
        
        NSString *fileName;
        _person = [[DataBase sharedDataBase] getCurrentLoginUser];
        [self initTitleLabel:_person.name];
        int rand = arc4random() % 3 + 1;
        if ([_person.sex isEqualToString:@"女"]) {
            fileName = [NSString stringWithFormat:@"nv_%d.mp4",rand];
        }else {
            fileName = [NSString stringWithFormat:@"man_%d.mp4",rand];
        }
        _moviePlayer.contentURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        NSString *fileString = [DocumentFile ProductPath:fileName];
        _checkPeopleImageView.image = [CommonCore getScreenShotImageFromVideoPath:fileString];
        

    }else if (sender.tag == 1) {
        _beginBtn.selected = NO;
        _beginBtn.backgroundColor = UIColorFromRGB(0x4DDFFE);
        _stopBtn.backgroundColor = grayFontColor;
        //关闭定时器
        _buttonType = StopCheck;
        _checkTime = 0;
        [_timer setFireDate:[NSDate distantFuture]];
        [[QABLEAdapter sharedBLEAdapter] stopCheck];
        [self.moviePlayer stop];
        _moviePlayer.view.hidden = YES;
        [_gifView stop];

        
    }else {
        _beginBtn.selected = NO;
        _stopBtn.selected = NO;
        _saveBtn.selected = NO;
        _beginBtn.backgroundColor = UIColorFromRGB(0x4DDFFE);
        _stopBtn.backgroundColor = UIColorFromRGB(0x4DDFFE);
        _saveBtn.backgroundColor = UIColorFromRGB(0x4DDFFE);
        //查看检测报告
//        QAHealthViewController *healthVC = [[QAHealthViewController alloc] init];
        QANewHealthViewController *healthVC = [[QANewHealthViewController alloc] init];
        healthVC.report = _record.report;
        healthVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:healthVC animated:YES]; 
        return;

    }
    sender.selected = YES;
}

/** 停止检测*/
- (void)stopCheck {
    _beginBtn.selected = NO;
    _beginBtn.backgroundColor = UIColorFromRGB(0x4DDFFE);
    _stopBtn.backgroundColor = grayFontColor;
    //关闭定时器
    _buttonType = StopCheck;
    _checkTime = 0;
    [_timer setFireDate:[NSDate distantFuture]];
//    [[QABLEAdapter sharedBLEAdapter] stopCheck];
    [self.moviePlayer stop];
    _moviePlayer.view.hidden = YES;
    [_gifView stop];
    [_checkTimer setFireDate:[NSDate distantFuture]];

}


/* 复位状态*/
- (void)resetAllState {
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
    [_graphView resetGraph];
    [[QABLEAdapter sharedBLEAdapter] saveCheckResult];

}

/* 获取反馈数据*/
-(void) OnReadChar:(CBCharacteristic *)characteristic{
    NSLog(@"KeyfobViewController didUpdateValueForCharacteristic %@", characteristic);
    NSLog(@"接收到的数据:%@",[[characteristic value] description]);
    if (characteristic.value.length != 7) {
        return;
    }
    NSString *valueStr = [self convertDataToHexStr:[characteristic value]];
    valueStr = [valueStr substringToIndex:10];
    NSInteger value = [[CommonCore convertHexStrToString:valueStr] integerValue];
   //NSInteger value = 15000;
    NSLog(@"valueStr: %@   value: %ld",valueStr,value);

    if (_buttonType == WaitCheck) {
        
        if (value < 20000) {
            _buttonType = BeginCheck;
            [[QABLEAdapter sharedBLEAdapter] startCheck];
            [_timer setFireDate:[NSDate distantPast]];
            [[QABLEAdapter sharedBLEAdapter] voltageCheck];
            _moviePlayer.view.hidden = NO;
            [self.moviePlayer play];
            [_gifView start];


        }
        
    }else if (_buttonType == BeginCheck) {
        if (value > 20000) {
            _buttonType = ContinueCheck;
            [[QABLEAdapter sharedBLEAdapter] pauseCheck];
            [_timer setFireDate:[NSDate distantFuture]];
            [_gifView pause];
            [self.moviePlayer pause];
        }
    } else if (_buttonType == PauseCheck) {
        
        if (value < 20000) {
            _buttonType = ContinueCheck;
            [[QABLEAdapter sharedBLEAdapter] continueCheck];
            [_timer setFireDate:[NSDate distantPast]];
            [self.moviePlayer play];
            [_gifView play];




        }
    }else if (_buttonType == ContinueCheck) {
        if (value>20000) {
            _buttonType = PauseCheck;
            [[QABLEAdapter sharedBLEAdapter] pauseCheck];
            [_timer setFireDate:[NSDate distantFuture]];
            [self.moviePlayer pause];
            [_gifView pause];

        }
    }
    
}

- (NSString *)convertDataToHexStr:(NSData *)data {
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



-(NSData *)dataFromHexString:(NSString *)string {
    string = [string lowercaseString];
    NSMutableData *data= [NSMutableData new];
    
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i = 0;
    int length = string.length;
    while (i < length-1) {
        char c = [string characterAtIndex:i++];
        if (c < '0' || (c > '9' && c < 'a') || c > 'f')
            continue;
        byte_chars[0] = c;
        byte_chars[1] = [string characterAtIndex:i++];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
        
    }
    
    return data;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    _saveBtn.enabled = YES;
    _saveBtn.backgroundColor = navbackgroundColor;
    _stopBtn.selected = YES;
    [self resetAllState];

}

-(void)setPointButtonAction {
    _checkTime++;
    NSInteger count = _checkTime;
    NSString *shi,*ge;
    shi = [NSString stringWithFormat:@"%ld",count/10];
    ge = [NSString stringWithFormat:@"%ld",count%10];
    _shiImageView.image = [UIImage imageNamed:shi];
    _geImageView.image = [UIImage imageNamed:ge];
    if (_checkTime >=[[CommonCore queryMessageKey:CheckTime] integerValue]) {
        _checkTime = 0;
        _shiImageView.image = [UIImage imageNamed:@"0"];
        _geImageView.image = [UIImage imageNamed:@"0"];
        
        _buttonType = StopCheck;
        [_timer setFireDate:[NSDate distantFuture]];
        [[QABLEAdapter sharedBLEAdapter] stopCheck];
        [self.moviePlayer stop];
        [_gifView stop];
        _moviePlayer.view.hidden = YES;
        _beginBtn.selected =NO;
        _stopBtn.selected = NO;
        _beginBtn.backgroundColor = UIColorFromRGB(0x4DDFFE);
        _stopBtn.backgroundColor = UIColorFromRGB(0x4DDFFE);
        //保存结果
        _buttonType = SaveCheck;
        NSNumber *userID = [CommonCore queryMessageKey:CurrentUserID];
        _record = [[Record alloc] init];
        _record.time = [CommonCore currentTime];
        _record.own_id = userID;
        _record.report = [[HealthReportManager sharedManager]saveUserDataToSqlite:_record.time];
        [[DataBase sharedDataBase] addRecord:_record toPerson:_person];
        _reportResultLabel.text = @"全部检测完成";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"报告生成成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
        return;
    }
    // generate random numbers between +100 and -100
    float low_bound = -100.00;
    float high_bound = 100.00;
    float rndValue = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
    int intRndValue = (int)(rndValue + 0.5);
    [_graphView setPoint:intRndValue];
    ReportList *repolist = _sourceArray[count/(60/_sourceArray.count)%_sourceArray.count];
    
    if ((count+1)%(60/_sourceArray.count) !=0) {
        NSString *nameStr = [repolist.reportName substringToIndex:repolist.reportName.length-2];
        _reportResultLabel.text = [NSString stringWithFormat:@"正在进行%@检测......",nameStr];
    }else {
        NSString *nameStr = [repolist.reportName substringToIndex:repolist.reportName.length-2];
        _reportResultLabel.text = [NSString stringWithFormat:@"%@已检测完成",nameStr];
    }

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
