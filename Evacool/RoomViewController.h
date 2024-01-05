//
//  RoomViewcontrollerViewController.h
//  Evacool
//
//  Created by 罗路雅 on 2024/1/5.
//

#import <UIKit/UIKit.h>
#import "BabyBluetooth.h"
#import "DataReadR.h"
#import "datacode.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoomViewController : UIViewController{
@public BabyBluetooth *baby;
}
@property (nonatomic, strong) NSData *data;
@property (nonatomic,strong) CBCharacteristic *characteristic;
@property (nonatomic,strong) CBPeripheral *currPeripheral;
@property (nonatomic,strong) NSString *brand;
@property  NSInteger tag;
@property (nonatomic,retain) DataReadR *dataRead;
@property (nonatomic,retain) dataCode *datacode;
@end

NS_ASSUME_NONNULL_END
