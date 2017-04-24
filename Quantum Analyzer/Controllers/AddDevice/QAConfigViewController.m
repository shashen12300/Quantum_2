//
//  QAConfigViewController.m
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/9.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import "QAConfigViewController.h"
#import "QABLEAdapter.h"
@interface QAConfigViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *sourceArray;

@end

@implementation QAConfigViewController

    QABLEAdapter *t;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"搜索设备";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(connectToDevice)];
//    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
//        [self connectToDevice];
//    }];
    t = [QABLEAdapter sharedBLEAdapter];
    t.configViewController = self;
    [t controlSetup:1];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [NSTimer scheduledTimerWithTimeInterval:(float)1.0 target:self selector:@selector(connectToDevice) userInfo:nil repeats:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
/* 搜索蓝牙设备*/
- (void)connectToDevice {
    // start progress spinner
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [self.sourceArray removeAllObjects];
//    [self.tableView reloadData];
//    if (t.activePeripheral) if(t.activePeripheral.state) [[t CM] cancelPeripheralConnection:[t activePeripheral]];
//    if (t.peripherals) t.peripherals = nil;
    
    [t findBLEPeripherals:2];
    [NSTimer scheduledTimerWithTimeInterval:(float)1.0 target:self selector:@selector(connectionTimer:) userInfo:nil repeats:NO];
}

// Called when scan period is over to connect to the first found peripheral
-(void) connectionTimer:(NSTimer *)timer {
    if(t.peripherals.count > 0)
    {
        [t printKnownPeripherals];
        
        if( t.peripherals.count > 0)
            [self insertScannedperipherals];
    }
    // stop progress spinner
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//    [self.tableView.mj_header endRefreshing];
}

- (void)insertScannedperipherals
{

//    for(int i=0; i < [t.peripherals count]; i++)
//    {
//        [self.sourceArray insertObject:[[t peripherals] objectAtIndex:i] atIndex:0];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    }
    
    NSMutableArray *array = [t peripherals];
        [_sourceArray removeAllObjects];
        for (CBPeripheral *object in array) {
            if (object.name) {
                [self.sourceArray addObject:object];
            }
        }
        [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    CBPeripheral *object = self.sourceArray[indexPath.row];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (!object.state) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = object.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *p = self.sourceArray[indexPath.row];
    [self showHud];

    if (!p.state) {
        [t connectPeripheral:p status:true];
    }else {
        [t connectPeripheral:p status:false];

    }
}

- (void)onConnected:(BOOL)connect {
    [self hideHud];
//    [self.tableView reloadData];
    [self connectToDevice];
    
}

- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [[NSMutableArray alloc] init];
    }
    return _sourceArray;
}

// Converts CBCentralManagerState to a string... implement as a category on CBCentralManagerState?
+(NSString *)getCBCentralStateName:(CBCentralManagerState) state
{
    NSString *stateName;
    
    switch (state) {
        case CBCentralManagerStatePoweredOn:
            stateName = @"Bluetooth Powered On - Ready";
            break;
        case CBCentralManagerStateResetting:
            stateName = @"Resetting";
            break;
            
        case CBCentralManagerStateUnsupported:
            stateName = @"Unsupported";
            break;
            
        case CBCentralManagerStateUnauthorized:
            stateName = @"Unauthorized";
            break;
            
        case CBCentralManagerStatePoweredOff:
            stateName = @"Bluetooth Powered Off";
            break;
            
        default:
            stateName = @"Unknown";
            break;
    }
    return stateName;
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
