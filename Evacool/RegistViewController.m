//
//  RegistViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/21.
//

#import "RegistViewController.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"

@interface RegistViewController ()
@property(nonatomic,strong)NSString *userNmae;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *email;
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
    
    
    UITextField *txtname = [UITextField new];
    [self.view addSubview:txtname];
    [txtname setText:@""];
    [txtname setTextColor:[UIColor blackColor]];
    [txtname setFont:[UIFont fontWithName:@"Arial" size:16]];
    txtname.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 450/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtname setTextAlignment:NSTextAlignmentLeft];
    
    
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
    
    
    UITextField *txtphone = [UITextField new];
    [self.view addSubview:txtphone];
    [txtphone setText:@""];
    [txtphone setTextColor:[UIColor blackColor]];
    [txtphone setFont:[UIFont fontWithName:@"Arial" size:16]];
    txtphone.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 650/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtphone setTextAlignment:NSTextAlignmentLeft];
    
    
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
    
    UITextField *txtmail = [UITextField new];
    [self.view addSubview:txtmail];
    [txtmail setText:@""];
    [txtmail setTextColor:[UIColor blackColor]];
    [txtmail setFont:[UIFont fontWithName:@"Arial" size:16]];
    txtmail.sd_layout
        .leftSpaceToView(self.view, 260/frameWidth*viewX)
        .topSpaceToView(self.view, 850/frameHeight*viewY)
        .widthIs(400/frameWidth*viewX)
        .heightIs(50/frameHeight*viewY);
    [txtmail setTextAlignment:NSTextAlignmentLeft];
    
    
    
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
