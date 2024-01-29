//
//  RegistViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/21.
//

#import "RegistViewController.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"
#import "ProfileViewController.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface RegistViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property(nonatomic,strong)NSArray *celltitles;
@property(nonatomic,strong)UITextField *userNmae;
@property(nonatomic,strong)UITextField *phone;
@property(nonatomic,strong)UITextField *email;
@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSDate *regdate;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong) NSString *para1;
@property(nonatomic,strong) NSString *para2;
@property(nonatomic,strong) NSString *para3;
@property(nonatomic,strong) NSString *para4;
@property(nonatomic,strong) NSString *para5;
@property(nonatomic,strong) NSString *para6;
@property(nonatomic,strong) NSString *para7;
@property(nonatomic,strong) NSString *para8;
@property(nonatomic,strong) NSString *para9;
@property(nonatomic,strong) NSString *para10;
@property(nonatomic,strong) NSString *para11;
@property(nonatomic,strong) NSString *para12;
@property(nonatomic,strong) NSString *para13;
@property(nonatomic,strong) NSString *para14;
@property(nonatomic,strong) NSString *para15;

//设置一个定位管理者
@property (nonatomic, strong) CLLocationManager *locationManager;
//获取自身的经纬度坐标
@property (nonatomic, retain) CLLocation *myLocation;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255 green:248.0/255 blue:249.0/255 alpha:1.0]];
    if(self.tableView == nil){
        self.tableView = [UITableView new];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.celltitles = [[NSArray alloc]initWithObjects:@"User Name",@"Contact No",@"Serial No.",@"Buying Day",@"Notes of User",@"Note of Product",@"Type of Car",@"Type of Product",@"Mode",@"Sub Mode",@"Open ID", nil];
    
    // Do any additional setup after loading the view.
    [self startLocation];
    [self setAutolayout];
}

-(void)setAutolayout{
    double frameWidth = 750;
    double frameHeight = 1624;
    double viewX = [UIScreen mainScreen].bounds.size.width;
    double viewY = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *imgback = [UIImageView new];
    [self.view addSubview:imgback];
    [imgback setImage:[UIImage imageNamed:@"btreturn"]];
    imgback.sd_layout
        .leftSpaceToView(self.view, 50.0/frameWidth*viewX)
        .topSpaceToView(self.view, 100/frameHeight*viewY)
        .widthIs(20/frameWidth*viewX)
        .heightIs(40/frameHeight*viewY);
    
    //返回按钮
    UIButton *btBack = [UIButton new];
    [self.view addSubview:btBack];
    btBack.sd_layout
        .centerXEqualToView(imgback)
        .centerYEqualToView(imgback)
        .widthIs(100/frameWidth*viewX)
        .heightIs(100/frameHeight*viewY);
    [btBack addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    //标题
    UILabel *labeltitle = [UILabel new];
    [self.view addSubview:labeltitle];
    [labeltitle setText:@"Warranty Registration"];
    [labeltitle setTextColor:[UIColor blackColor]];
    [labeltitle setFont:[UIFont fontWithName:@"Arial" size:20]];
    labeltitle.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 150/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [labeltitle setTextAlignment:NSTextAlignmentCenter];
    
    //注册信息
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
        .centerXEqualToView(self.view)
        .widthIs(self.view.width)
        .topSpaceToView(self.view, 300/frameHeight*viewY)
        .heightIs(1100/frameHeight*viewY);
    
    
    //确认按钮
    UIButton *btconfirm = [UIButton new];
    [self.view addSubview:btconfirm];
    //[btconfirm setBackgroundColor:[UIColor blueColor]];
    [btconfirm setTitle:@"Submit" forState:UIControlStateNormal];
    [btconfirm setSd_cornerRadius:@10.0];
    btconfirm.sd_layout
        .centerXEqualToView(self.view)
        .widthIs(500/frameWidth*viewX)
        .topSpaceToView(self.tableView, 50/frameHeight*viewY)
        .heightIs(90/frameHeight*viewY);
    [btconfirm setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    [btconfirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.celltitles count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.height/self.celltitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];     会有重影
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    //行标题
    UILabel *labelname = [UILabel new];
    [cell addSubview:labelname];
    [labelname setFrame:CGRectMake(20, 0, cell.frame.size.width*0.4, cell.frame.size.height)];
    [labelname setTextColor:[UIColor blackColor]];
    [labelname setFont:[UIFont fontWithName:@"Arial" size:18]];
    [labelname setTextAlignment:NSTextAlignmentLeft];
    [labelname setText:[self.celltitles objectAtIndex:indexPath.row]];
    
    //行内容
    UITextField *txtField = [UITextField new];
    [cell addSubview:txtField];
    [txtField setFrame:CGRectMake(self.view.width/2, 0, cell.frame.size.width*0.6, cell.frame.size.height)];
    if(indexPath.row == 1||indexPath.row == 2)
        [txtField setPlaceholder:@"required"];
    if(indexPath.row == 8)
        [txtField setPlaceholder:@"1:fregator,2:aircondition"];
    [txtField setTag:indexPath.row+1];
    txtField.delegate = self;
    
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITextField *txtField = [[self.tableView cellForRowAtIndexPath:indexPath] viewWithTag:indexPath.row+1];
    [txtField becomeFirstResponder];
}

-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        // 创建 UIDatePicker 对象
        _datePicker = [[UIDatePicker alloc] init];
        // 设置背景颜色
        _datePicker.backgroundColor = [UIColor whiteColor];
        // 设置日期选择器模式:日期模式
        _datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置可供选择的最小时间：昨天
        NSTimeInterval time = 24 * 60 * 60; // 24H 的时间戳值
        _datePicker.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:- 91*time];
        // 设置可供选择的最大时间：明天
        _datePicker.maximumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:time];
        // 添加 Target-Action
        [_datePicker addTarget:self
                        action:@selector(datePickerValueChanged:)
              forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag == 1) _para1 = textField.text;  //User Name
    if(textField.tag == 2) _para2 = textField.text;  //Contact No
    if(textField.tag == 3) _para3 = textField.text;  //Serial  No
    if(textField.tag == 4) _para4 = textField.text;  //Buying time
    if(textField.tag == 5) _para6 = textField.text;   //Note of User
    if(textField.tag == 6) _para7 = textField.text;   //Note of Product
    if(textField.tag == 7) _para9 = textField.text;   //Type of Car
    if(textField.tag == 8) _para10 = textField.text;   //type of Product
    if(textField.tag == 9) _para11 = textField.text;   //Mode
    if(textField.tag == 10) _para12 = textField.text;   //sub Mode
    if(textField.tag == 11) _para15 = textField.text;   //open id
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

//是痘弹出键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    // double frameWidth = 750;
    double frameHeight = 1624;
    // double viewX = [UIScreen mainScreen].bounds.size.width;
    double viewY = [UIScreen mainScreen].bounds.size.height;
    // 如果需要显示键盘，则隐藏 datePicker
    if (textField.tag != 4) {
        if (self.datePicker.superview) {
            [self.datePicker removeFromSuperview];
        }
        return YES;
    }
    
    [self.view endEditing:YES];
    self.datePicker.frame = CGRectMake(self.view.width/2, 600/frameHeight*viewY, self.view.width/2, 100/frameHeight*viewY);
    self.datePicker.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:214/255.0 alpha:1];
    self.datePicker.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.view addSubview:self.datePicker];
    return NO;
}

-(void)datePickerValueChanged:(UIDatePicker *)sender{
    NSDate *date = sender.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [dateFormatter stringFromDate:date];
    // 将日期赋值给 textField
    UITextField *txtField = [(UITextField *) self.view viewWithTag:4];
    txtField.text = str;
    if (self.datePicker.superview) {
        [self.datePicker removeFromSuperview];
    }
    _para4 = str;
    
}


-(void) confirm{
    if(_para2 == nil){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Contact No. cannot be null!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if(_para3 == nil){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Serial No. cannot be null!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    if(_para10 == nil){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Type of product cannot be null!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    NSDate* currentTime = [NSDate date];
    _para5 = [currentTime descriptionWithLocale:[NSLocale systemLocale]];
    
    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    NSString *strSerial = [mydefaults objectForKey:@"serial"];
    _para8 = [strSerial substringFromIndex:strSerial.length-8];
    
    
    _para13 = [NSString stringWithFormat:@"%f" ,_myLocation.coordinate.longitude];
    _para14 = [NSString stringWithFormat:@"%f" ,_myLocation.coordinate.latitude];
    
    
    NSDictionary *objectDic = @{@"youhu_name":_para1==nil?@"":_para1,
                                @"yonghu_phone":_para2==nil?@"":_para2,
                                @"chanpin_xiaoshou_sn":_para3==nil?@"":_para3,
                                @"gouma_shijian":_para4==nil?@"":_para4,
                                @"zhuce_shijian":_para5==nil?@"":_para5,
                                @"yonghu_beizhu":_para6==nil?@"":_para6,
                                @"chanpin_beizhu":_para7==nil?@"":_para7,
                                @"chanpin_xinghao_id":_para8,
                                @"che_xing":_para9==nil?@"":_para9,
                                @"chanpin_type":_para10==nil?@"":_para10,
                                @"chanpin_xinghao":_para11==nil?@"":_para11,
                                @"chanpin_zixinghao":_para12==nil?@"":_para12,
                                @"zhuce_lng":_para13==nil?@"":_para13,
                                @"zhuce_lat":_para14==nil?@"":_para14,
                                @"zhuce_openid":_para15==nil?@"":_para15
                                
    };
    
    //    [self goinfo];
    /*
     NSURL *url = [NSURL URLWithString:@"https://wrmes.colku.cn/api/wrmes/ggshouhou/yonghu_chanpin_zhuce"];
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     request.HTTPMethod = @"POST";
     [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
     NSData *requestData = [NSJSONSerialization dataWithJSONObject:objectDic options:NSJSONWritingPrettyPrinted error:nil];
     [request setHTTPBody: requestData];
     [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
     NSLog(@"%@", data);//服务器返回的数据
     NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     NSLog(@"%@", str);
     }];*/
    
    //对请求路径的说明
    //http://120.25.226.186:32812/login
    //协议头+主机地址+接口名称
    //协议头(http://)+主机地址(120.25.226.186:32812)+接口名称(login)
    //POST请求需要修改请求方法为POST，并把参数转换为二进制数据设置为请求体
    
    //1.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //2.确立请求路径
    NSURL *url = [NSURL URLWithString:@"https://wrmes.colku.cn/api/wrmes/ggshouhou/yonghu_chanpin_zhuce"];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST,若不修改则默认为GET
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //5.设置请求体
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:objectDic options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody: requestData];
    //6.根据会话对象创建一个Task(发送请求）
    /*
     第一个参数：请求对象
     第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     data：响应体信息（期望的数据）
     response：响应头信息，主要是对服务器端的描述
     error：错误信息，如果请求失败，则error有值
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //8.解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        //        NSString *str = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
        //        NSLog(@"%@", str);
        if([[dict objectForKey:@"msg"] isEqualToString: @"操作成功"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[[dict objectForKey:@"data"] objectForKey:@"return_msg"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[dict objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            });
        }
    }];
    //7.执行任务
    [dataTask resume];
}

//开始定位
- (void)startLocation {
    //初始化定位管理者
    self.locationManager = [[CLLocationManager alloc] init];
    //判断设备是否能够进行定位
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        //精确度获取到米
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置过滤器为无
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        // 取得定位权限，有两个方法，取决于你的定位使用情况
        //一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
        [self.locationManager requestWhenInUseAuthorization];
        //开始获取定位
        [self.locationManager startUpdatingLocation];
    } else {
        NSLog(@"error");
    }
}
//设置获取位置信息的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"%lu", (unsigned long)locations.count);
    self.myLocation = locations.lastObject;
    NSLog(@"longtitude：%f latetitude：%f", _myLocation.coordinate.longitude, _myLocation.coordinate.latitude);
    //不用的时候关闭更新位置服务，不关闭的话这个 delegate 隔一定的时间间隔就会有回调
    [self.locationManager stopUpdatingLocation];
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
