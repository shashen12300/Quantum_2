//
//  QABLEAdapter.h
//  Quantum Analyzer
//
//  Created by 宋冲冲 on 2016/12/11.
//  Copyright © 2016年 宋冲冲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>
#import "QAAddViewController.h"
#import "QAConfigViewController.h"
#import "QABeginCheckViewController.h"

@interface QABLEAdapter : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate> {
    
}

+ (QABLEAdapter *)sharedBLEAdapter;

@property (nonatomic, weak) QABeginCheckViewController *beginViewController;
@property (nonatomic, strong) QAConfigViewController *configViewController;
@property (nonatomic, strong) QAAddViewController *addViewController;
@property (strong, nonatomic) NSMutableArray *peripherals;
@property (strong, nonatomic) CBCentralManager *CM;
@property (strong, nonatomic) CBPeripheral *activePeripheral;

-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p data:(NSData *)data;
-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p;
-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID  p:(CBPeripheral *)p on:(BOOL)on;

-(UInt16) swap:(UInt16) s;
-(int) controlSetup:(int) s;
-(int) findBLEPeripherals:(int) timeout;
-(const char *) centralManagerStateToString:(int)state;
-(void) scanTimer:(NSTimer *)timer;
-(void) printKnownPeripherals;
-(void) printPeripheralInfo:(CBPeripheral*)peripheral;
-(void) connectPeripheral:(CBPeripheral *)peripheral status:(BOOL)status;
-(NSString *)GetServiceName:(CBUUID *)UUID;
-(void) getAllCharacteristicsForService:(CBPeripheral *)p service:(CBService *)s;
-(void) getAllServicesFromPeripheral:(CBPeripheral *)p;
-(void) getAllCharacteristicsFromPeripheral:(CBPeripheral *)p;
-(CBService *) findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p;
-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service;
-(NSString *) CBUUIDToNSString:(CBUUID *) UUID;  // see CBUUID UUIDString in iOS 7.1
-(const char *) UUIDToString:(NSUUID *) UUID;
-(const char *) CBUUIDToString:(CBUUID *) UUID;
-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2;
-(int) compareCBUUIDToInt:(CBUUID *) UUID1 UUID2:(UInt16)UUID2;
-(UInt16) CBUUIDToInt:(CBUUID *) UUID;
- (CBCharacteristic *)getCurrentCharacteristic;
- (void)voltageCheck;
- (void)startCheck;
- (void)pauseCheck;
- (void)continueCheck;
- (void)stopCheck;
- (void)saveCheckResult;

@end
