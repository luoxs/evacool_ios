//
//  TruckViewController.h
//  Evacool
//
//  Created by 罗路雅 on 2023/12/26.
//

#import <UIKit/UIKit.h>
#import "BabyBluetooth.h"
#import "DataRead.h"
#import "datacode.h"

NS_ASSUME_NONNULL_BEGIN

@interface TruckViewController : UIViewController{
@public BabyBluetooth *baby;
}

@property (nonatomic, strong) NSData *data;
@property (nonatomic,strong) CBCharacteristic *characteristic;
@property (nonatomic,strong) CBPeripheral *currPeripheral;
@property (nonatomic,strong) NSString *brand;
@property  NSInteger tag;
@property (nonatomic,retain) DataRead *dataRead;
@property (nonatomic,retain) dataCode *datacode;
@end

NS_ASSUME_NONNULL_END
