//
//  faultsViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/3.
//

#import "faultsViewController.h"
#import "TruckViewController.h"
#import "BabyBluetooth.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"
#import "crc.h"

@interface faultsViewController ()
@property(nonatomic,strong) UIButton *btback;
@property(nonatomic,strong) UILabel *labeltitle;
@end

@implementation faultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datacode = [[dataCode alloc]init];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self autolayout];
}


-(void) autolayout{
    
    self.btback = [UIButton new];
    [self.view addSubview:self.btback];
    [self.btback setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
    self.btback.sd_layout
    .leftSpaceToView(self.view, 30)
    .topSpaceToView(self.view, 20.0)
    .widthIs(10)
    .heightIs(20);
    [self.btback addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    self.labeltitle = [UILabel new];
    [self.view addSubview: self.labeltitle];
    [self.labeltitle setTextColor:[UIColor blackColor]];
    [self.labeltitle setFont:[UIFont fontWithName:@"Arial" size:18.0]];
    self.labeltitle.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 40.0)
    .widthIs(self.view.width)
    .heightIs(80);
    [self.labeltitle setTextAlignment:NSTextAlignmentCenter];
    [self.labeltitle setText:@"Faults Record"];

}

-(void) goback{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
