//
//  ProfileViewController.h
//  Evacool
//
//  Created by 罗路雅 on 2024/1/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property(nonatomic,strong)NSString *userNmae;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSDate *regdate;
@end

NS_ASSUME_NONNULL_END
