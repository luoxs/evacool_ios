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

@interface RegistViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *userNmae;
@property(nonatomic,strong)UITextField *phone;
@property(nonatomic,strong)UITextField *email;
@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSDate *regdate;
@end

@implementation RegistViewController

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
    .topSpaceToView(btBack, 50/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labeltitle setTextAlignment:NSTextAlignmentCenter];
    
    //姓名
    UILabel *labelname = [UILabel new];
    [self.view addSubview:labelname];
    [labelname setText:@"User Name"];
    [labelname setTextColor:[UIColor blackColor]];
    [labelname setFont:[UIFont fontWithName:@"Arial" size:16]];
    labelname.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view, 450/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labelname setTextAlignment:NSTextAlignmentLeft];
    
    
    self.userNmae = [UITextField new];
    [self.view addSubview: self.userNmae];
    [ self.userNmae setText:@""];
    [ self.userNmae setTextColor:[UIColor blackColor]];
    [ self.userNmae setFont:[UIFont fontWithName:@"Arial" size:16]];
    self.userNmae.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 450/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [ self.userNmae setTextAlignment:NSTextAlignmentLeft];
    [ self.userNmae setReturnKeyType:UIReturnKeyDone];
    [ self.userNmae setDelegate:self];
    
    //划一条线
    UIView *vline1 = [UIView new];
    [self.view addSubview:vline1];
    [vline1 setBackgroundColor:[UIColor grayColor]];
    vline1.sd_layout
    .topSpaceToView(self.userNmae, 5)
    .centerXEqualToView(self.userNmae)
    .widthRatioToView(self.userNmae, 1.0)
    .heightIs(1);
    
    //联系
    UILabel *labelphone = [UILabel new];
    [self.view addSubview:labelphone];
    [labelphone setText:@"Contact No."];
    [labelphone setTextColor:[UIColor blackColor]];
    [labelphone setFont:[UIFont fontWithName:@"Arial" size:16]];
    labelphone.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view, 650/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labelphone setTextAlignment:NSTextAlignmentLeft];
    
    
    self.phone = [UITextField new];
    [self.view addSubview:self.phone];
    [self.phone setText:@""];
    [self.phone setTextColor:[UIColor blackColor]];
    [self.phone setFont:[UIFont fontWithName:@"Arial" size:16]];
    self.phone.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 650/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [self.phone setTextAlignment:NSTextAlignmentLeft];
    [self.phone setReturnKeyType:UIReturnKeyDone];
    [self.phone setDelegate:self];
    
    //划一条线
    UIView *vline2 = [UIView new];
    [self.view addSubview:vline2];
    [vline2 setBackgroundColor:[UIColor grayColor]];
    vline2.sd_layout
    .topSpaceToView(self.phone, 5)
    .centerXEqualToView(self.phone)
    .widthRatioToView(self.phone, 1.0)
    .heightIs(1);
    
    //电邮
    UILabel *labelmail = [UILabel new];
    [self.view addSubview:labelmail];
    [labelmail setText:@"Email"];
    [labelmail setTextColor:[UIColor blackColor]];
    [labelmail setFont:[UIFont fontWithName:@"Arial" size:16]];
    labelmail.sd_layout
    .leftSpaceToView(self.view, 50/frameWidth*viewX)
    .topSpaceToView(self.view, 850/frameHeight*viewY)
    .widthIs(400/frameWidth*viewX)
    .heightIs(50/frameHeight*viewY);
    [labelmail setTextAlignment:NSTextAlignmentLeft];
    
    self.email = [UITextField new];
    [self.view addSubview:self.email];
    [self.email setText:@""];
    [self.email setTextColor:[UIColor blackColor]];
    [self.email setFont:[UIFont fontWithName:@"Arial" size:16]];
    self.email.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 850/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [self.email setTextAlignment:NSTextAlignmentLeft];
    [self.email setReturnKeyType:UIReturnKeyDone];
    [self.email setDelegate:self];
    
    //划一条线
    UIView *vline3 = [UIView new];
    [self.view addSubview:vline3];
    [vline3 setBackgroundColor:[UIColor grayColor]];
    vline3.sd_layout
    .topSpaceToView(self.email, 5)
    .centerXEqualToView(self.email)
    .widthRatioToView(self.email, 1.0)
    .heightIs(1);
    
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

-(void) goinfo{
    ProfileViewController *profileViewController = [ProfileViewController new];
    profileViewController.userNmae =  self.userNmae.text;
    profileViewController.phone = self.phone.text;
    profileViewController.email = self.email.text;
    [self.navigationController pushViewController:profileViewController animated:YES];
    
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
     [aTextfield resignFirstResponder];//关闭键盘
    return YES;
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
