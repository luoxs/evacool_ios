//
//  ProfileViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/21.
//

#import "ProfileViewController.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0/255 green:248.0/255 blue:249.0/255 alpha:1.0]];
    // Do any additional setup after loading the view.
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
    
    
    //返回按钮
    UIButton *btBack = [UIButton new];
    [self.view addSubview:btBack];
    [btBack setImage:[UIImage imageNamed:@"btreturn"] forState:UIControlStateNormal];
   // [btBack setContentMode:UIViewContentModeScaleAspectFill];
    [btBack setContentMode:UIViewContentModeScaleAspectFill];
    [btBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    //[btBack setcontentf]
    btBack.sd_layout
    .leftSpaceToView(self.view, 50.0/frameWidth*viewX)
    .topSpaceToView(self.view, 100/frameHeight*viewY)
    .widthIs(20/frameWidth*viewX)
    .heightIs(40/frameHeight*viewY);
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
    
    
    UILabel *txtname = [UILabel new];
    [self.view addSubview:txtname];
    [txtname setText:@""];
    [txtname setTextColor:[UIColor blackColor]];
    [txtname setFont:[UIFont fontWithName:@"Arial" size:14]];
    txtname.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 700/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtname setTextAlignment:NSTextAlignmentLeft];
    [txtname setText:self.userNmae];
  

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
    
    UILabel *txtphone = [UILabel new];
    [self.view addSubview:txtphone];
    [txtphone setText:@""];
    [txtphone setTextColor:[UIColor blackColor]];
    [txtphone setFont:[UIFont fontWithName:@"Arial" size:14]];
    txtphone.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 800/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtphone setTextAlignment:NSTextAlignmentLeft];
    [txtphone setText:self.phone];

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
  
    
    //product
    UILabel *labelproduct = [UILabel new];
    [self.view addSubview:labelproduct];
    [labelproduct setText:@"Product"];
    [labelproduct setTextColor:[UIColor blackColor]];
    [labelproduct setFont:[UIFont fontWithName:@"Arial" size:14]];
    labelproduct.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view,1000/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labelproduct setTextAlignment:NSTextAlignmentLeft];
    
    
    UILabel *txtproduct= [UILabel new];
    [self.view addSubview:txtproduct];
    [txtproduct setText:@""];
    [txtproduct setTextColor:[UIColor blackColor]];
    [txtproduct setFont:[UIFont fontWithName:@"Arial" size:14]];
    txtproduct.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 1000/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtproduct setTextAlignment:NSTextAlignmentLeft];
    [txtproduct setText:self.userNmae];
  

    //产品序列号
    UILabel *labelserial = [UILabel new];
    [self.view addSubview:labelserial];
    [labelserial setText:@"Serial Number"];
    [labelserial setTextColor:[UIColor blackColor]];
    [labelserial setFont:[UIFont fontWithName:@"Arial" size:14]];
    labelserial.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view, 1100/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labelserial setTextAlignment:NSTextAlignmentLeft];
    
    UILabel *txtserial = [UILabel new];
    [self.view addSubview:txtserial];
    [txtserial setText:@""];
    [txtserial setTextColor:[UIColor blackColor]];
    [txtserial setFont:[UIFont fontWithName:@"Arial" size:14]];
    txtserial.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 1100/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtserial setTextAlignment:NSTextAlignmentLeft];
    [txtserial setText:self.phone];

    //日期
    UILabel *labeldate = [UILabel new];
    [self.view addSubview:labeldate];
    [labeldate setText:@"Registion Time"];
    [labeldate setTextColor:[UIColor blackColor]];
    [labeldate setFont:[UIFont fontWithName:@"Arial" size:14]];
    labeldate.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view, 1200/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labeldate setTextAlignment:NSTextAlignmentLeft];
    
    UILabel *txtdate = [UILabel new];
    [self.view addSubview:txtdate];
    [txtdate setText:@""];
    [txtdate setTextColor:[UIColor blackColor]];
    [txtdate setFont:[UIFont fontWithName:@"Arial" size:14]];
    txtdate.sd_layout
        .leftSpaceToView(self.view, 310/frameWidth*viewX)
        .topSpaceToView(self.view, 1200/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtdate setTextAlignment:NSTextAlignmentLeft];
    [txtdate setText:self.email];
  
    
    //确认按钮
    UIButton *btmanual = [UIButton new];
    [self.view addSubview:btmanual];
    //[btconfirm setBackgroundColor:[UIColor blueColor]];
    [btmanual setTitle:@"Production Manual" forState:UIControlStateNormal];
    [btmanual setSd_cornerRadius:@10.0];
    btmanual.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(500/frameWidth*viewX)
    .topSpaceToView(self.view, 1330/frameHeight*viewY)
    .heightIs(90/frameHeight*viewY);
    [btmanual setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
  //  [btmanual addTarget:self action:@selector(goinfo) forControlEvents:UIControlEventTouchUpInside];
    
    
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
