//
//  detailViewController.h
//  Evacool
//
//  Created by 罗路雅 on 2024/1/3.
//

#import <UIKit/UIKit.h>
#import "dataCode.h"

NS_ASSUME_NONNULL_BEGIN

@interface detailViewController : UIViewController
@property (nonatomic,strong) dataCode *datacode;
@property (nonatomic,strong) NSString *brand;
@end

NS_ASSUME_NONNULL_END
