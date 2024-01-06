//
//  RoomViewcontrollerViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/5.
//

#import "RoomViewController.h"
#import "BabyBluetooth.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"
#import "SemiCircleProgressView.h"
#import "crc.h"
#import "detailViewController.h"
#import "faultsViewController.h"

@interface RoomViewController ()
@property (nonatomic,retain) MBProgressHUD *hud;
@property (nonatomic,retain) UILabel *labelUp;
@property (nonatomic,retain) UILabel *labelTemp;
@property (nonatomic,retain) UILabel *labelStatus;
@property (nonatomic,retain) SemiCircleProgressView *progress;
@property (nonatomic,retain) UIImageView *imgfan1;
@property (nonatomic,retain) UIImageView *imgfan2;
@property (nonatomic,retain) UIImageView *imgfan3;
@property (nonatomic,retain) UIImageView *imgfan4;
@property (nonatomic,retain) UIImageView *imgfan5;
@property (nonatomic,retain) UIButton *btswitchfan;
@property (nonatomic,retain) UILabel *labelTimer;
@property (nonatomic,retain) UISwitch *switchCount;
@property (nonatomic,retain) UIButton *btauto;
@property (nonatomic,retain) UIButton *btcool;
@property (nonatomic,retain) UIButton *bthuimit;
@property (nonatomic,retain) UIButton *btvent;
@property (nonatomic,retain) UIButton *btheat;
@property (nonatomic,retain) UIButton *btTurbo;
@property (nonatomic,retain) UIButton *btSleep;
@property (nonatomic,retain) UIButton *btLight;
@end

@implementation RoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutoLayout];
    self.dataRead = [[DataReadR alloc] init];
    baby = [BabyBluetooth shareBabyBluetooth];
    [self babyDelegate];
}


-(void) viewDidAppear:(BOOL)animated{
    self.labelUp.text = self.brand;
    [self getStatus];
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
    self.labelUp = [UILabel new];
    [self.view addSubview: self.labelUp];
    self.labelUp.text = @"Eva 2700 RV";
    [ self.labelUp setTextAlignment:NSTextAlignmentLeft];
    [ self.labelUp setTextColor:[UIColor blackColor]];
    [ self.labelUp setFont:[UIFont fontWithName:@"Arial" size:22.0]];
    self.labelUp.sd_layout
    .leftSpaceToView(self.view, 64.0/frameWidth*viewX)
    .topSpaceToView(self.view, 249.0/frameHeight*viewY)
    .widthIs(600.0/frameWidth*viewX)
    .heightIs(44.0/frameHeight*viewY);
    
    //左上文字2
    UILabel *labelDown = [UILabel new];
    [self.view addSubview:labelDown];
    labelDown.text = @"RV Air Conditioner";
    [labelDown setTextAlignment:NSTextAlignmentLeft];
    [labelDown setTextColor:[UIColor blackColor]];
    [labelDown setFont:[UIFont fontWithName:@"Arial" size:22.0]];
    labelDown.sd_layout
    .leftSpaceToView(self.view, 64.0/frameWidth*viewX)
    .topSpaceToView(self.view, 295.0/frameHeight*viewY)
    .widthIs(600.0/frameWidth*viewX)
    .heightIs(44.0/frameHeight*viewY);
    
    //开关
    UIButton *btPower = [UIButton new];
    [btPower setBackgroundImage:[UIImage imageNamed:@"power"] forState:UIControlStateNormal];
    [self.view addSubview:btPower];
    btPower.sd_layout
    .rightSpaceToView(self.view, 36.0/frameWidth*viewX)
    .topSpaceToView(self.view, 222.0/frameHeight*viewY)
    .widthIs(120.0/frameWidth*viewX)
    .heightEqualToWidth();
    [btPower addTarget:self action:@selector(powerswitch) forControlEvents:UIControlEventTouchUpInside];
    
    //弧形进度条
    self.progress = [[SemiCircleProgressView alloc] initWithFrame:CGRectMake(150/frameWidth*viewX, 425.0/frameHeight*viewY, 450/frameWidth*viewX, 450.0/frameWidth*viewX)];
    [self.view addSubview:self.progress];
    self.progress.percent = 0.25;
     
    //圆形背景
    UIView *view0 = [UIView new];
    [self.view addSubview:view0];
    [view0 setBackgroundColor:[UIColor whiteColor]];
    view0.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 462.0/frameHeight*viewY)
    .widthIs(380.0/frameWidth*viewX)

    .heightEqualToWidth();
    view0.layer.cornerRadius = view0.width * 0.5;
    view0.layer.masksToBounds = true;
    
    
    //实时温度
    self.labelTemp= [UILabel new];
    [self.view addSubview:self.labelTemp];
    self.labelTemp.text = @"0°C";
    [self.labelTemp setTextAlignment:NSTextAlignmentCenter];
    [self.labelTemp setTextColor:[UIColor blackColor]];
    [self.labelTemp setFont:[UIFont fontWithName:@"Arial" size:36.0]];
    self.labelTemp.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(view0)
    .widthIs(200.0/frameWidth*viewX)
    .heightIs(72.0/frameHeight*viewY);
    
    //状态
    self.labelStatus= [UILabel new];
    [self.view addSubview:self.labelStatus];
    self.labelStatus.text = @"In Good Condition";
    [self.labelStatus setTextAlignment:NSTextAlignmentCenter];
    [self.labelStatus setTextColor:[UIColor blackColor]];
    [self.labelStatus setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    self.labelStatus.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.labelTemp, 30.0/frameHeight*viewY)
    .widthIs(600.0/frameWidth*viewX)
    .heightIs(24.0/frameHeight*viewY);
     
    //温度减
    UIButton *btTempMinus = [UIButton new];
    [self.view addSubview:btTempMinus];
    [btTempMinus setBackgroundImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    btTempMinus.sd_layout
    .leftSpaceToView(self.view, 210.0/frameWidth*viewX)
    .bottomEqualToView(self.labelTemp)
    .widthIs(54.0/frameWidth*viewX)
    .heightEqualToWidth();
    [btTempMinus addTarget:self action:@selector(subtemp) forControlEvents:UIControlEventTouchUpInside];
    
    
    //温度加
    UIButton *btTempAdd = [UIButton new];
    [btTempAdd setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.view addSubview:btTempAdd];
    btTempAdd.sd_layout
    .rightSpaceToView(self.view, 210.0/frameWidth*viewX)
    .bottomEqualToView(self.labelTemp)
    .widthIs(54.0/frameWidth*viewX)
    .heightEqualToWidth();
    [btTempAdd addTarget:self action:@selector(addtemp) forControlEvents:UIControlEventTouchUpInside];
    
    
#pragma mark 显示风速
    //一个水平视图
    UIView *view1 = [UIView new];
    [view1 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view1];
    view1.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 898.0/frameHeight*viewY)
    .widthIs(682.0/frameWidth*viewX)
    .heightIs(132.0/frameHeight*viewY);
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
    self.imgfan1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d1"]];
    [view1 addSubview: self.imgfan1];
    self.imgfan1.sd_layout
    .leftSpaceToView(view1, 64.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(76.0/frameWidth*viewX)
    .heightIs(16.0/frameHeight*viewY);
    
    //风速2
    self.imgfan2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d2"]];
    [view1 addSubview:self.imgfan2];
    self.imgfan2.sd_layout
    .leftSpaceToView(view1, 160.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(76.0/frameWidth*viewX)
    .heightIs(26.0/frameHeight*viewY);
    
    //风速3
    self.imgfan3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d3"]];
    [view1 addSubview:self.imgfan3];
    self.imgfan3.sd_layout
    .leftSpaceToView(view1, 256.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(76.0/frameWidth*viewX)
    .heightIs(36.0/frameHeight*viewY);
    
    //风速4
    self.imgfan4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d4"]];
    [view1 addSubview:self.imgfan4];
    self.imgfan4.sd_layout
    .leftSpaceToView(view1, 352.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(76.0/frameWidth*viewX)
    .heightIs(46.0/frameHeight*viewY);
    
    //风速5
    self.imgfan5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d5"]];
    [view1 addSubview:self.imgfan5 ];
    self.imgfan5 .sd_layout
    .leftSpaceToView(view1, 448.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(76.0/frameWidth*viewX)
    .heightIs(56.0/frameHeight*viewY);
    
    //切换
    self.btswitchfan = [UIButton new];
    [view1 addSubview:self.btswitchfan ];
    [self.btswitchfan setBackgroundImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
    self.btswitchfan.sd_layout
    .leftSpaceToView(view1, 544.0/frameWidth*viewX)
    .bottomSpaceToView(view1, 40.0/frameHeight*viewY)
    .widthIs(76.0/frameWidth*viewX)
    .heightEqualToWidth();
    [self.btswitchfan addTarget:self action:@selector(chgfan) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark 模式切换
    
    //自动模式
    self.btauto = [UIButton new];
    [self.view addSubview:self.btauto];
    [self.btauto setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    self.btauto.sd_layout
    .leftSpaceToView(self.view, 44.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1048.0/frameHeight*viewY)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    [self.btauto addTarget:self action:@selector(chgmod:) forControlEvents:UIControlEventTouchUpInside];
   
    //制冷
    self.btcool = [UIButton new];
    [self.view addSubview:self.btcool];
    [self.btcool setBackgroundImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    self.btcool.sd_layout
    .leftSpaceToView(self.view, 174.0/frameWidth*viewX)
    .topEqualToView(self.btauto)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    [self.btcool addTarget:self action:@selector(chgmod:) forControlEvents:UIControlEventTouchUpInside];
    
    //除湿
    self.bthuimit = [UIButton new];
    [self.view addSubview:self.bthuimit];
    [self.bthuimit setBackgroundImage:[UIImage imageNamed:@"7"] forState:UIControlStateNormal];
    self.bthuimit.sd_layout
    .leftSpaceToView(self.view, 304.0/frameWidth*viewX)
    .topEqualToView(self.btauto)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    [self.bthuimit addTarget:self action:@selector(chgmod:) forControlEvents:UIControlEventTouchUpInside];
    
    //通风
    self.btvent = [UIButton new];
    [self.view addSubview:self.btvent];
    [self.btvent setBackgroundImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    self.btvent.sd_layout
    .leftSpaceToView(self.view, 434.0/frameWidth*viewX)
    .topEqualToView(self.btauto)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    [self.btvent addTarget:self action:@selector(chgmod:) forControlEvents:UIControlEventTouchUpInside];
    
    //加热
    self.btheat = [UIButton new];
    [self.view addSubview:self.btheat];
    [self.btheat setBackgroundImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
    self.btheat.sd_layout
    .leftSpaceToView(self.view, 564.0/frameWidth*viewX)
    .topEqualToView(self.btauto)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    [self.btheat addTarget:self action:@selector(chgmod:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark 显示睡眠定时
    //视图2
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view2];
    view2.sd_layout
    .leftEqualToView(view1)
    .topSpaceToView(self.view, 1216.0/frameHeight*viewY)
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
    
    //倒计时开关
    self.switchCount = [UISwitch new];
    [view2 addSubview:self.switchCount];
    self.switchCount.sd_layout
    .rightSpaceToView(view2, 22.0/frameWidth*viewX)
    .topSpaceToView(view2, 22.0/frameHeight*viewY)
    .widthIs(94.0/frameWidth*viewX)
    .heightIs(36.0/frameHeight*viewY);
    [self.switchCount addTarget:self action:@selector(setCount:) forControlEvents:UIControlEventValueChanged];
    
    //定时量
    self.labelTimer= [UILabel new];
    [view2 addSubview:self.labelTimer];
    self.labelTimer.text = @"0.0h";
    [self.labelTimer setTextAlignment:NSTextAlignmentLeft];
    [self.labelTimer setTextColor:[UIColor blackColor]];
    [self.labelTimer setFont:[UIFont fontWithName:@"Arial" size:20.0]];
    [self.labelTimer setTextAlignment:NSTextAlignmentCenter];
    self.labelTimer.sd_layout
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
    .centerYEqualToView(self.labelTimer)
    .widthIs(42.0/frameWidth*viewX)
    .heightEqualToWidth();
    [btTimeMinus addTarget:self action:@selector(droptimer) forControlEvents:UIControlEventTouchUpInside];
    
    
    //定时加
    UIButton *btTimeAdd = [UIButton new];
    [btTimeAdd setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [view2 addSubview:btTimeAdd];
    btTimeAdd.sd_layout
    .rightSpaceToView(view2, 98.0/frameWidth*viewX)
    .centerYEqualToView(self.labelTimer)
    .widthIs(42.0/frameWidth*viewX)
    .heightEqualToWidth();
    [btTimeAdd addTarget:self action:@selector(addtimer) forControlEvents:UIControlEventTouchUpInside];
    
    
#pragma  mark  温度切换
    UIView *view3 = [UIView new];
    [view3 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view3];
    view3.sd_layout
    .rightEqualToView(view1)
    .topSpaceToView(self.view, 1216.0/frameHeight*viewY)
    .widthIs(208.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [view1 setSd_cornerRadius:@10.0];
    
    //温度单位
    UILabel *labelUnit= [UILabel new];
    [view3 addSubview:labelUnit];
    labelUnit.text = @"°C/°F";
    [labelUnit setTextAlignment:NSTextAlignmentLeft];
    [labelUnit setTextColor:[UIColor blackColor]];
    [labelUnit setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    [labelUnit setTextAlignment:NSTextAlignmentCenter];
    labelUnit.sd_layout
    .centerXEqualToView(view3)
    .widthIs(300/frameWidth*viewX)
    .heightIs(24.0/frameHeight*viewY)
    .topSpaceToView(view3, 20.0/frameHeight*viewY);
    
    //温度单位切换按钮
    UISwitch *swtUnit = [UISwitch new];
    [view3 addSubview:swtUnit];
    swtUnit.sd_layout
    .centerXEqualToView(view3)
    .bottomSpaceToView(view3, 30.0/frameHeight*viewY)
    .widthIs(82.0/frameWidth*viewX)
    .heightIs(10.0/frameHeight*viewY);
    [swtUnit addTarget:self action:@selector(chgunit) forControlEvents:UIControlEventTouchUpInside];

     
    //底部左边turbo
    self.btTurbo = [UIButton new];
    [self.btTurbo setImage:[UIImage imageNamed:@"16"] forState:UIControlStateNormal];
    [self.view addSubview:self.btTurbo];
    self.btTurbo.sd_layout
    .leftEqualToView(view1)
    .topSpaceToView(self.view, 1400.0/frameHeight*viewY)
    .widthIs(226.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [self.btTurbo setSd_cornerRadius:@12.0];
    [self.btTurbo addTarget:self action:@selector(setturbo) forControlEvents:UIControlEventTouchUpInside];
     
    //底部中间 sleep
    self.btSleep = [UIButton new];
    [self.btSleep setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
    [self.view addSubview:self.btSleep];
    self.btSleep.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 1400.0/frameHeight*viewY)
    .widthIs(226.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [self.btSleep setSd_cornerRadius:@12.0];
    [self.btSleep addTarget:self action:@selector(setsleep) forControlEvents:UIControlEventTouchUpInside];

    //底部左边右边
    self.btLight = [UIButton new];
    [self.btLight setImage:[UIImage imageNamed:@"20"] forState:UIControlStateNormal];
    [self.view addSubview:self.btLight];
    self.btLight.sd_layout
    .rightEqualToView(view1)
    .topSpaceToView(self.view, 1400.0/frameHeight*viewY)
    .widthIs(226.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [self.btLight setSd_cornerRadius:@12.0];
    [self.btLight addTarget:self action:@selector(setlight) forControlEvents:UIControlEventTouchUpInside];
     

}

#pragma mark babyDelegate
-(void)babyDelegate{
    __weak typeof(self) weakSelf = self;
    //设置扫描到设备的委托

   
    //设置断开设备的委托
    [baby setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        weakSelf.hud.mode = MBProgressHUDModeIndeterminate;
        weakSelf.hud.label.text = @"Disconnet devices";
        [weakSelf.hud setMinShowTime:1];
        [weakSelf.hud showAnimated:YES];
    }];
    
   
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
     //   NSLog(@"read characteristic successfully!");
        weakSelf.labelUp.text = peripheral.name;
        if([characteristics.UUID.UUIDString isEqualToString:@"FFE1"]){
            weakSelf.characteristic = characteristics;
            NSData *data = characteristics.value;
            Byte r[23] = {0};
            if(data.length == 23){
                memcpy(r, [data bytes], 23);
                // NSLog(@"copy data successfully!");
                weakSelf.dataRead.start = r[0]; //通讯开始
                weakSelf.dataRead.power = r[1]; //0x01开机，0x00关机
                weakSelf.dataRead.tempSetting = r[2];  //设定温度
                weakSelf.dataRead.tempReal = r[3];  //实时温度
                weakSelf.dataRead.mode = r[4];  //工作模式
                weakSelf.dataRead.wind = r[5];  //风速档位 0-自动 1-4 是手动风速
                weakSelf.dataRead.turbo = r[6];  //强冷模式开关
                weakSelf.dataRead.sleep = r[7];  //睡眠模式开关
                weakSelf.dataRead.unit = r[8];   //温度单位 0-摄氏度 1-华氏度
                weakSelf.dataRead.countdown = r[9];  //倒计时关机时间
                weakSelf.dataRead.logo = r[10];  //LOGO 灯开关
                weakSelf.dataRead.atmosphere = r[11];  //氛围灯模式或氛围灯变化时间
                weakSelf.dataRead.red = r[12];   //R(红色数据值)
                weakSelf.dataRead.green = r[13];  //G(绿色数值)
                weakSelf.dataRead.blue = r[14];   //B(蓝色数值)
                weakSelf.dataRead.brightness = r[15];  //氛围灯亮度
                weakSelf.dataRead.errcode = r[16];  //故障代码
                weakSelf.dataRead.version = r[17];  //空调版本 0-国内版 1-国外版
                weakSelf.dataRead.reserve1 = r[18];  //备用
                weakSelf.dataRead.reserve2 = r[19];  //备用
                weakSelf.dataRead.crcH = r[20];  //CRC 校验高八位
                weakSelf.dataRead.crcL = r[21];  //CRC 校验高八位
                weakSelf.dataRead.end = r[22];  //通讯结束
                [weakSelf updateStatus];
            }
        }
    }];
    
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@NO};
}


-(void) getStatus{
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x01;
        write[2] = 0x00;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
       // [self updateStatus];
    }
}

//开关
-(void) powerswitch{
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x10;
        if(self.dataRead.power == 0x00){
            write[2] = 0x01;
            [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        }else{
            write[2] = 0x00;
        }
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
       // [self updateStatus];
    }
}

//温度减
-(void) subtemp{
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x11;
        write[2] = self.dataRead.tempSetting - 1;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
       // [self updateStatus];
    }
}

//温度增加
-(void) addtemp{
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x11;
        write[2] = self.dataRead.tempSetting + 1;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
       // [self updateStatus];
    }
}

//改变风速
-(void)chgfan{
    if(self.characteristic != nil && self.dataRead.mode==0x04 ){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x12;
      //  if(self.dataRead.mode!=4){
            write[2] = (self.dataRead.wind+1)%5;
      //  }else{
    //     write[2] = 0;
      //  }
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
       // [self updateStatus];
    }
}

-(void) chgmod:(id)sender{
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x13;
        
        if(sender == self.btauto){
            write[2] = 0x04;
        }else if(sender == self.btcool){
            write[2] = 0x00;
        }else if(sender == self.bthuimit){
            write[2] = 0x01;
        }else if(sender == self.btvent){
            write[2] = 0x02;
        }else {
            write[2] = 0x03;
        }
        
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
       // [self updateStatus];
        [self.btauto setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        [self.btcool setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
        [self.bthuimit setImage:[UIImage imageNamed:@"7"] forState:UIControlStateNormal];
        [self.btvent setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
        [self.btheat setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
    }
}
//切换单位
-(void)chgunit{
    Byte  write[6];
    write[0] = 0xAA;
    write[1] = 0x17;
    write[2] = self.dataRead.unit;
    write[4] = 0xFF & CalcCRC(&write[1], 2);
    write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
    write[5] = 0x55;
    
    NSData *data = [[NSData alloc]initWithBytes:write length:6];
    [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
 //   self.labelTimer.text = [NSString stringWithFormat:@"%.1fh",self.sleeplevel*0.5];
    
}

//设置睡眠时间
-(void)setCount:(id)sender{
    UISwitch *swc = (UISwitch * )sender;
    if(swc.isOn == NO){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x16;
        write[2] = 0x05;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
     //   self.sleeplevel = 1;
        self.labelTimer.text = @"0.5h";
    }else{
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x16;
        write[2] = 0x00;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        self.labelTimer.text = @"0.0h";
    }
}

//睡眠定时减
-(void)droptimer{
    if(self.dataRead.sleep>5 && self.switchCount.isOn){

        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x0B;
        write[2] = self.dataRead.countdown -5;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
    }
}

//睡眠定时加
-(void)addtimer{
    if(self.dataRead.sleep<115 && self.switchCount.isOn){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x16;
        write[2] = self.dataRead.countdown + 5;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
      //  self.labelTimer.text = [NSString stringWithFormat:@"%.1fh",self.sleeplevel*0.5];
    }
}

//设置超强模式
-(void)setturbo{
    Byte  write[6];
    write[0] = 0xAA;
    write[1] = 0x14;
    write[2] = (self.dataRead.turbo+1)%2;
    write[4] = 0xFF & CalcCRC(&write[1], 2);
    write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
    write[5] = 0x55;
    
    NSData *data = [[NSData alloc]initWithBytes:write length:6];
    [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
}



//设置安静模式
-(void) setsleep{
    Byte  write[6];
    write[0] = 0xAA;
    write[1] = 0x15;
    write[2] = (self.dataRead.sleep+1)%2;
    write[4] = 0xFF & CalcCRC(&write[1], 2);
    write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
    write[5] = 0x55;
    
    NSData *data = [[NSData alloc]initWithBytes:write length:6];
    [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
    
    [NSThread sleepForTimeInterval:0.1];
    
    //温度设为26度
    if(self.dataRead.sleep == 0x00 ){
        write[0] = 0xAA;
        write[1] = 0x11;
        write[2] = 0x1A;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
    }
}

//设置灯光
-(void) setlight{
    Byte  write[6];
    write[0] = 0xAA;
    write[1] = 0x18;
    write[2] = (self.dataRead.logo +1)%2;
    write[4] = 0xFF & CalcCRC(&write[1], 2);
    write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
    write[5] = 0x55;
    
    NSData *data = [[NSData alloc]initWithBytes:write length:6];
    [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
    
}



//更新控件
-(void) updateStatus{
    
    //温度
    
    if(self.dataRead.unit == 0x01){
        self.labelTemp.text = [NSString stringWithFormat:@"%d°C",self.dataRead.tempSetting];
    }else{
        self.labelTemp.text = [NSString stringWithFormat:@"%d°F",self.dataRead.tempSetting];
    }
    
    self.progress.percent = (self.dataRead.tempSetting - 15)/15.0;
    [self.progress setNeedsDisplay];
    
    //风量
    [self.imgfan1 setImage:[UIImage imageNamed:@"d1"]];
    [self.imgfan2 setImage:[UIImage imageNamed:@"d3"]];
    [self.imgfan3 setImage:[UIImage imageNamed:@"d3"]];
    [self.imgfan4 setImage:[UIImage imageNamed:@"d4"]];
    [self.imgfan5 setImage:[UIImage imageNamed:@"d5"]];
    
    switch(self.dataRead.wind){
        case 0x00: [self.imgfan1 setImage:[UIImage imageNamed:@"f1"]];break;
        case 0x01: [self.imgfan2 setImage:[UIImage imageNamed:@"f2"]];break;
        case 0x02: [self.imgfan3 setImage:[UIImage imageNamed:@"f3"]];break;
        case 0x03: [self.imgfan4 setImage:[UIImage imageNamed:@"f4"]];break;
        case 0x04: [self.imgfan5 setImage:[UIImage imageNamed:@"f5"]];break;
    }

    //模式
    
    switch (self.dataRead.mode) {
        case 0:
            [self.btcool setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];break;
        case 1:
            [self.bthuimit setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];break;
        case 002:
            [self.btvent setImage:[UIImage imageNamed:@"8"] forState:UIControlStateNormal];break;
        case 003:
            [self.btheat setImage:[UIImage imageNamed:@"10"] forState:UIControlStateNormal];break;
        case 004:
            [self.btauto setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];break;
        default:
            break;
    }
    
    //定时显示
    
    
    //超强模式显示
    if(self.dataRead.turbo == 0x01){
        [self.btTurbo setImage:[UIImage imageNamed:@"17"] forState:UIControlStateNormal];
    }else{
        [self.btTurbo setImage:[UIImage imageNamed:@"16"] forState:UIControlStateNormal];
    }
    
    //睡眠模式显示
    if(self.dataRead.sleep == 0x01){
        [self.btSleep setImage:[UIImage imageNamed:@"19"] forState:UIControlStateNormal];
    }else{
        [self.btSleep setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
    }
    
    if(self.dataRead.logo == 0x01){
        [self.btLight setImage:[UIImage imageNamed:@"21"] forState:UIControlStateNormal];
    }else{
        [self.btLight setImage:[UIImage imageNamed:@"20"] forState:UIControlStateNormal];
    }
    
    //故障
    if(self.dataRead.errcode == 0x00){
        self.labelStatus.text = @"In Good Condition";
        [self.labelStatus setTextColor:[UIColor blackColor]];
    }else{
        self.labelStatus.text = [NSString stringWithFormat:@"Fault Code:E%d",self.dataRead.errcode];
        [self.labelStatus setTextColor:[UIColor redColor]];
    }

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


