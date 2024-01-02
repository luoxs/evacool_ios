//
//  HomeViewController.h
//  Evacool
//
//  Created by 罗路雅 on 2023/12/26.
//

#import <UIKit/UIKit.h>
#import "BabyBluetooth.h"
#import "DataRead.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController{
@public BabyBluetooth *baby;
}
@property (nonatomic, strong) NSData *data;
@property (nonatomic,strong) CBCharacteristic *characteristic;
@property (nonatomic,strong) CBPeripheral *currPeripheral;
@property (nonatomic,retain) DataRead *dataRead;
@property (nonatomic,strong) NSString *brand;
@end

NS_ASSUME_NONNULL_END
