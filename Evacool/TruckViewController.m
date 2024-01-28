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
#import "SemiCircleProgressView.h"
#import "crc.h"
#import "detailViewController.h"
#import "faultsViewController.h"
#import "RegistViewController.h"
#import "ProfileViewController.h"


@interface TruckViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,retain) MBProgressHUD *hud;
@property (nonatomic,retain) UILabel *labelUp;
@property (nonatomic,retain) UILabel *labelTemp;
@property (nonatomic,retain) UIImageView *imgdot;
@property (nonatomic,retain) UILabel *labelStatus;
@property (nonatomic,retain) SemiCircleProgressView *progress;
@property (nonatomic,retain) UIImageView *imgfan1;
@property (nonatomic,retain) UIImageView *imgfan2;
@property (nonatomic,retain) UIImageView *imgfan3;
@property (nonatomic,retain) UIImageView *imgfan4;
@property (nonatomic,retain) UIImageView *imgfan5;
@property (nonatomic,retain) UIButton *btswitchfan;
@property (nonatomic,retain) UILabel *labelTimer;
@property (nonatomic,retain) UIButton *switchSleep;
@property (nonatomic,retain) UIImageView *imgfan;
@property (nonatomic,retain) UIImageView *imgeco;
@property (nonatomic,retain) UIImageView *imgnormal;
@property (nonatomic,retain) UIImageView *imgturbo;
@property (nonatomic,retain) UIButton *btswitchmode;
@property (nonatomic,retain) UIView *viewMusk;
@property (nonatomic,retain) UIView *viewDetails;
@property (nonatomic,retain) UIView*viewFault;
@property (nonatomic,retain) UIView *batteryprotect;
@property (nonatomic,retain) UIButton *btBattery;
@property (nonatomic,retain) UIButton *buttonDetails;
@property (nonatomic,retain) UIButton *buttonFaults;


@property Byte batterylevel; //电池保护
@property Byte sleeplevel; //睡眠定时级别
@property Boolean sw;
@property (nonatomic,retain) NSMutableArray *dataErrors;
@property (nonatomic,retain) NSTimer *timer;
@end

@implementation TruckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAutoLayout];
    [self.viewMusk setHidden:YES];
    //self.datacode = [[dataCode alloc] init];
    self.dataRead = [[DataRead alloc] init];
    self.dataErrors = [[NSMutableArray alloc]init];
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
    
    
    UIImageView *imgback = [UIImageView new];
    [self.view addSubview:imgback];
    [imgback setImage:[UIImage imageNamed:@"btreturn"]];
    imgback.sd_layout
        .leftSpaceToView(self.view, 50.0/frameWidth*viewX)
        .centerYEqualToView(imageTop)
        .widthIs(20/frameWidth*viewX)
        .heightIs(40/frameHeight*viewY);
    
    //返回按钮
    UIButton *btBack = [UIButton new];
    [self.view addSubview:btBack];
    btBack.sd_layout
        .centerXEqualToView(imgback)
        .centerYEqualToView(imageTop)
        .widthIs(100/frameWidth*viewX)
        .heightIs(100/frameHeight*viewY);
    [btBack addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    
    //注册信息
    UIButton *btprofile = [UIButton new];
    [self.view addSubview:btprofile];
    [btprofile setImage:[UIImage imageNamed:@"back_mine"] forState:UIControlStateNormal];
    // [btBack setContentMode:UIViewContentModeScaleAspectFill];
    // [btBack setContentMode:UIViewContentModeScaleAspectFill];
    // [btBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //[btBack setcontentf]
    btprofile.sd_layout
        .rightSpaceToView(self.view, 50.0/frameWidth*viewX)
        .centerYEqualToView(imageTop)
        .widthIs(40/frameWidth*viewX)
        .heightIs(60/frameHeight*viewY);
    [btprofile addTarget:self action:@selector(searchSN) forControlEvents:UIControlEventTouchUpInside];
    
    
    //左上文字1
    self.labelUp = [UILabel new];
    [self.view addSubview: self.labelUp];
    if([self.brand isEqualToString:@"EVA24VTR"]){
        self.labelUp.text = @"EVA 24V";
    }else{
        self.labelUp.text = @"EVA 12V";
    }
    [self.labelUp setTextAlignment:NSTextAlignmentLeft];
    [self.labelUp setTextColor:[UIColor blackColor]];
    [self.labelUp setFont:[UIFont fontWithName:@"Arial" size:22.0]];
    self.labelUp.sd_layout
        .leftSpaceToView(self.view, 64.0/frameWidth*viewX)
        .topSpaceToView(self.view, 249.0/frameHeight*viewY)
    //.widthIs(600.0/frameWidth*viewX)
        .widthIs(self.view.width *0.5)
        .heightIs(44.0/frameHeight*viewY);
    [self.labelUp setAdjustsFontSizeToFitWidth:YES];
    
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
    //.widthIs(600.0/frameWidth*viewX)
        .widthIs(self.view.width *0.5)
        .heightIs(44.0/frameHeight*viewY);
    [labelDown setAdjustsFontSizeToFitWidth:YES];
    
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
    
    //绿色点
    self.imgdot = [UIImageView new];
    [self.imgdot setImage:[UIImage imageNamed:@"greendot"]];
    [self.view addSubview:self.imgdot];
    self.imgdot.sd_layout
        .centerYEqualToView(self.labelStatus)
        .leftSpaceToView(self.view, 230/frameWidth*viewX)
        .widthIs(20/frameWidth*viewX)
        .heightEqualToWidth();
    [self.imgdot setHidden:YES];
    
    
    //温度减
    UIButton *btTempMinus = [UIButton new];
    [self.view addSubview:btTempMinus];
    [btTempMinus setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
    btTempMinus.sd_layout
        .leftSpaceToView(self.view, 210.0/frameWidth*viewX)
        .bottomEqualToView(self.labelTemp)
        .widthIs(32.0/frameWidth*viewX)
        .heightIs(54.0/frameHeight*viewY);
    [btTempMinus addTarget:self action:@selector(subtemp) forControlEvents:UIControlEventTouchUpInside];
    
    
    //温度加
    UIButton *btTempAdd = [UIButton new];
    [btTempAdd setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
    [self.view addSubview:btTempAdd];
    btTempAdd.sd_layout
        .rightSpaceToView(self.view, 210.0/frameWidth*viewX)
        .bottomEqualToView(self.labelTemp)
        .widthIs(32.0/frameWidth*viewX)
        .heightIs(54.0/frameHeight*viewY);
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
    
#pragma mark 显示睡眠定时
    //视图2
    UIView *view2 = [UIView new];
    [view2 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view2];
    view2.sd_layout
        .leftEqualToView(view1)
        .topSpaceToView(self.view, 1082.0/frameHeight*viewY)
        .widthIs(462.0/frameWidth*viewX)
        .heightIs(168.0/frameHeight*viewY);
    [view1 setSd_cornerRadius:@10.0];
    
    UILabel *labelsleep= [UILabel new];
    [view2 addSubview:labelsleep];
    labelsleep.text = @"0.5-7.5h";
    [labelsleep setTextAlignment:NSTextAlignmentLeft];
    [labelsleep setTextColor:[UIColor grayColor]];
    [labelsleep setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labelsleep.sd_layout
        .leftSpaceToView(view2, 74.0/frameWidth*viewX)
        .topSpaceToView(view2, 32.0/frameHeight*viewY)
        .widthIs(100.0/frameWidth*viewX)
        .heightIs(30.0/frameHeight*viewY);
    
    //开关
    self.switchSleep = [UIButton new];
    [view2 addSubview:self.switchSleep];
    [self.switchSleep setBackgroundImage:[UIImage imageNamed:@"swoff"] forState:UIControlStateNormal];
    self.switchSleep.sd_layout
        .rightSpaceToView(view2, 22.0/frameWidth*viewX)
        .topSpaceToView(view2, 22.0/frameHeight*viewY)
        .widthIs(94.0/frameWidth*viewX)
        .heightIs(36.0/frameHeight*viewY);
    [self.switchSleep addTarget:self action:@selector(setcount:) forControlEvents:UIControlEventTouchUpInside];
    
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
    /*
     UIView *view3 = [UIView new];
     [view3 setBackgroundColor:[UIColor whiteColor]];
     [self.view addSubview:view3];
     view3.sd_layout
     .rightEqualToView(view1)
     .topSpaceToView(self.view, 1082.0/frameHeight*viewY)
     .widthIs(208.0/frameWidth*viewX)
     .heightIs(168.0/frameHeight*viewY);
     [view1 setSd_cornerRadius:@10.0];
     */
    
    self.btBattery = [UIButton new];
    //[view3 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview: self.btBattery ];
    self.btBattery .sd_layout
        .rightEqualToView(view1)
        .topSpaceToView(self.view, 1082.0/frameHeight*viewY)
        .widthIs(208.0/frameWidth*viewX)
        .heightIs(168.0/frameHeight*viewY);
    [self.btBattery  setSd_cornerRadius:@10.0];
    [self.btBattery setBackgroundImage:[UIImage imageNamed:@"batteryon"] forState:UIControlStateNormal];
    [self.btBattery addTarget:self action:@selector(openbattery) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*
     //电池
     self.btBattry = [UIButton new];
     [self.btBattry setBackgroundImage:[UIImage imageNamed:@"battery"] forState:UIControlStateNormal];
     [view3 addSubview:  self.btBattry];
     self.btBattry.sd_layout
     .centerXEqualToView(view3)
     .centerYEqualToView(view3)
     .widthIs(82.0/frameWidth*viewX)
     .heightEqualToWidth();
     [self.btBattry addTarget:self action:@selector(openbattery) forControlEvents:UIControlEventTouchUpInside];
     */
    
    
    //通风
    self.imgfan = [UIImageView new];
    [self.view addSubview:self.imgfan];
    [self.imgfan setImage:[UIImage imageNamed:@"fanoff"]];
    self.imgfan.sd_layout
        .leftSpaceToView(self.view, 44.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1284.0/frameHeight*viewY)
        .widthIs(108.0/frameWidth*viewX)
        .autoHeightRatio(142.0/122.0);
    
    
    //节能
    self.imgeco = [UIImageView new];
    [self.view addSubview:self.imgeco];
    [self.imgeco setImage:[UIImage imageNamed:@"ecooff"]];
    self.imgeco.sd_layout
        .leftSpaceToView(self.view, 174.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1284.0/frameHeight*viewY)
        .widthIs(108.0/frameWidth*viewX)
        .autoHeightRatio(142.0/122.0);
    
    
    //普通模式
    self.imgnormal = [UIImageView new];
    [self.view addSubview:self.imgnormal];
    [self.imgnormal setImage:[UIImage imageNamed:@"cooloff"]];
    self.imgnormal.sd_layout
        .leftSpaceToView(self.view, 304.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1284.0/frameHeight*viewY)
        .widthIs(108.0/frameWidth*viewX)
        .autoHeightRatio(142.0/122.0);
    
    //加强模式
    self.imgturbo = [UIImageView new];
    [self.view addSubview:self.imgturbo];
    [self.imgturbo setImage:[UIImage imageNamed:@"turbooff"]];
    self.imgturbo.sd_layout
        .leftSpaceToView(self.view, 434.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1284.0/frameHeight*viewY)
        .widthIs(108.0/frameWidth*viewX)
        .autoHeightRatio(142.0/122.0);
    
    //切换
    self.btswitchmode = [UIButton new];
    [self.view addSubview:self.btswitchmode ];
    [self.btswitchmode setBackgroundImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
    self.btswitchmode.sd_layout
        .leftSpaceToView(self.view, 564.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1294.0/frameHeight*viewY)
        .widthIs(96.0/frameWidth*viewX)
        .heightEqualToWidth();
    [self.btswitchmode addTarget:self action:@selector(chgmod:) forControlEvents:UIControlEventTouchUpInside];
    
    //底部左边按钮
    self.buttonDetails = [UIButton new];
    [ self.buttonDetails setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    [ self.buttonDetails setTitle:@"Details" forState:UIControlStateNormal];
    [self.view addSubview: self.buttonDetails];
    self.buttonDetails.sd_layout
        .leftSpaceToView(self.view, 124.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1488.0/frameHeight*viewY)
        .widthIs(226.0/frameWidth*viewX)
        .heightIs(70.0/frameHeight*viewY);
    [ self.buttonDetails setSd_cornerRadius:@12.0];
    [ self.buttonDetails addTarget:self action:@selector(opendetails) forControlEvents:UIControlEventTouchUpInside];
    
    //底部右边边按钮
    self.buttonFaults = [UIButton new];
    [self.buttonFaults setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    [self.buttonFaults setTitle:@"Faults Record" forState:UIControlStateNormal];
    [self.view addSubview:self.buttonFaults];
    self.buttonFaults.sd_layout
        .rightSpaceToView(self.view, 124.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1488.0/frameHeight*viewY)
        .widthIs(226.0/frameWidth*viewX)
        .heightIs(70.0/frameHeight*viewY);
    [self.buttonFaults setSd_cornerRadius:@12.0];
    [self.buttonFaults.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.buttonFaults addTarget:self action:@selector(openfaults) forControlEvents:UIControlEventTouchUpInside];
    
    //蒙层
    self.viewMusk = [UIView new];
    [self.view addSubview:self.viewMusk];
    [self.viewMusk setBackgroundColor:[UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:0.6]];
    self.viewMusk.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 0);
    self.viewMusk.layer.masksToBounds = YES;
    
    
    //详细
    self.viewDetails = [UIView new];
    [self.viewMusk addSubview:self.viewDetails];
    [self.viewDetails setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    self.viewDetails.sd_layout
        .topSpaceToView(self.viewMusk, 565/frameHeight*viewY)
        .leftSpaceToView(self.viewMusk, 0)
        .heightIs(424/frameHeight*viewY)
        .widthIs(frameWidth);         //原设计390
    self.viewDetails.layer.cornerRadius = 20.0f;
    self.viewDetails.layer.masksToBounds = YES;
    
    //详细
    self.batteryprotect = [UIView new];
    [self.viewMusk addSubview:self.batteryprotect];
    [self.batteryprotect setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    self.batteryprotect.sd_layout
        .topSpaceToView(self.viewMusk, 812/frameHeight*viewY)
        .centerXEqualToView(self.viewMusk)
        .heightIs(812.0/frameHeight*viewY)
        .widthIs(750.0/frameWidth*viewX);         //原设计390
    self.batteryprotect.layer.cornerRadius = 20.0f;
    self.batteryprotect.layer.masksToBounds = YES;
    
    UILabel *labellevel = [UILabel new];
    [self.batteryprotect addSubview:labellevel];
    [labellevel setTextColor:[UIColor blackColor]];
    [labellevel setText:@"Battery Protection Level"];
    [labellevel setTextAlignment:NSTextAlignmentCenter];
    [labellevel  setFont:[UIFont fontWithName:@"Arial" size:18]];
    labellevel.sd_layout
        .topSpaceToView(self.batteryprotect, 30.0/frameHeight*viewY)
        .centerXEqualToView(self.batteryprotect)
        .widthIs(750/frameWidth*viewX)
        .heightIs(40.0/frameHeight*viewY);
    
    
    UIPickerView *pickerView = [UIPickerView new];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.batteryprotect addSubview:pickerView];
    pickerView.sd_layout
        .topSpaceToView(_batteryprotect, 30.0/frameHeight*viewY)
        .leftSpaceToView(self.batteryprotect, 0)
        .rightSpaceToView(self.batteryprotect, 0)
        .bottomSpaceToView(self.batteryprotect, 30);
    
    UIButton *btconfirm = [UIButton new];
    [self.batteryprotect addSubview:btconfirm];
    [btconfirm setTitle:@"Confirm" forState:UIControlStateNormal];
    [btconfirm setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    btconfirm.sd_layout
        .bottomSpaceToView(self.batteryprotect, 30.0/frameHeight*viewY)
        .centerXEqualToView(self.batteryprotect)
        .widthIs(200.0/frameWidth*viewX)
        .heightIs(58.0/frameHeight*viewY);
    [btconfirm setSd_cornerRadius:@10.0];
    [btconfirm.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [btconfirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
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
    if([self.brand isEqual:@"EVA24VTR"]){
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
    self.batterylevel = row;
}

-(void) confirm{
    Byte  write[6];
    write[0] = 0xAA;
    write[1] = 0x08;
    write[2] = self.batterylevel;
    write[4] = 0xFF & CalcCRC(&write[1], 2);
    write[3] = 0xFF & (CalcCRC(&write[1], 2)>>8);
    write[5] = 0x55;
    
    NSData *data = [[NSData alloc]initWithBytes:write length:6];
    [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
    [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
    // [self updateStatus];
    [self.viewMusk setHidden:YES];
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
        // weakSelf.labelUp.text = peripheral.name;
        
        if([characteristics.UUID.UUIDString isEqualToString:@"FFE1"]){
            NSData *data = characteristics.value;
            // Byte r[15] ={0};
            if(data.length == 15){
                Byte r[15] = {0};
                memcpy(r, [data bytes], 15);
                weakSelf.dataRead.start = r[0]; //通讯开始
                weakSelf.dataRead.power = r[1]; //0x01开机，0x00关机
                weakSelf.dataRead.tempSetting = r[2];  //设定温度
                weakSelf.dataRead.tempReal = r[3];  //实时温度
                weakSelf.dataRead.mode = r[4];  //工作模式
                weakSelf.dataRead.wind = r[5];  //风速档位 0-自动 1-4 是手动风速
                weakSelf.dataRead.errorcode = r[6];  //强冷模式开关
                weakSelf.dataRead.vhigh = r[7];
                weakSelf.dataRead.vlow = r[8];
                weakSelf.dataRead.battery = r[9];  //倒计时关机时间
                weakSelf.dataRead.light = r[10];  //LOGO 灯开关
                weakSelf.dataRead.lock = r[11];  //氛围灯模式或氛围灯变化时间
                weakSelf.dataRead.crcH = r[12];  //CRC 校验高八位
                weakSelf.dataRead.crcL = r[13];
                weakSelf.dataRead.end = r[17];  //通讯结束
                [weakSelf updateStatus];
            }
            
            if(data.length == 41){
                weakSelf.datacode = [[dataCode alloc] init];
                Byte r[41] = {0};
                memcpy(r, [data bytes], 41);
                weakSelf.datacode.code0=r[0];
                weakSelf.datacode.code1=r[1];
                weakSelf.datacode.code2=r[2];
                weakSelf.datacode.code3=r[3];
                weakSelf.datacode.code4=r[4];
                weakSelf.datacode.code5=r[5];
                weakSelf.datacode.code6=r[6];
                weakSelf.datacode.code7=r[7];
                weakSelf.datacode.code8=r[8];
                weakSelf.datacode.code9=r[9];
                weakSelf.datacode.code10=r[10];
                weakSelf.datacode.code11=r[11];
                weakSelf.datacode.code12=r[12];
                weakSelf.datacode.code13=r[13];
                weakSelf.datacode.code14=r[14];
                weakSelf.datacode.code15=r[15];
                weakSelf.datacode.code16=r[16];
                weakSelf.datacode.code17=r[17];
                weakSelf.datacode.code18=r[18];
                weakSelf.datacode.code19=r[19];
                weakSelf.datacode.code20=r[20];
                weakSelf.datacode.code21=r[21];
                weakSelf.datacode.code22=r[22];
                weakSelf.datacode.code23=r[23];
                weakSelf.datacode.code24=r[24];
                weakSelf.datacode.code25=r[25];
                weakSelf.datacode.code26=r[26];
                weakSelf.datacode.code27=r[27];
                weakSelf.datacode.code28=r[28];
                weakSelf.datacode.code29=r[29];
                weakSelf.datacode.code30=r[30];
                weakSelf.datacode.code31=r[31];
                weakSelf.datacode.code32=r[32];
                weakSelf.datacode.code33=r[33];
                weakSelf.datacode.code34=r[34];
                weakSelf.datacode.code35=r[35];
                weakSelf.datacode.code36=r[36];
                weakSelf.datacode.code37=r[37];
                weakSelf.datacode.code38=r[38];
                weakSelf.datacode.code39=r[39];
                weakSelf.datacode.code40=r[40];
                weakSelf.datacode.code41=r[41];
                [weakSelf.dataErrors addObject:weakSelf.datacode];
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
-(void)setcount:(id)sender{
    //UISwitch *swc = (UISwitch * )sender;
    if(self.sw == NO){
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
        self.sw = YES;
        [self.switchSleep setBackgroundImage:[UIImage imageNamed:@"swon"] forState:UIControlStateNormal];
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
        self.sw = NO;
        [self.switchSleep setBackgroundImage:[UIImage imageNamed:@"swoff"] forState:UIControlStateNormal];
    }
}

//睡眠定时减
-(void)droptimer{
    if(self.sleeplevel>1 && self.sw==YES){
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
    if(self.sleeplevel<15 && self.sw == YES){
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
        //faults.datacode = self.datacode;
        faults.dataErrors = self.dataErrors;
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
        
        [self.dataErrors removeAllObjects];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(pushViewController) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        
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
        
        [self.dataErrors removeAllObjects];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(pushViewController) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        NSData *data = [[NSData alloc]initWithBytes:write length:6];
        [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
        [self.currPeripheral setNotifyValue:YES forCharacteristic:self.characteristic];
        
    }
}


-(void) openbattery{
    [self.viewMusk setHidden:NO];
    [self.viewDetails removeFromSuperview];
    [self.viewMusk addSubview:self.batteryprotect];
}


//更新控件
-(void) updateStatus{
    if(self.dataRead.power == 0x00){ //关机状态
        [self.imgfan1 setImage:[UIImage imageNamed:@"d1"]];
        [self.imgfan2 setImage:[UIImage imageNamed:@"d3"]];
        [self.imgfan3 setImage:[UIImage imageNamed:@"d3"]];
        [self.imgfan4 setImage:[UIImage imageNamed:@"d4"]];
        [self.imgfan5 setImage:[UIImage imageNamed:@"d5"]];
        [self.imgfan setImage:[UIImage imageNamed:@"fanoff"]];
        [self.imgeco setImage:[UIImage imageNamed:@"ecooff"]];
        [self.imgnormal setImage:[UIImage imageNamed:@"cooloff"]];
        [self.imgturbo setImage:[UIImage imageNamed:@"turbooff"]];
        [self.btBattery setBackgroundImage:[UIImage imageNamed:@"batteryoff"] forState:UIControlStateNormal];
        [self.btswitchfan setBackgroundImage:[UIImage imageNamed:@"switchoff"] forState:UIControlStateNormal];
        [self.btswitchfan setEnabled:NO];
        [self.btswitchmode setBackgroundImage:[UIImage imageNamed:@"switchoff"] forState:UIControlStateNormal];
        [self.btswitchmode setEnabled:NO];
        [self.buttonDetails setBackgroundColor:[UIColor grayColor]];
        [self.buttonFaults setBackgroundColor:[UIColor grayColor]];
        [self.buttonDetails setEnabled:NO];
        [self.buttonFaults setEnabled:NO];
        [self.switchSleep setEnabled:NO];
        [self.labelTimer setTextColor:[UIColor grayColor]];
        [self.btBattery setEnabled:NO];
        //   [self.switchSleep setBackgroundImage:[UIImage imageNamed:@"swoff"] forState:UIControlStateNormal];
        [self.progress setchgt:2];
        [self.imgdot setHidden:YES];
        
    }else{ //开机状态
        [self.btBattery setBackgroundImage:[UIImage imageNamed:@"batteryon"] forState:UIControlStateNormal];
        [self.btswitchfan setBackgroundImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
        [self.btswitchfan setEnabled:YES];
        [self.btswitchmode setBackgroundImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
        [self.btswitchmode setEnabled:YES];
        [self.buttonDetails setEnabled:YES];
        [self.buttonFaults setEnabled:YES];
        [self.btBattery setEnabled:YES];
        [self.buttonDetails setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
        [self.buttonFaults setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
        [self.switchSleep setEnabled:YES];
        [self.labelTimer setTextColor:[UIColor blackColor]];
        //温度
        self.labelTemp.text = [NSString stringWithFormat:@"%d°C",self.dataRead.tempSetting];
        self.progress.percent = (self.dataRead.tempSetting - 15)/15.0;
        [self.progress setchgt:0];  // 降温
        [self.imgdot setHidden:NO];
        //故障
        if(self.dataRead.errorcode == 0x00){
            self.labelStatus.text = @"In Good Condition";
            [self.imgdot setHidden:NO];
            [self.labelStatus setTextColor:[UIColor blackColor]];
        }else{
            self.labelStatus.text = [NSString stringWithFormat:@"Fault Code:E%d",self.dataRead.errorcode];
            [self.labelStatus setTextColor:[UIColor redColor]];
            [self.imgdot setHidden:YES];
        }
        
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
    //[self.view setNeedsLayout];
    // [self.view setNeedsDisplay];
}


-(void)goback{
    // self.currPeripheral = nil;
    // self.characteristic = nil;
    // [self.navigationController popViewControllerAnimated:YES];
    [baby cancelAllPeripheralsConnection];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)searchSN{
    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    NSString *strSerial = [mydefaults objectForKey:@"serial"];
    NSString *serial = [strSerial substringFromIndex:strSerial.length-8];
    NSString *strURL = [NSString stringWithFormat:@"https://wrmes.colku.cn/api/wrmes/ggshouhou/yonghu_chanpin_xinxi_get?page=1&size=10&chanpin_xinghao_id=%@",serial];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //判断错误
        if (error) {
            NSLog(@"net error:%@", error);
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSString *jsonText = [NSString stringWithFormat:@"%@", dic];
        NSLog(@"jsonText: %@",jsonText);
        //找到序列号，则进入产品信息页，否则进入注册页
        
        if([[[dic objectForKey:@"return_list_json"] objectForKey:@"chanpin_xinghao_id"] isEqualToString:strSerial]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self goinfo];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self goprofile];
            });
        }
        //回到主线程 来刷新文字
        //  [_textView performSelectorOnMainThread:@selector(setText:) withObject:jsonText waitUntilDone:NO];
    }];
    [dataTask resume];
}


-(void)goprofile{
    RegistViewController *registViewController = [RegistViewController new];
    [self.navigationController pushViewController:registViewController animated:YES];
}


-(void) goinfo{
    ProfileViewController *profileViewController = [ProfileViewController new];
    [self.navigationController pushViewController:profileViewController animated:YES];
}


-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
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


