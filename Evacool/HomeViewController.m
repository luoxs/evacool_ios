//
//  HomeViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2023/12/26.
//

#import "HomeViewController.h"
#import "BabyBluetooth.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"
#import "TruckViewController.h"

@interface HomeViewController ()
@property (retain, nonatomic)  MBProgressHUD *hud;
@property (nonatomic,retain) NSMutableArray <CBPeripheral*> *devices;;
@property (nonatomic,retain) NSMutableArray *localNames;
@property (nonatomic,strong) NSString *strType;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.strType = [NSString new];
    [self setAutoLayout];
    baby = [BabyBluetooth shareBabyBluetooth];
    [self babyDelegate];
    
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
   
    //中间文字上
    UILabel *labelUp = [UILabel new];
    [self.view addSubview:labelUp];
    labelUp.text = @"Product Catalogue";
    [labelUp setTextAlignment:NSTextAlignmentCenter];
    [labelUp setFont:[UIFont fontWithName:@"Arial" size:28.0]];
    labelUp.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 610.0/frameHeight*viewY)
    .widthIs(600.0/frameWidth*viewX)
    .heightIs(50.0/frameHeight*viewY);
    
    //中间文字下
    UILabel *labelDown = [UILabel new];
    [self.view addSubview:labelDown];
    labelDown.text = @"Select Production for Connection";
    [labelDown setTextAlignment:NSTextAlignmentCenter];
    [labelDown setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labelDown.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 678.0/frameHeight*viewY)
    .widthIs(600.0/frameWidth*viewX)
    .heightIs(20.0/frameHeight*viewY);
    
    //首页图片
    UIImageView *imageHome = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imagehome"]];
    [self.view addSubview:imageHome];
    imageHome.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 210.0/frameHeight*viewY)
    .widthIs(680.0/frameWidth*viewX)
    .heightIs(360.0/frameHeight*viewY);
    [imageHome setSd_cornerRadius:@10.0];

    
    //三个水平视图
    UIImageView *view1 = [UIImageView new];
    [view1 setImage:[UIImage imageNamed:@"trunk"]];
   // [view1 setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:view1];
    view1.sd_layout
    .leftSpaceToView(self.view, 35.0/frameWidth*viewX)
    .topSpaceToView(self.view, 748.0/frameHeight*viewY)
    .widthIs(244.0/frameWidth*viewX)
    .heightIs(340.0/frameHeight*viewY);
    [view1 setSd_cornerRadius:@10.0];
    
    UIImageView *view2 = [UIImageView new];
    [view2 setImage:[UIImage imageNamed:@"rv12"]];
    [self.view addSubview:view2];
    view2.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 748.0/frameHeight*viewY)
    .widthIs(244.0/frameWidth*viewX)
    .heightIs(340.0/frameHeight*viewY);
    [view2 setSd_cornerRadius:@10.0];
    
    UIImageView *view3 = [UIImageView new];
    [view3 setImage:[UIImage imageNamed:@"rv24"]];
    [self.view addSubview:view3];
    view3.sd_layout
    .rightSpaceToView(self.view, 35.0/frameWidth*viewX)
    .topSpaceToView(self.view, 748.0/frameHeight*viewY)
    .widthIs(244.0/frameWidth*viewX)
    .heightIs(340.0/frameHeight*viewY);
    [view3 setSd_cornerRadius:@10.0];
    
    
    //水平视图,扫描
    UIView *view4 = [UIView new];
    [view4 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view4];
    view4.sd_layout
    .leftSpaceToView(self.view, 35.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1152.0/frameHeight*viewY)
    .widthIs(332.0/frameWidth*viewX)
    .heightIs(196.0/frameHeight*viewY);
    [view4 setSd_cornerRadius:@10.0];
    
    //扫描按钮
    UIButton *imageScan = [UIButton new];
    [imageScan setBackgroundImage:[UIImage imageNamed:@"qr"] forState:UIControlStateNormal];
    [view4 addSubview:imageScan];
    imageScan.sd_layout
    .centerXEqualToView(view4)
    .topSpaceToView(view4, 46.0/frameHeight*viewY)
    .widthIs(54.0/frameWidth*viewX)
    .heightEqualToWidth();
    
     //扫描文字
     UILabel *labelscan = [UILabel new];
     [view4 addSubview:labelscan];
     labelscan.text = @"Scan QR Code";
     [labelscan setTextAlignment:NSTextAlignmentCenter];
     [labelscan setFont:[UIFont fontWithName:@"Arial" size:14.0]];
     labelscan.sd_layout
     .centerXEqualToView(view4)
     .topSpaceToView(imageScan, 20.0/frameHeight*viewY)
     .widthIs(300.0/frameWidth*viewX)
     .heightIs(30.0/frameHeight*viewY);
    
    //水平视图，蓝牙
    UIView *view5 = [UIView new];
    [view5 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view5];
    view5.sd_layout
    .rightSpaceToView(self.view, 35.0/frameWidth*viewX)
    .topSpaceToView(self.view, 1152.0/frameHeight*viewY)
    .widthIs(332.0/frameWidth*viewX)
    .heightIs(196.0/frameHeight*viewY);
    [view4 setSd_cornerRadius:@10.0];
    
    //蓝牙按钮
    UIButton *imageBluetooth = [UIButton new];
    [imageBluetooth setBackgroundImage:[UIImage imageNamed:@"bluetooth"] forState:UIControlStateNormal];
    [view5 addSubview:imageBluetooth];
    imageBluetooth.sd_layout
    .centerXEqualToView(view5)
    .topSpaceToView(view5, 46.0/frameHeight*viewY)
    .widthIs(54.0/frameWidth*viewX)
    .heightEqualToWidth();
    [imageBluetooth addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
    //蓝牙文字
    UILabel *labelBluetooth = [UILabel new];
    [view5 addSubview:labelBluetooth];
    labelBluetooth.text = @"Search For Device";
    [labelBluetooth setTextAlignment:NSTextAlignmentCenter];
    [labelBluetooth setFont:[UIFont fontWithName:@"Arial" size:14.0]];
    labelBluetooth.sd_layout
    .centerXEqualToView(view5)
    .topSpaceToView(imageBluetooth, 20.0/frameHeight*viewY)
    .widthIs(300.0/frameWidth*viewX)
    .heightIs(30.0/frameHeight*viewY);
   
    
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
    
}

-(void)connect{
    //baby.scanForPeripherals().begin();
    baby.scanForPeripherals().connectToPeripherals().begin();
    self.hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:self.hud];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = @"Search for device...";
    [self.hud  showAnimated:YES];
}


#pragma mark - babyDelegate
//蓝牙网关初始化和委托方法设置
-(void)babyDelegate{
    __weak typeof(self) weakSelf = self;
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"Device discovered :%@",peripheral.name);
        
//        if(([peripheral.name hasPrefix:@"CCA"]||[peripheral.name hasPrefix:@"GCA"]) && ![self.devices containsObject:peripheral])  {
        NSString *advertiseName = advertisementData[@"kCBAdvDataLocalName"];
        if([advertiseName hasPrefix:@"G29"]||[advertiseName hasPrefix:@"G29A"])  {
            [weakSelf.devices addObject:peripheral];
            [weakSelf.localNames addObject:advertiseName];
            weakSelf.currPeripheral = peripheral;
            [central stopScan];
        }
        
        /*
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *uuidString = [defaults objectForKey:@"UUID"];
        if([peripheral.identifier.UUIDString isEqual:uuidString]){
            [central stopScan];
            [baby cancelAllPeripheralsConnection];
            [central connectPeripheral:peripheral options:nil];
            weakSelf.currPeripheral = peripheral;
        }*/
    }];
    
    //设置连接设备失败的委托
    [baby setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        weakSelf.hud.label.text = @"Device connected failed!\nPlease check the bluetooth!";
        [weakSelf.hud setMinShowTime:1];
        [weakSelf.hud showAnimated:YES];
        [weakSelf.hud hideAnimated:YES];
    }];
    
    //设置断开设备的委托
    [baby setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        weakSelf.hud.mode = MBProgressHUDModeIndeterminate;
        weakSelf.hud.label.text = @"Disconnet devices";
        [weakSelf.hud setMinShowTime:1];
        [weakSelf.hud showAnimated:YES];
    }];
    
    //设置设备连接成功的委托
    [baby setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        [central stopScan];
        NSLog(@"设备：%@--连接成功",peripheral.name);
        weakSelf.currPeripheral = peripheral;
        weakSelf.hud.mode = MBProgressHUDModeText;
        weakSelf.hud.label.text = @"Device connected!";
        [weakSelf.hud setMinShowTime:1];
        [weakSelf.hud hideAnimated:YES];
        [peripheral discoverServices:nil];
        /*
        TruckViewController *truckViewController = [[TruckViewController alloc]init];
        [truckViewController setModalPresentationStyle:UIModalPresentationFullScreen];
        [weakSelf presentViewController:truckViewController animated:YES completion:nil];*/
    }];
    
    //设置发现设备的Services的委托
    [baby setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *service in peripheral.services) {
            NSLog(@"搜索到服务:%@",service.UUID.UUIDString);
            //for(CBService *service in peripheral.services){
                if([service.UUID.UUIDString isEqualToString:@"FFE0"]){
                 [peripheral discoverCharacteristics:nil forService:service];
                }
            //}
        }
    }];
    
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
           // [peripheral readValueForCharacteristic:c];
            
            if([c.UUID.UUIDString isEqualToString:@"FFE1"]){
                TruckViewController *truckViewController = [[TruckViewController alloc]init];
                [truckViewController setModalPresentationStyle:UIModalPresentationFullScreen];
                truckViewController.currPeripheral = weakSelf.currPeripheral;
                truckViewController.characteristic = c;
                [weakSelf presentViewController:truckViewController animated:YES completion:nil];
            }
        }
        
    }];
    
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
     //   NSLog(@"read characteristic successfully!");
        
        if([characteristics.UUID.UUIDString isEqualToString:@"FFE1"]){
            weakSelf.characteristic = characteristics;
            weakSelf.currPeripheral = peripheral;
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:peripheral.identifier.UUIDString forKey:@"UUID"];
        [defaults synchronize];
    }];
    
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@NO};
    //连接设备->
    [baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    
    //设置连接的设备的过滤器
    
     __block BOOL isFirst = YES;
     [baby setFilterOnConnectToPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
     if(isFirst && [advertisementData[@"kCBAdvDataLocalName"] hasPrefix:@"G29"]){
     isFirst = NO;
     return YES;
     }
     return NO;
     }];
    /*
    __block BOOL isFirst = YES;
    [baby setFilterOnConnectToPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        if(isFirst){
            isFirst = NO;
            return YES;
        }
        return NO;
    }];*/
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   // TruckViewController *ViewController = (TruckViewController *) segue.destinationViewController;
   // ViewController.currPeripheral = self.currPeripheral;
   // ViewController.characteristic = self.characteristic;
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
