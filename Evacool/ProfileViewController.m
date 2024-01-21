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
    [labelname setFont:[UIFont fontWithName:@"Arial" size:16]];
    labelname.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view, 650/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labelname setTextAlignment:NSTextAlignmentLeft];
    
    
    UILabel *txtname = [UILabel new];
    [self.view addSubview:txtname];
    [txtname setText:@""];
    [txtname setTextColor:[UIColor blackColor]];
    [txtname setFont:[UIFont fontWithName:@"Arial" size:16]];
    txtname.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 650/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtname setTextAlignment:NSTextAlignmentLeft];
    [txtname setText:self.userNmae];
  

    //联系
    UILabel *labelphone = [UILabel new];
    [self.view addSubview:labelphone];
    [labelphone setText:@"Contact No."];
    [labelphone setTextColor:[UIColor blackColor]];
    [labelphone setFont:[UIFont fontWithName:@"Arial" size:16]];
    labelphone.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view, 780/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labelphone setTextAlignment:NSTextAlignmentLeft];
    
    UILabel *txtphone = [UILabel new];
    [self.view addSubview:txtphone];
    [txtphone setText:@""];
    [txtphone setTextColor:[UIColor blackColor]];
    [txtphone setFont:[UIFont fontWithName:@"Arial" size:16]];
    txtphone.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 780/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtphone setTextAlignment:NSTextAlignmentLeft];
    [txtphone setText:self.phone];

    //电邮
    UILabel *labelmail = [UILabel new];
    [self.view addSubview:labelmail];
    [labelmail setText:@"Email"];
    [labelmail setTextColor:[UIColor blackColor]];
    [labelmail setFont:[UIFont fontWithName:@"Arial" size:16]];
    labelmail.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view, 910/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labelmail setTextAlignment:NSTextAlignmentLeft];
    
    UILabel *txtmail = [UILabel new];
    [self.view addSubview:txtmail];
    [txtmail setText:@""];
    [txtmail setTextColor:[UIColor blackColor]];
    [txtmail setFont:[UIFont fontWithName:@"Arial" size:16]];
    txtmail.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 910/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtmail setTextAlignment:NSTextAlignmentLeft];
    [txtmail setText:self.email];
  
    
    
    
    
    //确认按钮
    UIButton *btconfirm = [UIButton new];
    [self.view addSubview:btconfirm];
    //[btconfirm setBackgroundColor:[UIColor blueColor]];
    [btconfirm setTitle:@"Submit" forState:UIControlStateNormal];
    [btconfirm setSd_cornerRadius:@10.0];
    btconfirm.sd_layout
    .centerXEqualToView(self.view)
    .widthIs(500/frameWidth*viewX)
    .topSpaceToView(self.view, 1050/frameHeight*viewY)
    .heightIs(90/frameHeight*viewY);
    [btconfirm setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    [btconfirm addTarget:self action:@selector(goinfo) forControlEvents:UIControlEventTouchUpInside];
    
    
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
