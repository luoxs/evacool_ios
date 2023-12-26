//
//  TruckViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2023/12/26.
//

#import "TruckViewController.h"
#import "BabyBluetooth.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"

@interface TruckViewController ()

@end

@implementation TruckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutoLayout];
    
}

-(void)setAutoLayout{
    
    double frameWidth = 750;
    double frameHeight = 1624;
    double viewX = [UIScreen mainScreen].bounds.size.width;
    double viewY = [UIScreen mainScreen].bounds.size.height;
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255 green:248.0/255 blue:249.0/255 alpha:1.0]];
    
    //顶部文字
    UIImageView *imageTop = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imagetop"]];
    [self.view addSubview:imageTop];
    imageTop.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 92.0/frameHeight*viewY)
    .widthIs(228.0/frameWidth*viewX)
    .heightIs(82.0/frameHeight*viewY);
   
    //坐上文字1
    UILabel *labelUp = [UILabel new];
    [self.view addSubview:labelUp];
    labelUp.text = @"EVA 24V";
    [labelUp setTextAlignment:NSTextAlignmentLeft];
    [labelUp setFont:[UIFont fontWithName:@"Arial" size:22.0]];
    labelUp.sd_layout
    .leftSpaceToView(self.view, 64.0/frameWidth*viewX)
    .topSpaceToView(self.view, 249.0/frameHeight*viewY)
    .widthIs(300.0/frameWidth*viewX)
    .heightIs(38.0/frameHeight*viewY);
    
    //中间文字下
    UILabel *labelDown = [UILabel new];
    [self.view addSubview:labelDown];
    labelDown.text = @"Truck Air Conditioner";
    [labelDown setTextAlignment:NSTextAlignmentLeft];
    [labelDown setFont:[UIFont fontWithName:@"Arial" size:22.0]];
    labelDown.sd_layout
    .leftSpaceToView(self.view, 64.0/frameWidth*viewX)
    .topSpaceToView(self.view, 295.0/frameHeight*viewY)
    .widthIs(600.0/frameWidth*viewX)
    .heightIs(38.0/frameHeight*viewY);
    
    
    /*
    
    //首页图片
    UIImageView *imageHome = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imagehome"]];
    [self.view addSubview:imageHome];
    imageHome.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 210.0/frameHeight*viewY)
    .widthIs(680.0/frameWidth*viewX)
    .heightIs(360.0/frameHeight*viewY);
    [imageHome setSd_cornerRadius:@10.0];
    */
    
    //一个水平视图
    UIView *view1 = [UIView new];
    [view1 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view1];
    view1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 918.0/frameHeight*viewY)
    .widthIs(682.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [view1 setSd_cornerRadius:@10.0];
    
    
    //风速
    UIImageView *imageSpeed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"speed1"]];
    [view1 addSubview:imageSpeed];
    imageSpeed.sd_layout
    .centerXEqualToView(view1)
    .widthIs(552.0/frameWidth*viewX)
    .topSpaceToView(view1, 82.0/frameHeight*viewY)
    .heightIs(56.0/frameHeight*viewY);
    
    
    //视图2
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view2];
    view2.sd_layout
    .leftEqualToView(view1)
    .topSpaceToView(self.view, 1102.0/frameHeight*viewY)
    .widthIs(462.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [view1 setSd_cornerRadius:@10.0];
    
    
    UIView *view3 = [UIView new];
    [view3 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view3];
    view3.sd_layout
    .rightEqualToView(view1)
    .topSpaceToView(self.view, 1102.0/frameHeight*viewY)
    .widthIs(208.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [view1 setSd_cornerRadius:@10.0];
    
    
    //电池
    UIButton *buttonBattry = [UIButton new];
    [buttonBattry setBackgroundImage:[UIImage imageNamed:@"battery"] forState:UIControlStateNormal];
    [view3 addSubview:buttonBattry];
    buttonBattry.sd_layout
    .centerXEqualToView(view3)
    .centerYEqualToView(view3)
    .widthIs(82.0/frameWidth*viewX)
    .heightEqualToWidth();
    
    
    /*
    
    
    //底部logo1
    UIImageView *imageLogo1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"germany"]];
    [self.view addSubview:imageLogo1];
    imageLogo1.sd_layout
    .leftSpaceToView(self.view, 116.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1440.0/frameHeight*viewY)
    .widthIs(154.0/frameWidth*viewX)
    .heightIs(84.0/frameHeight*viewY);
    
    //底部logo2
    UIImageView *imageLogo2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"instein"]];
    [self.view addSubview:imageLogo2];
    imageLogo2.sd_layout
    .rightSpaceToView(self.view, 116.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1440.0/frameHeight*viewY)
    .widthIs(154.0/frameWidth*viewX)
    .heightIs(84.0/frameHeight*viewY);
    
    UILabel *labelEva = [UILabel new];
    [self.view addSubview:labelEva];
    labelEva.text = @"www.evacool.com.tr";
    [labelEva setTextColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    [labelEva setTextAlignment:NSTextAlignmentCenter];
    [labelEva setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labelEva.sd_layout
    .centerXEqualToView(imageLogo1)
    .topSpaceToView(imageLogo1, 10.0/frameHeight*viewY)
    .widthIs(300.0/frameWidth*viewX)
    .heightIs(20.0/frameHeight*viewY);
    
    UILabel *labeleinstein = [UILabel new];
    [self.view addSubview:labeleinstein];
    labeleinstein.text = @"www.einsteinmobilehomes.de";
    [labeleinstein setTextColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    [labeleinstein setTextAlignment:NSTextAlignmentCenter];
    [labeleinstein setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labeleinstein.sd_layout
    .centerXEqualToView(imageLogo2)
    .topSpaceToView(imageLogo2, 10.0/frameHeight*viewY)
    .widthIs(400.0/frameWidth*viewX)
    .heightIs(20.0/frameHeight*viewY);
     */
    
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


