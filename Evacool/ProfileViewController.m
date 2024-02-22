//
//  ProfileViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/21.
//

#import "ProfileViewController.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"
#import "RegistViewController.h"

@interface ProfileViewController ()
@property(nonatomic,strong)NSString *userNmae;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSString *serial;
@property(nonatomic,strong)NSDate *regdate;

@property(nonatomic,strong) UILabel *txtUsername;
@property(nonatomic,strong) UILabel *txtContact;
@property(nonatomic,strong) UILabel *txtProduct;
@property(nonatomic,strong) UILabel *txtSerialno;
@property(nonatomic,strong) UILabel *txtRegistTime;

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255 green:248.0/255 blue:249.0/255 alpha:1.0]];
    // Do any additional setup after loading the view.
    [self getinfo];
    [self setAutolayout];
    
}

-(void)setAutolayout{
    
    double frameWidth = 750;
    double frameHeight = 1624;
    double viewX = [UIScreen mainScreen].bounds.size.width;
    double viewY = [UIScreen mainScreen].bounds.size.height;
    
    UIImageView *imgback = [UIImageView new];
    [self.view addSubview:imgback];
    [imgback setImage:[UIImage imageNamed:@"a1509"]];
    imgback.sd_layout
        .centerXEqualToView(self.view)
        .widthRatioToView(self.view, 1.0)
        .topSpaceToView(self.view, 0)
        .autoHeightRatio(468.0/750);
    
    UIImageView *imgback1 = [UIImageView new];
    [self.view addSubview:imgback1];
    [imgback1 setImage:[UIImage imageNamed:@"a91"]];
    imgback1.sd_layout
        .leftSpaceToView(self.view, 50/frameWidth*viewX)
        .widthRatioToView(self.view, 0.06)
        .topSpaceToView(self.view, 368/frameHeight*viewY)
        .widthEqualToHeight();
    [imgback1 setContentMode:UIViewContentModeScaleAspectFit];
    
    UIImageView *imgback2 = [UIImageView new];
    [self.view addSubview:imgback2];
    [imgback2 setImage:[UIImage imageNamed:@""]];
    imgback2.sd_layout
        .centerXEqualToView(self.view)
        .widthRatioToView(self.view, 1.0)
        .topSpaceToView(self.view, 0)
        .autoHeightRatio(468.0/750);
    
    UIImageView *imgback3 = [UIImageView new];
    [self.view addSubview:imgback3];
    [imgback3 setImage:[UIImage imageNamed:@"goback"]];
    imgback3.sd_layout
        .leftSpaceToView(self.view, 50.0/frameWidth*viewX)
        .topSpaceToView(self.view, 100/frameHeight*viewY)
        .widthIs(20/frameWidth*viewX)
        .heightIs(40/frameHeight*viewY);
    
    //返回按钮
    UIButton *btBack = [UIButton new];
    [self.view addSubview:btBack];
    btBack.sd_layout
        .centerXEqualToView(imgback3)
        .centerYEqualToView(imgback3)
        .widthIs(100/frameWidth*viewX)
        .heightIs(100/frameHeight*viewY);
    [btBack addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    //姓名
    UILabel *labelname = [UILabel new];
    [self.view addSubview:labelname];
    [labelname setText:@"User Name"];
    [labelname setTextColor:[UIColor blackColor]];
    [labelname setFont:[UIFont fontWithName:@"Arial" size:14]];
    labelname.sd_layout
        .leftSpaceToView(self.view, 50/frameWidth*viewX)
        .topSpaceToView(self.view, 700/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [labelname setTextAlignment:NSTextAlignmentLeft];
    
    
    self.txtUsername = [UILabel new];
    [self.view addSubview: self.txtUsername];
    [ self.txtUsername setText:@""];
    [ self.txtUsername setTextColor:[UIColor blackColor]];
    [ self.txtUsername setFont:[UIFont fontWithName:@"Arial" size:14]];
    self.txtUsername.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 700/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [ self.txtUsername setTextAlignment:NSTextAlignmentLeft];
    // [txtname setText:self.userNmae];
    
    
    //联系
    UILabel *labelphone = [UILabel new];
    [self.view addSubview:labelphone];
    [labelphone setText:@"Contact No."];
    [labelphone setTextColor:[UIColor blackColor]];
    [labelphone setFont:[UIFont fontWithName:@"Arial" size:14]];
    labelphone.sd_layout
        .leftSpaceToView(self.view, 50/frameWidth*viewX)
        .topSpaceToView(self.view, 800/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [labelphone setTextAlignment:NSTextAlignmentLeft];
    
    self.txtContact = [UILabel new];
    [self.view addSubview: self.txtContact];
    [ self.txtContact setText:@""];
    [ self.txtContact setTextColor:[UIColor blackColor]];
    [ self.txtContact setFont:[UIFont fontWithName:@"Arial" size:14]];
    self.txtContact.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 800/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [ self.txtContact setTextAlignment:NSTextAlignmentLeft];
    // [txtphone setText:self.phone];
    
    /*
     //电邮
     UILabel *labelmail = [UILabel new];
     [self.view addSubview:labelmail];
     [labelmail setText:@"Email"];
     [labelmail setTextColor:[UIColor blackColor]];
     [labelmail setFont:[UIFont fontWithName:@"Arial" size:14]];
     labelmail.sd_layout
     .leftSpaceToView(self.view, 50/frameWidth*viewX)
     .topSpaceToView(self.view, 900/frameHeight*viewY)
     .widthIs(400/frameWidth*viewX)
     .heightIs(50/frameHeight*viewY);
     [labelmail setTextAlignment:NSTextAlignmentLeft];
     
     UILabel *txtmail = [UILabel new];
     [self.view addSubview:txtmail];
     [txtmail setText:@""];
     [txtmail setTextColor:[UIColor blackColor]];
     [txtmail setFont:[UIFont fontWithName:@"Arial" size:14]];
     txtmail.sd_layout
     .leftSpaceToView(self.view, 310/frameWidth*viewX)
     .topSpaceToView(self.view, 900/frameHeight*viewY)
     .widthIs(400/frameWidth*viewX)
     .heightIs(50/frameHeight*viewY);
     [txtmail setTextAlignment:NSTextAlignmentLeft];
     [txtmail setText:self.email];
     
     */
    
    //product
    UILabel *labelproduct = [UILabel new];
    [self.view addSubview:labelproduct];
    [labelproduct setText:@"Serial Number"];
    [labelproduct setTextColor:[UIColor blackColor]];
    [labelproduct setFont:[UIFont fontWithName:@"Arial" size:14]];
    labelproduct.sd_layout
        .leftSpaceToView(self.view, 50/frameWidth*viewX)
        .topSpaceToView(self.view,900/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [labelproduct setTextAlignment:NSTextAlignmentLeft];
    
    self.txtProduct= [UILabel new];
    [self.view addSubview:self.txtProduct];
    [self.txtProduct setText:@""];
    [self.txtProduct setTextColor:[UIColor blackColor]];
    [self.txtProduct setFont:[UIFont fontWithName:@"Arial" size:14]];
    self.txtProduct.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 900/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [self.txtProduct setTextAlignment:NSTextAlignmentLeft];
    //   NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    //   [self.txtProduct setText:[mydefaults objectForKey:@"brand"]];
    
    
    //产品序列号
    UILabel *labelserial = [UILabel new];
    [self.view addSubview:labelserial];
    [labelserial setText:@"Product"];
    [labelserial setTextColor:[UIColor blackColor]];
    [labelserial setFont:[UIFont fontWithName:@"Arial" size:14]];
    labelserial.sd_layout
        .leftSpaceToView(self.view, 50/frameWidth*viewX)
        .topSpaceToView(self.view, 1025/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [labelserial setTextAlignment:NSTextAlignmentLeft];
    
    self.txtSerialno = [UILabel new];
    [self.view addSubview:self.txtSerialno];
    [self.txtSerialno setText:@""];
    [self.txtSerialno setTextColor:[UIColor blackColor]];
    [self.txtSerialno setFont:[UIFont fontWithName:@"Arial" size:14]];
    self.txtSerialno.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 1000/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(100/frameHeight*viewY);
    [self.txtSerialno setTextAlignment:NSTextAlignmentLeft];
    [self.txtSerialno setNumberOfLines:2];
    // NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    // [txtserial setText:self.serial];
    
    //日期
    UILabel *labeldate = [UILabel new];
    [self.view addSubview:labeldate];
    [labeldate setText:@"Registion Time"];
    [labeldate setTextColor:[UIColor blackColor]];
    [labeldate setFont:[UIFont fontWithName:@"Arial" size:14]];
    labeldate.sd_layout
        .leftSpaceToView(self.view, 50/frameWidth*viewX)
        .topSpaceToView(self.view, 1150/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [labeldate setTextAlignment:NSTextAlignmentLeft];
    
    self.txtRegistTime = [UILabel new];
    [self.view addSubview: self.txtRegistTime];
    [ self.txtRegistTime setText:@""];
    [ self.txtRegistTime setTextColor:[UIColor blackColor]];
    [ self.txtRegistTime setFont:[UIFont fontWithName:@"Arial" size:14]];
    self.txtRegistTime.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 1150/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [ self.txtRegistTime setTextAlignment:NSTextAlignmentLeft];
    
    /*
     NSDate *currentDate = [NSDate date];//获取当前时间，日期
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm"];//设置格式
     NSTimeZone* timeZone = [NSTimeZone localTimeZone];//设置时区
     NSString *dateString = [dateFormatter stringFromDate:currentDate];
     [txtdate setText:dateString];
     */
    
    
    //查看手册
    UIButton *btmanual = [UIButton new];
    [self.view addSubview:btmanual];
    //[btconfirm setBackgroundColor:[UIColor blueColor]];
    [btmanual setTitle:@"Production Manual" forState:UIControlStateNormal];
    [btmanual setSd_cornerRadius:@10.0];
    btmanual.sd_layout
        .centerXEqualToView(self.view)
        .widthIs(500/frameWidth*viewX)
        .topSpaceToView(self.view, 1280/frameHeight*viewY)
        .heightIs(90/frameHeight*viewY);
    [btmanual setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    //  [btmanual addTarget:self action:@selector(goinfo) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelcpright = [UILabel new];
    [self.view addSubview:labelcpright];
    [labelcpright setText:@"Tel:0(535) 728 77 97\nE-mail:info@evacool.com.tr"];
    [labelcpright setNumberOfLines:2];
    [labelcpright setTextColor:[UIColor blackColor]];
    [labelcpright setFont:[UIFont fontWithName:@"Arial" size:10]];
    [labelcpright setTextAlignment:NSTextAlignmentCenter];
    labelcpright.sd_layout
        .centerXEqualToView(self.view)
        .bottomSpaceToView(self.view, 20/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(90/frameHeight*viewY);
}

-(void)getinfo{
    NSUserDefaults *mydefaults = [NSUserDefaults standardUserDefaults];
    NSString *strSerial = [mydefaults objectForKey:@"sn"];
    // strSerial = @"EVA24VTR-AD23120001";
    // NSString *serial = [strSerial substringFromIndex:strSerial.length-8];
    NSString *strURL = [NSString stringWithFormat:@"https://wrmes.colku.cn/api/wrmes/ggshouhou/zd_yonghu_chanpin_zhuce_teq_get?page=0&size=10&chanpin_xiaoshou_sn=%@",strSerial];
    NSURL *url = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //判断错误
        if (error) {
            NSLog(@"net error:%@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Network Error!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *noaction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@",error] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    nil;
                }];
                [alertViewController addAction:noaction];
                
            });
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSString *jsonText = [NSString stringWithFormat:@"%@", dic];
        NSLog(@"jsonText: %@",jsonText);
        //找到序列号，则进入产品信息页，否则进入注册页
        
        NSDictionary *dicdata = [dic objectForKey:@"data"];
        NSArray *arraydata = [dicdata objectForKey:@"return_list_json"];
        if(arraydata.count >0){
            NSDictionary *dic = [arraydata objectAtIndex:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userNmae = [dic objectForKey:@"username"];
                self.phone = [dic objectForKey:@"liangxi_fangshi"];
                self.regdate = [dic objectForKey:@"zhuce_shijian"];
                self.product = [dic objectForKey:@"chanpin_xiaoshou_sn"];
              //  self.serial = [dic objectForKey:@"zhuce_chengshi"];
                
                NSString *strserial = [NSString new];
                if([self.product hasPrefix:@"EVA12VRV"]){
                    self.serial = @"12 RV\nAir Conditioner";
                }else if([self.product hasPrefix:@"EVA24VTR"]){
                    self.serial = @"Truck\nAir Conditioner";
                }else{
                    self.serial = @"RV\nAir Conditioner";
                }
                
                [self.txtUsername setText:self.userNmae];
                [self.txtContact setText:self.phone];
                [self.txtProduct setText:self.product];
                [self.txtSerialno setText:self.serial];
                [self.txtRegistTime setText:self.regdate];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                RegistViewController *registViewController = [RegistViewController new];
                [registViewController setModalPresentationStyle:UIModalPresentationFullScreen];
                [self presentViewController:registViewController animated:YES completion:nil];
            });
        }
    }];
    [dataTask resume];
}

-(void)goback{
    [self.navigationController popViewControllerAnimated:YES];
    
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
