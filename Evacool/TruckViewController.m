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
   
    //左上文字1
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
    
    //左上文字2
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
    
    //开关
    UIButton *btPower = [UIButton new];
    [btPower setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.view addSubview:btPower];
    btPower.sd_layout
    .rightSpaceToView(self.view, 36.0/frameWidth*viewX)
    .topSpaceToView(self.view, 222.0/frameHeight*viewY)
    .widthIs(120.0/frameWidth*viewX)
    .heightEqualToWidth();
    
    //圆形背景
    UIView *view0 = [UIView new];
    [self.view addSubview:view0];
    [view0 setBackgroundColor:[UIColor whiteColor]];
    view0.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 472.0/frameHeight*viewY)
    .widthIs(380.0/frameWidth*viewX)
    .heightEqualToWidth();
    view0.layer.cornerRadius = view0.width * 0.5;
    view0.layer.masksToBounds = true;
    
    //实时温度
    UILabel *labelTemp= [UILabel new];
    [self.view addSubview:labelTemp];
    labelTemp.text = @"0°C";
    [labelTemp setTextAlignment:NSTextAlignmentCenter];
    [labelTemp setFont:[UIFont fontWithName:@"Arial" size:36.0]];
    labelTemp.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(view0)
    .widthIs(200.0/frameWidth*viewX)
    .heightIs(52.0/frameHeight*viewY);
    
    //状态
    UILabel *labelStatus= [UILabel new];
    [self.view addSubview:labelStatus];
    labelStatus.text = @"In Good Condition";
    [labelStatus setTextAlignment:NSTextAlignmentCenter];
    [labelStatus setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labelStatus.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(labelTemp, 30.0/frameHeight*viewY)
    .widthIs(600.0/frameWidth*viewX)
    .heightIs(12.0/frameHeight*viewY);
    
    //温度减
    UIButton *btTempMinus = [UIButton new];
    [self.view addSubview:btTempMinus];
    [btTempMinus setBackgroundImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    btTempMinus.sd_layout
    .leftSpaceToView(self.view, 210.0/frameWidth*viewX)
    .bottomEqualToView(labelTemp)
    .widthIs(54.0/frameWidth*viewX)
    .heightEqualToWidth();
    
    
    //温度加
    UIButton *btTempAdd = [UIButton new];
    [btTempAdd setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.view addSubview:btTempAdd];
    btTempAdd.sd_layout
    .rightSpaceToView(self.view, 210.0/frameWidth*viewX)
    .bottomEqualToView(labelTemp)
    .widthIs(54.0/frameWidth*viewX)
    .heightEqualToWidth();
    
    
#pragma mark 显示风速
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
    
    UILabel *labelscale = [UILabel new];
    [view1 addSubview:labelscale];
    labelscale.text = @"1-5";
    [labelscale setTextAlignment:NSTextAlignmentLeft];
    [labelscale setTextColor:[UIColor grayColor]];
    [labelscale setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labelscale.sd_layout
    .leftSpaceToView(view1, 74.0/frameWidth*viewX)
    .topSpaceToView(view1, 32.0/frameHeight*viewY)
    .widthIs(100.0/frameWidth*viewX)
    .heightIs(30.0/frameHeight*viewY);
    
    //风速1
    UIImageView *imgfan1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d1"]];
    [view1 addSubview:imgfan1];
    imgfan1.sd_layout
    .leftSpaceToView(view1, 64.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(92.0/frameWidth*viewX)
    .heightIs(16.0/frameHeight*viewY);
    
    //风速2
    UIImageView *imgfan2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d2"]];
    [view1 addSubview:imgfan2];
    imgfan2.sd_layout
    .leftSpaceToView(view1, 178.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(92.0/frameWidth*viewX)
    .heightIs(26.0/frameHeight*viewY);
    
    //风速3
    UIImageView *imgfan3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d3"]];
    [view1 addSubview:imgfan3];
    imgfan3.sd_layout
    .leftSpaceToView(view1, 294.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(92.0/frameWidth*viewX)
    .heightIs(36.0/frameHeight*viewY);
    
    //风速4
    UIImageView *imgfan4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d4"]];
    [view1 addSubview:imgfan4];
    imgfan4.sd_layout
    .leftSpaceToView(view1, 410.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(92.0/frameWidth*viewX)
    .heightIs(46.0/frameHeight*viewY);
    
    //风速5
    UIImageView *imgfan5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d5"]];
    [view1 addSubview:imgfan5];
    imgfan5.sd_layout
    .leftSpaceToView(view1, 524.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(92.0/frameWidth*viewX)
    .heightIs(56.0/frameHeight*viewY);
    
#pragma mark 显示睡眠定时
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
    
    UILabel *labelsleep= [UILabel new];
    [view2 addSubview:labelsleep];
    labelsleep.text = @"0.5-10h";
    [labelsleep setTextAlignment:NSTextAlignmentLeft];
    [labelsleep setTextColor:[UIColor grayColor]];
    [labelsleep setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labelsleep.sd_layout
    .leftSpaceToView(view2, 74.0/frameWidth*viewX)
    .topSpaceToView(view2, 32.0/frameHeight*viewY)
    .widthIs(100.0/frameWidth*viewX)
    .heightIs(30.0/frameHeight*viewY);
    
    //开关
    UISwitch *switchSleep = [UISwitch new];
    [view2 addSubview:switchSleep];
    switchSleep.sd_layout
    .rightSpaceToView(view2, 22.0/frameWidth*viewX)
    .topSpaceToView(view2, 22.0/frameHeight*viewY)
    .widthIs(94.0/frameWidth*viewX)
    .heightIs(36.0/frameHeight*viewY);
    
    //定时量
    UILabel *labelTimer= [UILabel new];
    [view2 addSubview:labelTimer];
    labelTimer.text = @"0.5h";
    [labelTimer setTextAlignment:NSTextAlignmentLeft];
    [labelTimer setFont:[UIFont fontWithName:@"Arial" size:20.0]];
    [labelTimer setTextAlignment:NSTextAlignmentCenter];
    labelTimer.sd_layout
    .centerXEqualToView(view2)
    .widthIs(100.0/frameWidth*viewX)
    .heightIs(40.0/frameHeight*viewY)
    .bottomSpaceToView(view2, 34.0/frameHeight*viewY);
    
    //定时减
    UIButton *btTimeMinus = [UIButton new];
    [btTimeMinus setBackgroundImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [view2 addSubview:btTimeMinus];
    btTimeMinus.sd_layout
    .leftSpaceToView(view2, 98.0/frameWidth*viewX)
    .centerYEqualToView(labelTimer)
    .widthIs(42.0/frameWidth*viewX)
    .heightEqualToWidth();
    
    
    //定时加
    UIButton *btTimeAdd = [UIButton new];
    [btTimeAdd setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [view2 addSubview:btTimeAdd];
    btTimeAdd.sd_layout
    .rightSpaceToView(view2, 98.0/frameWidth*viewX)
    .centerYEqualToView(labelTimer)
    .widthIs(42.0/frameWidth*viewX)
    .heightEqualToWidth();
    
    
    
#pragma  mark 显示电池
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
    [buttonBattry setBackgroundImage:[UIImage imageNamed:@"batteryoff"] forState:UIControlStateNormal];
    [view3 addSubview:buttonBattry];
    buttonBattry.sd_layout
    .centerXEqualToView(view3)
    .centerYEqualToView(view3)
    .widthIs(82.0/frameWidth*viewX)
    .heightEqualToWidth();
    
    //风量
    UIButton *btFan = [UIButton new];
    [self.view addSubview:btFan];
    [btFan setBackgroundImage:[UIImage imageNamed:@"fanoff"] forState:UIControlStateNormal];
    btFan.sd_layout
    .leftSpaceToView(self.view, 44.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1304.0/frameHeight*viewY)
    .widthIs(122.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    
    //节能
    UIButton *btEco = [UIButton new];
    [self.view addSubview:btEco];
    [btEco setBackgroundImage:[UIImage imageNamed:@"ecooff"] forState:UIControlStateNormal];
    btEco.sd_layout
    .leftSpaceToView(self.view, 222.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1304.0/frameHeight*viewY)
    .widthIs(122.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    
    //普通模式
    UIButton *btNormal = [UIButton new];
    [self.view addSubview:btNormal];
    [btNormal setBackgroundImage:[UIImage imageNamed:@"cooloff"] forState:UIControlStateNormal];
    btNormal.sd_layout
    .leftSpaceToView(self.view, 402.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1304.0/frameHeight*viewY)
    .widthIs(122.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    
    //加强模式
    UIButton *btTurbo = [UIButton new];
    [self.view addSubview:btTurbo];
    [btTurbo setBackgroundImage:[UIImage imageNamed:@"turbooff"] forState:UIControlStateNormal];
    btTurbo.sd_layout
    .rightSpaceToView(self.view, 44.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1304.0/frameHeight*viewY)
    .widthIs(122.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    
    //底部左边按钮
    UIButton *buttonDetails = [UIButton new];
    [buttonDetails setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    [buttonDetails setTitle:@"Details" forState:UIControlStateNormal];
    [self.view addSubview:buttonDetails];
    buttonDetails.sd_layout
    .leftSpaceToView(self.view, 124.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1508.0/frameHeight*viewY)
    .widthIs(226.0/frameWidth*viewX)
    .heightIs(70.0/frameHeight*viewY);
    [buttonDetails setSd_cornerRadius:@12.0];
    
    //底部左边按钮
    UIButton *buttonFaults = [UIButton new];
    [buttonFaults setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    [buttonFaults setTitle:@"Faults Record" forState:UIControlStateNormal];
    [self.view addSubview:buttonFaults];
    buttonFaults.sd_layout
    .rightSpaceToView(self.view, 124.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1508.0/frameHeight*viewY)
    .widthIs(226.0/frameWidth*viewX)
    .heightIs(70.0/frameHeight*viewY);
    [buttonFaults setSd_cornerRadius:@12.0];
    
    
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


