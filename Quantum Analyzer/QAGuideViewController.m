//
//  QAGuideViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/5.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAGuideViewController.h"

@interface QAGuideViewController ()<UIScrollViewDelegate,UITextFieldDelegate>

@property (retain, nonatomic)UIScrollView *pageScroll; //滑动条
@property (retain, nonatomic)UIPageControl *pageControl; //下面的小圆点
@property (nonatomic, strong)NSArray  *arrayImages;        //存放图片的数组
@property (nonatomic, strong)NSMutableArray *viewControllers; //存放UIViewController的可变数组
@property (retain, nonatomic) UIButton *setGotoMainViewBtn; //按钮点击进入主页
@property (nonatomic, strong) UITextField *passwordTextField;
@end

@implementation QAGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self userGuide];
}

#pragma mark -用户引导界面
-(void)userGuide
{
    //图片数组
    self.arrayImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"guide1.jpg"],[UIImage imageNamed:@"guide2.jpg"],nil];
    
    //滑动条
    _pageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]))];
    [_pageScroll setPagingEnabled:YES];
    _pageScroll.bounces = NO;
    _pageScroll.showsHorizontalScrollIndicator = NO;
    _pageScroll.showsVerticalScrollIndicator = NO;
    [_pageScroll setDelegate:self]; //设置代理
    [_pageScroll setBackgroundColor:[UIColor clearColor]];
    //ContentSize 这个属性对于UIScrollView挺关键的，取决于是否滚动。
    [_pageScroll setContentSize:CGSizeMake(CGRectGetWidth(self.pageScroll.frame) * (self.arrayImages.count), CGRectGetHeight(self.pageScroll.frame))];
    //banbao modifiy start with 2015-10-23
    [self.view addSubview:_pageScroll];
    //    [self.window  addSubview:_pageScroll];
    //banbao modifiy end
    //滚动的原点
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.pageScroll.frame.size.height - 50, CGRectGetWidth(self.pageScroll.frame), 20)];
    _pageScroll.backgroundColor = [UIColor redColor];
    _pageControl.numberOfPages = [self.arrayImages count];
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self loadImage];//加载滑动的动画
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)endKeyBoard {
    [_passwordTextField resignFirstResponder];
}

- (void)loadImage
{
        self.viewControllers = [NSMutableArray arrayWithCapacity:[self.arrayImages count]];
        for (int i = 0; i < [self.arrayImages count]; ++i) {
            //如果是最后一个视图，则放在数组里的不是imageview 而是一个view，view里面有imageview 和button
            if(i == ([self.arrayImages count]-1)){
                UIImageView *imageViews = [[UIImageView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(self.pageScroll.frame), 0, CGRectGetWidth(self.pageScroll.frame), CGRectGetHeight(self.pageScroll.frame))];
                imageViews.contentMode = UIViewContentModeScaleToFill;
                imageViews.image = [self.arrayImages objectAtIndex:i];
                imageViews.userInteractionEnabled = YES;
                imageViews.userInteractionEnabled = YES;
                
                _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(DScreenWidth/2-75, DScreenHeight-350*myy, 150, 36)];
                _passwordTextField.placeholder  = @"登录密码";
                _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
                _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
                _passwordTextField.returnKeyType = UIReturnKeyDone;
                _passwordTextField.backgroundColor = [UIColor whiteColor];
                _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
                _passwordTextField.secureTextEntry = YES;
                _passwordTextField.delegate = self;
                [imageViews addSubview:_passwordTextField];
                _setGotoMainViewBtn =[UIButton buttonWithType:UIButtonTypeCustom];
                _setGotoMainViewBtn.backgroundColor = [UIColor whiteColor];
                [_setGotoMainViewBtn setTitle:@"马上体验" forState:UIControlStateNormal];
                [_setGotoMainViewBtn setTitleColor:navbackgroundColor forState:UIControlStateNormal];
                _setGotoMainViewBtn.frame = CGRectMake(DScreenWidth/2-100, DScreenHeight-200*myy, 200, 36);
                _setGotoMainViewBtn.layer.cornerRadius = 18;
                _setGotoMainViewBtn.titleLabel.font = [UIFont systemFontOfSize:20];

                
                [imageViews addSubview:_setGotoMainViewBtn];
                [_setGotoMainViewBtn addTarget:self  action:@selector(postRootViewController) forControlEvents:UIControlEventTouchUpInside];
                [self.pageScroll addSubview:imageViews];
                [self.viewControllers addObject:imageViews];
                break;
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(self.pageScroll.frame), 0, CGRectGetWidth(self.pageScroll.frame),CGRectGetHeight(self.pageScroll.frame))];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.image = [self.arrayImages objectAtIndex:i];
            [self.pageScroll addSubview:imageView];
            [self.viewControllers addObject:imageView];
        }

    //    [self.viewController1.view addSubview:_pageControl];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [_passwordTextField resignFirstResponder];
    return YES;
}

#pragma -mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = _pageScroll.frame.size.width;
    int currentPage = floor((_pageScroll.contentOffset.x - pagewidth/ ([self.arrayImages count]+1)) / pagewidth) + 1;
    self.pageControl.currentPage = currentPage;
}

- (void)postRootViewController{
    if ([CommonCore queryMessageKey:PassWord]) {
        if ([_passwordTextField.text isEqualToString:[CommonCore queryMessageKey:PassWord]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:BeginGuidePage object:nil];
            return;
        }
    }else {
    
        if ([_passwordTextField.text isEqualToString:@"000000"]) {
            [CommonCore SaveMessageObject:@"60" key:CheckTime];
            [[NSNotificationCenter defaultCenter] postNotificationName:BeginGuidePage object:nil];
            return;
        }
    
    }

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"密码错误，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
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
