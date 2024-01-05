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
@property (nonatomic,retain) UISwitch *switchSleep;
@property (nonatomic,retain) UIImageView *imgfan;
@property (nonatomic,retain) UIImageView *imgeco;
@property (nonatomic,retain) UIImageView *imgnormal;
@property (nonatomic,retain) UIImageView *imgturbo;
@property (nonatomic,retain) UIButton *btswitchmode;
@property (nonatomic,retain) UIView *viewMusk;
@property (nonatomic,retain) UIView *viewDetails;
@property (nonatomic,retain) UIView*viewFault;
@property (nonatomic,retain) UIView *batteryprotect;
@property Byte sleeplevel; //睡眠定时级别
@property (nonatomic,strong) NSMutableArray *dataError;
@end

@implementation RoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutoLayout];
    [self.viewMusk setHidden:YES];
    self.dataRead = [[DataReadR alloc] init];
    self.dataError = [[NSMutableArray alloc]init];
    baby = [BabyBluetooth shareBabyBluetooth];
    [self babyDelegate];
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
    self.labelUp.text = @"EVA 24V";
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
    labelDown.text = @"Truck Air Conditioner";
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
    
    //通风
    self.imgfan = [UIImageView new];
    [self.view addSubview:self.imgfan];
    [self.imgfan setImage:[UIImage imageNamed:@"fanoff"]];
    self.imgfan.sd_layout
    .leftSpaceToView(self.view, 44.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1048.0/frameHeight*viewY)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
   
    
    //节能
    self.imgeco = [UIImageView new];
    [self.view addSubview:self.imgeco];
    [self.imgeco setImage:[UIImage imageNamed:@"ecooff"]];
    self.imgeco.sd_layout
    .leftSpaceToView(self.view, 174.0/frameWidth*viewX)
    .topEqualToView(self.imgfan)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
   
    
    //普通模式
    self.imgnormal = [UIImageView new];
    [self.view addSubview:self.imgnormal];
    [self.imgnormal setImage:[UIImage imageNamed:@"cooloff"]];
    self.imgnormal.sd_layout
    .leftSpaceToView(self.view, 304.0/frameWidth*viewX)
    .topEqualToView(self.imgfan)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    
    //加强模式
    self.imgturbo = [UIImageView new];
    [self.view addSubview:self.imgturbo];
    [self.imgturbo setImage:[UIImage imageNamed:@"turbooff"]];
    self.imgturbo.sd_layout
    .leftSpaceToView(self.view, 434.0/frameWidth*viewX)
    .topEqualToView(self.imgfan)
    .widthIs(108.0/frameWidth*viewX)
    .autoHeightRatio(142.0/122.0);
    
    //切换
    self.btswitchmode = [UIButton new];
    [self.view addSubview:self.btswitchmode ];
    [self.btswitchmode setBackgroundImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
    self.btswitchmode.sd_layout
    .leftSpaceToView(self.view, 564.0/frameWidth*viewX)
    .topEqualToView(self.imgfan)
    .widthIs(108.0/frameWidth*viewX)
    .heightEqualToWidth();
    [self.btswitchmode addTarget:self action:@selector(chgmod:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    //开关
    self.switchSleep = [UISwitch new];
    [view2 addSubview:self.switchSleep];
    self.switchSleep.sd_layout
    .rightSpaceToView(view2, 22.0/frameWidth*viewX)
    .topSpaceToView(view2, 22.0/frameHeight*viewY)
    .widthIs(94.0/frameWidth*viewX)
    .heightIs(36.0/frameHeight*viewY);
    [self.switchSleep addTarget:self action:@selector(setSleep:) forControlEvents:UIControlEventValueChanged];
    
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
    
    
#pragma  mark 显示电池
    UIView *view3 = [UIView new];
    [view3 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view3];
    view3.sd_layout
    .rightEqualToView(view1)
    .topSpaceToView(self.view, 1216.0/frameHeight*viewY)
    .widthIs(208.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [view1 setSd_cornerRadius:@10.0];
    
    //电池
    UIButton *btBattry = [UIButton new];
    [btBattry setBackgroundImage:[UIImage imageNamed:@"battery"] forState:UIControlStateNormal];
    [view3 addSubview:btBattry];
    btBattry.sd_layout
    .centerXEqualToView(view3)
    .centerYEqualToView(view3)
    .widthIs(82.0/frameWidth*viewX)
    .heightEqualToWidth();
    [btBattry addTarget:self action:@selector(openbattery) forControlEvents:UIControlEventTouchUpInside];
    
    //底部左边turbo
    UIButton *btTurbo = [UIButton new];
    [btTurbo setImage:[UIImage imageNamed:@"16"] forState:UIControlStateNormal];
    [self.view addSubview:btTurbo];
    btTurbo.sd_layout
    .leftEqualToView(view1)
    .topSpaceToView(self.view, 1400.0/frameHeight*viewY)
    .widthIs(226.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [btTurbo setSd_cornerRadius:@12.0];
    [btTurbo addTarget:self action:@selector(openfaults) forControlEvents:UIControlEventTouchUpInside];
     
    //底部中间 sleep
    UIButton *btSleep = [UIButton new];
    [btSleep setImage:[UIImage imageNamed:@"18"] forState:UIControlStateNormal];
    [self.view addSubview:btSleep];
    btSleep.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 1400.0/frameHeight*viewY)
    .widthIs(226.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [btSleep setSd_cornerRadius:@12.0];
    [btSleep addTarget:self action:@selector(openfaults) forControlEvents:UIControlEventTouchUpInside];

    //底部左边右边
    UIButton *btLight = [UIButton new];
    [btLight setImage:[UIImage imageNamed:@"20"] forState:UIControlStateNormal];
    [self.view addSubview:btLight];
    btLight.sd_layout
    .rightEqualToView(view1)
    .topSpaceToView(self.view, 1400.0/frameHeight*viewY)
    .widthIs(226.0/frameWidth*viewX)
    .heightIs(168.0/frameHeight*viewY);
    [btLight setSd_cornerRadius:@12.0];
    [btLight addTarget:self action:@selector(openfaults) forControlEvents:UIControlEventTouchUpInside];
     

}

#pragma  mark pickviewdelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *titleLabel = [[UILabel alloc] init];
    if([self.brand isEqual:@"EVA24"]){
        [titleLabel setText:[NSString stringWithFormat:@"%.1f",21.5+row*0.2]];
    }else{
        [titleLabel setText:[NSString stringWithFormat:@"%.1f",10.8+row*0.1]];
    }
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:16]];
    [titleLabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
    
    return titleLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40.0f;
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Byte  write[6];
    write[0] = 0xAA;
    write[1] = 0x08;
    write[2] = row;
    write[4] = 0xFF & CalcCRC(&write[1], 2);
    write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
    write[5] = 0x55;
    
    NSData *data = [[NSData alloc]initWithBytes:write length:6];
    [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
   // [self updateStatus];
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
        write[1] = 0x02;
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
        write[1] = 0x03;
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

//温度增加
-(void) addtemp{
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x03;
        write[2] = 0x01;
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
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x04;
        write[2] = 0x01;
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
        write[1] = 0x05;
        write[2] = 0x01;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
       // [self updateStatus];
    }
}

//设置睡眠时间
-(void)setSleep:(id)sender{
    UISwitch *swc = (UISwitch * )sender;
    if(swc.isOn == YES){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x0B;
        write[2] = 0x01;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        self.sleeplevel = 1;
        self.labelTimer.text = @"0.5h";
    }else{
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x0B;
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
    if(self.sleeplevel>1 && self.switchSleep.isOn){
        self.sleeplevel--;
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x0B;
        write[2] = self.sleeplevel;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        self.labelTimer.text = [NSString stringWithFormat:@"%.1fh",self.sleeplevel*0.5];
    }
}

//睡眠定时加
-(void)addtimer{
    if(self.sleeplevel<16 && self.switchSleep.isOn){
        self.sleeplevel++;
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x0B;
        write[2] = self.sleeplevel;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        self.labelTimer.text = [NSString stringWithFormat:@"%.1fh",self.sleeplevel*0.5];
    }
}


//更新控件
-(void) updateStatus{
    
    //温度
    self.labelTemp.text = [NSString stringWithFormat:@"%d°C",self.dataRead.tempSetting];
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
    [self.imgfan setImage:[UIImage imageNamed:@"fanoff"]];
    [self.imgeco setImage:[UIImage imageNamed:@"ecooff"]];
    [self.imgnormal setImage:[UIImage imageNamed:@"cooloff"]];
    [self.imgturbo setImage:[UIImage imageNamed:@"turbooff"]];

    switch(self.dataRead.mode){
        case 0x00:[self.imgeco setImage:[UIImage imageNamed:@"ecoon"]];break;
        case 0x01:[self.imgnormal setImage:[UIImage imageNamed:@"coolon"]];break;
        case 0x02:[self.imgfan setImage:[UIImage imageNamed:@"fanon"]];break;
        case 0x03:[self.imgturbo setImage:[UIImage imageNamed:@"turboon"]]; break;
    }

}

//页面跳转
-(void)pushViewController{
    
    if(self.tag == 0){
        detailViewController *detail = [[detailViewController alloc]init];
        [detail setModalPresentationStyle:UIModalPresentationFullScreen];
        detail.datacode = self.datacode;
        [self presentViewController:detail animated:YES completion:nil];
        
    }else{
        faultsViewController *faults = [[faultsViewController alloc]init];
        [faults setModalPresentationStyle:UIModalPresentationFullScreen];
        faults.datacode = self.datacode;
        [self presentViewController:faults animated:YES completion:nil];
    }
}


//获取详细参数
-(void) opendetails{
    self.tag = 0;
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x06;
        write[2] = 0x01;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
    }
}

//获取故障信息
-(void) openfaults{
    self.tag = 1;
    if(self.characteristic != nil){
        Byte  write[6];
        write[0] = 0xAA;
        write[1] = 0x07;
        write[2] = 0x01;
        write[4] = 0xFF & CalcCRC(&write[1], 2);
        write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
        write[5] = 0x55;
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
       // [self updateStatus];
    }
}


-(void) openbattery{
    [self.viewMusk setHidden:NO];
    [self.viewDetails removeFromSuperview];
    [self.viewMusk addSubview:self.batteryprotect];
}


-(void) confirm{
    [self.viewMusk setHidden:YES];
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

