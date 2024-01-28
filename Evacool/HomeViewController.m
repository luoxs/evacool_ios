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
#import "RoomViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CDZQRScanViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (retain, nonatomic)  MBProgressHUD *hud;
@property (nonatomic,retain) NSMutableArray <CBPeripheral*> *devices;;
@property (nonatomic,retain) NSMutableArray *localNames;
//@property (nonatomic,strong) NSString *brand;  //卡车 EVA24VTR EVA12VTR 房车 EVA2700RV
//@property (nonatomic,strong) NSString *strType;   //卡车 EVA24VTR EVA12VTR 房车 EVA2700RV
@property (nonatomic,strong) UIView *viewMusk;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,retain)  AVCaptureSession *session; //扫描二维码会话
@property (nonatomic,retain)  AVCaptureVideoPreviewLayer *layer;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview = [[UITableView alloc]init];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.devices = [[NSMutableArray alloc]init];
    self.localNames = [[NSMutableArray alloc]init];
    self.hud = [[MBProgressHUD alloc] init];
    // self.strType = [NSString new];
    [self setAutoLayout];
    baby = [BabyBluetooth shareBabyBluetooth];
    [self babyDelegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi"object:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableview reloadData];
    [self babyDelegate];
    baby.scanForPeripherals().begin();
    [self.navigationController.navigationBar setHidden:YES];
    //[self.viewMusk setHidden:NO];
}

-(void)tongzhi:(NSNotification *)text{
    NSString *message = [NSString stringWithFormat:@"%@",text.userInfo[@"qrvalue"]];
    
    NSString *strtype = [[NSString alloc]init];
    if(message.length>=40){
        strtype = [message substringWithRange:NSMakeRange(32, 8)];
    }
    
    int i=0;
    for(i=0;i<self.devices.count;i++){
        if([[self.devices objectAtIndex:i].name hasPrefix:strtype]){
            [baby.centralManager stopScan];
            [baby cancelAllPeripheralsConnection];
            [baby.centralManager connectPeripheral:[self.devices objectAtIndex:i] options:nil];
        }
    }
    //没有找到设备
    if(i==self.devices.count){
        self.hud.mode = MBProgressHUDModeText;
        [self.view addSubview:self.hud];
        self.hud.label.text = @"Device not found!";
        [self.hud setMinShowTime:3];
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES];
    }

    //2.停止会话
    [self.session stopRunning];
    //3.移除预览图层
    [self.layer removeFromSuperlayer];
}


-(void)setAutoLayout{
    double frameWidth = 750;
    double frameHeight = 1624;
    double viewX = [UIScreen mainScreen].bounds.size.width;
    double viewY = [UIScreen mainScreen].bounds.size.height;
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255 green:248.0/255 blue:249.0/255 alpha:1.0]];
    
    //顶部logo
    UIImageView *imageTop = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imagetop"]];
    [self.view addSubview:imageTop];
    imageTop.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 92.0/frameHeight*viewY)
        .widthIs(228.0/frameWidth*viewX)
        .heightIs(82.0/frameHeight*viewY);
    
    
    UIImageView *imgreturn = [UIImageView new];
    [self.view addSubview:imgreturn];
    [imgreturn setImage:[UIImage imageNamed:@"btreturn"]];
    imgreturn.sd_layout
    .leftSpaceToView(self.view, 50.0/frameWidth*viewX)
    .centerYEqualToView(imageTop)
    .widthIs(20/frameWidth*viewX)
    .heightIs(40/frameHeight*viewY);
    
    //返回按钮
    UIButton *btBack = [UIButton new];
    [self.view addSubview:btBack];
   // [btBack setImage:[UIImage imageNamed:@"btreturn"] forState:UIControlStateNormal];
    btBack.sd_layout
    .centerYEqualToView(imageTop)
    .centerXEqualToView(imgreturn)
    .widthIs(100/frameWidth*viewX)
    .heightIs(100/frameHeight*viewY);
    [btBack addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    //品牌
    UILabel *lbbrand = [UILabel new];
    [self.view addSubview:lbbrand];
    [lbbrand setTextColor:[UIColor blackColor]];
    [lbbrand setTextAlignment:NSTextAlignmentCenter];
    [lbbrand setFont:[UIFont fontWithName:@"Arial" size:18]];
    lbbrand.numberOfLines = 2;
    lbbrand.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 382/frameHeight*viewY)
    .widthIs(332.0/frameWidth*viewX)
    .heightIs(196.0/frameHeight*viewY);
    
    if([self.brand isEqualToString:@"EVA24VTR"]){
        [lbbrand setText:@"Truck\nAir Conditioner"];
    }else if([self.brand isEqualToString:@"EVA12VRV"]){
        [lbbrand setText:@"12V RV\nAir Conditioner"];
    }else{
        [lbbrand setText:@"RV\nAir Conditioner"];
    }
    
    
    //视图4，包含二维码按钮和文字提示
    UIView *view4 = [UIView new];
    [view4 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view4];
    view4.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 722.0/frameHeight*viewY)
        .widthIs(332.0/frameWidth*viewX)
        .heightIs(196.0/frameHeight*viewY);
    [view4 setSd_cornerRadius:@10.0];
    
    //二维码扫描按钮
    UIButton *imageScan = [UIButton new];
    [imageScan setBackgroundImage:[UIImage imageNamed:@"qr"] forState:UIControlStateNormal];
    [view4 addSubview:imageScan];
    imageScan.sd_layout
        .centerXEqualToView(view4)
        .topSpaceToView(view4, 46.0/frameHeight*viewY)
        .widthIs(54.0/frameWidth*viewX)
        .heightEqualToWidth();
    [imageScan addTarget:self action:@selector(scanQRcode) forControlEvents:UIControlEventTouchUpInside];
    
    //文字提示
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
    
    //视图5，包含蓝牙按钮和文字提示
    UIView *view5 = [UIView new];
    [view5 setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view5];
    view5.sd_layout
        //.rightSpaceToView(self.view, 35.0/frameWidth*viewX)
        .centerXEqualToView(self.view)
        .topSpaceToView(view4, 100/frameHeight*viewY)
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
    [imageBluetooth addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    
    //文字提示
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
    [self.viewMusk setHidden:YES];
    
    
    [self.viewMusk addSubview:self.tableview];
    [self.tableview setBackgroundColor:[UIColor whiteColor]];
    self.tableview.sd_layout
        .centerXEqualToView(self.viewMusk)
        .widthRatioToView(self.viewMusk, 0.9)
        .centerYEqualToView(self.viewMusk)
        .heightRatioToView(self.viewMusk, 0.5);
    self.tableview.layer.cornerRadius = 10.0f;
    self.tableview.layer.masksToBounds = YES;
    
    UIButton *btclose = [UIButton new];
    [btclose setImage:[UIImage imageNamed:@"btn_cancel"] forState:UIControlStateNormal];
    [self.viewMusk addSubview:btclose];
    btclose.sd_layout
        .rightEqualToView(self.tableview)
        .bottomSpaceToView(self.tableview, 0)
        .widthIs(viewX/10.0)
        .heightEqualToWidth();
    [btclose addTarget:self action:@selector(closemusk) forControlEvents:UIControlEventTouchUpInside];
}

-(void)goback{
    [self.devices removeAllObjects];
    [baby cancelAllPeripheralsConnection];
    [baby.centralManager stopScan];
    [self.navigationController popViewControllerAnimated:YES];
}

//扫描二维码
-(void)scanQRcode{
    CDZQRScanViewController *vc = [CDZQRScanViewController new];
    vc.brand = self.brand;
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取到图片
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    //将图片存储到相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self.navigationController.navigationBar setHidden:YES];
    [self dismissViewControllerAnimated:YES completion:nil];//返回原界面
}


//点击cancle（取消）之后执行的代码
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) startScanQR{
    self.session = [[AVCaptureSession alloc]init];
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [self.session addInput:input];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.session addOutput:output];
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    [self.session startRunning];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0)
    {
        //1.获取到扫描的内容
        AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
        NSLog(@"扫描的内容==%@",object.stringValue);
        NSString *strtype = [[NSString alloc]init];
        if(object.stringValue.length>=40){
            strtype = [object.stringValue substringWithRange:NSMakeRange(32, 8)];
        }
        
        int i=0;
        for(i=0;i<self.devices.count;i++){
            if([[self.devices objectAtIndex:i].name hasPrefix:strtype]){
                [baby.centralManager stopScan];
                [baby cancelAllPeripheralsConnection];
                [baby.centralManager connectPeripheral:[self.devices objectAtIndex:i] options:nil];
            }
        }
        //没有找到设备
        if(i==self.devices.count){
            self.hud.mode = MBProgressHUDModeText;
            [self.view addSubview:self.hud];
            self.hud.label.text = @"Device not found!";
            [self.hud setMinShowTime:3];
            [self.hud showAnimated:YES];
            [self.hud hideAnimated:YES];
        }
    
        //2.停止会话
        [self.session stopRunning];
        //3.移除预览图层
        [self.layer removeFromSuperlayer];
    }
}

//打开蓝牙列表
-(void)scan{
    [self.viewMusk setHidden:NO];
}

//关闭蓝牙列表
-(void) closemusk{
    [self.viewMusk setHidden:YES];
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
//        if([advertiseName hasPrefix:@"G29"]||[advertiseName hasPrefix:@"G29A"]||[advertiseName hasPrefix:@"EVA"]||[advertiseName hasPrefix:@"GCA"])  {
//            [weakSelf.devices addObject:peripheral];
//            [weakSelf.localNames addObject:advertiseName];
//            // weakSelf.currPeripheral = peripheral;
//            [weakSelf.tableview reloadData];
//            if([weakSelf.devices count]>5){
//                [central stopScan];
//            }
//            if([advertiseName hasPrefix:@"EVA24"]) {
//                weakSelf.brand = @"EVA24VTR";
//            }else if([advertiseName hasPrefix:@"EVA12"]){
//                weakSelf.brand = @"EVA12VTR";
//            }else{
//                weakSelf.brand = @"EVA2700RV";
//            }
//        }
        if([advertiseName hasPrefix:weakSelf.brand]&&(![self.devices containsObject:peripheral])){
            [weakSelf.devices addObject:peripheral];
            [weakSelf.localNames addObject:advertiseName];
                       // weakSelf.currPeripheral = peripheral;
            [weakSelf.tableview reloadData];
            if([weakSelf.devices count]>2){
                [central stopScan];
            }
        }
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
        
    }];
    
    //设置发现设备的Services的委托
    [baby setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *service in peripheral.services) {
            NSLog(@"搜索到服务:%@",service.UUID.UUIDString);
            //for(CBService *service in peripheral.services){
            if([service.UUID.UUIDString isEqualToString:@"FFE0"]){
                [peripheral discoverCharacteristics:nil forService:service];
            }
        }
    }];
    
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
            
            if([c.UUID.UUIDString isEqualToString:@"FFE1"]){
                [weakSelf.viewMusk setHidden:YES];
                
                if([weakSelf.brand isEqualToString:@"EVA24VTR"]){
                    TruckViewController *truckViewController = [[TruckViewController alloc]init];
                    [truckViewController setModalPresentationStyle:UIModalPresentationFullScreen];
                    truckViewController.currPeripheral = weakSelf.currPeripheral;
                    truckViewController.characteristic = c;
                    truckViewController.brand = weakSelf.brand;
                    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
                    [mydefaults setObject:@"Eva 24V Trunck Air Conditioner" forKey:@"brand"];
                    [weakSelf.navigationController pushViewController:truckViewController animated:YES];
                  //  [weakSelf presentViewController:truckViewController animated:YES completion:nil];
                }else  if([weakSelf.brand isEqualToString:@"EVA12VRV"]){
                    TruckViewController *truckViewController = [[TruckViewController alloc]init];
                    [truckViewController setModalPresentationStyle:UIModalPresentationFullScreen];
                    truckViewController.currPeripheral = weakSelf.currPeripheral;
                    truckViewController.characteristic = c;
                    truckViewController.brand = weakSelf.brand;
                    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
                    [mydefaults setObject:@"Eva 12V RV Air Conditioner" forKey:@"brand"];
                   // [weakSelf presentViewController:truckViewController animated:YES completion:nil];
                    [weakSelf.navigationController pushViewController:truckViewController animated:YES];
                }else{
                    RoomViewController *roomViewController = [[RoomViewController alloc]init];
                    [roomViewController setModalPresentationStyle:UIModalPresentationFullScreen];
                    roomViewController.currPeripheral = weakSelf.currPeripheral;
                    roomViewController.characteristic = c;
                    roomViewController.brand = weakSelf.brand;
                    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
                    [mydefaults setObject:@"Eva 2700RV Air Conditioner" forKey:@"brand"];
                    //[weakSelf presentViewController:roomViewController animated:YES completion:nil];
                    [weakSelf.navigationController pushViewController:roomViewController animated:YES];
                }
            }
        }
    }];
    
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"read characteristic successfully!");
        
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
        if(isFirst && ([advertisementData[@"kCBAdvDataLocalName"] hasPrefix:@"G29"]|| [advertisementData[@"kCBAdvDataLocalName"] hasPrefix:@"EVA"]||[advertisementData[@"kCBAdvDataLocalName"] hasPrefix:@"GCA"])){
            isFirst = NO;
            return YES;
        }
        return NO;
    }];
}


#pragma mark tableviewdatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.devices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    //CBPeripheral *peripheral = [self.devices objectAtIndex:indexPath.row];
    NSString *advertiseName = [self.localNames objectAtIndex:indexPath.row];
//    [cell.textLabel setText:advertiseName];
//    [cell.textLabel setTextColor:[UIColor blackColor]];
   
    UILabel *labelname = [UILabel new];
    [cell addSubview:labelname];
    [labelname setTextColor:[UIColor colorWithRed:29/255.0 green:130/255.0 blue:254/255.0 alpha:1]];
    [labelname setFont:[UIFont fontWithName:@"Arial" size:18]];
    [labelname setFrame:CGRectMake(0, 0, cell.frame.size.width*0.9, cell.frame.size.height)];
    [labelname setTextAlignment:NSTextAlignmentCenter];
    [labelname setText:advertiseName];
    
    
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [baby.centralManager stopScan];
    [baby cancelAllPeripheralsConnection];
    [baby.centralManager stopScan];
    [baby.centralManager connectPeripheral:[self.devices objectAtIndex:indexPath.row] options:nil];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.viewMusk animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = @"connect to device.....";
    [self.hud showAnimated:YES];
    
    CBPeripheral *pereipheral = (CBPeripheral *)[self.devices objectAtIndex:indexPath.row];
    NSArray *strs = [pereipheral.name componentsSeparatedByString:@"-"];
    if(strs.count>=2){
        NSString *strSerial = [strs objectAtIndex:1];
        NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
        [mydefaults setObject:strSerial forKey:@"serial"];
    }
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
