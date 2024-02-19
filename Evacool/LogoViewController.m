//
//  LogoViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/20.
//

#import "LogoViewController.h"
#import "SDAutoLayout.h"
#import "HomeViewController.h"

@interface LogoViewController ()
@property (nonatomic,strong) NSString *brand;  //卡车 EVA24VTR EVA12VTR 房车 EVA2700RV
@end

@implementation LogoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutolayout];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}


-(void) setAutolayout{
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
    labelUp.text = self.brand;
    [labelUp setTextAlignment:NSTextAlignmentCenter];
    [labelUp setFont:[UIFont fontWithName:@"Arial" size:28.0]];
    labelUp.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 610.0/frameHeight*viewY)
        .widthIs(600.0/frameWidth*viewX)
        .heightIs(50.0/frameHeight*viewY);
    
    
    //首页图片
    UIImageView *imageHome = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imagehome"]];
    [self.view addSubview:imageHome];
    imageHome.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 210.0/frameHeight*viewY)
        .widthIs(680.0/frameWidth*viewX)
        .heightIs(360.0/frameHeight*viewY);
    [imageHome setSd_cornerRadius:@10.0];
    
    
    //中间标题
    UILabel *labelTitle = [UILabel new];
    [self.view addSubview:labelTitle];
    labelTitle.text = @"Product Catalogue";
    [labelTitle setTextColor:[UIColor blackColor]];
    [labelTitle setTextAlignment:NSTextAlignmentCenter];
    [labelTitle setFont:[UIFont fontWithName:@"Arial" size:26.0]];
    labelTitle.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 708.0/frameHeight*viewY)
        .widthIs(600.0/frameWidth*viewX)
        .heightIs(56.0/frameHeight*viewY);
    
    //中间文字下
    UILabel *labelDown = [UILabel new];
    [self.view addSubview:labelDown];
    labelDown.text = @"Select Product for Connection";
    [labelDown setTextColor:[UIColor blackColor]];
    [labelDown setTextAlignment:NSTextAlignmentCenter];
    [labelDown setFont:[UIFont fontWithName:@"Arial" size:14.0]];
    labelDown.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 804.0/frameHeight*viewY)
        .widthIs(600.0/frameWidth*viewX)
        .heightIs(28.0/frameHeight*viewY);
    
    
    //三个水平视图
    UIButton *view1 = [UIButton new];
    //[view1 setImage:[UIImage imageNamed:@"trunk"]];
    // [view1 setBackgroundColor:[UIColor redColor]];
    [view1 setBackgroundImage:[UIImage imageNamed:@"trunk"] forState:UIControlStateNormal];
    [self.view addSubview:view1];
    view1.sd_layout
        .leftSpaceToView(self.view, 35.0/frameWidth*viewX)
        .topSpaceToView(self.view, 896.0/frameHeight*viewY)
        .widthIs(244.0/frameWidth*viewX)
        .heightIs(340.0/frameHeight*viewY);
    [view1 setSd_cornerRadius:@10.0];
    [view1 addTarget:self action:@selector(setrv24) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *view2 = [UIButton new];
   // [view2 setImage:[UIImage imageNamed:@"rv12"]];
    [view2 setBackgroundImage:[UIImage imageNamed:@"rv12"] forState:UIControlStateNormal];
    [self.view addSubview:view2];
    view2.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 896.0/frameHeight*viewY)
        .widthIs(244.0/frameWidth*viewX)
        .heightIs(340.0/frameHeight*viewY);
    [view2 setSd_cornerRadius:@10.0];
    [view2 addTarget:self action:@selector(setrv12) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *view3 = [UIButton new];
   // [view3 setImage:[UIImage imageNamed:@"rv24"]];
    [view3 setBackgroundImage:[UIImage imageNamed:@"rv24"] forState:UIControlStateNormal];
    [self.view addSubview:view3];
    view3.sd_layout
        .rightSpaceToView(self.view, 35.0/frameWidth*viewX)
        .topSpaceToView(self.view, 896.0/frameHeight*viewY)
        .widthIs(244.0/frameWidth*viewX)
        .heightIs(340.0/frameHeight*viewY);
    [view3 setSd_cornerRadius:@10.0];
    [view3 addTarget:self action:@selector(setrv2700) forControlEvents:UIControlEventTouchUpInside];
    

    //底部logo1
    UIButton *btLogo1 = [UIButton new];
    [btLogo1 setImage:[UIImage imageNamed:@"germany"] forState:UIControlStateNormal];
    [self.view addSubview:btLogo1];
    btLogo1.sd_layout
        .leftSpaceToView(self.view, 116.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1380.0/frameHeight*viewY)
        .widthIs(154.0/frameWidth*viewX)
        .heightIs(84.0/frameHeight*viewY);
    [btLogo1 addTarget:self action:@selector(gosite1) forControlEvents:UIControlEventTouchUpInside];
    
    //底部logo2
    UIButton *btLogo2 = [UIButton new];
    [btLogo2 setImage:[UIImage imageNamed:@"instein"] forState:UIControlStateNormal];
    [self.view addSubview:btLogo2];
    btLogo2.sd_layout
        .rightSpaceToView(self.view, 116.0/frameWidth*viewX)
        .topSpaceToView(self.view, 1380.0/frameHeight*viewY)
        .widthIs(154.0/frameWidth*viewX)
        .heightIs(84.0/frameHeight*viewY);
    [btLogo2 addTarget:self action:@selector(gosite2) forControlEvents:UIControlEventTouchUpInside];
    
   
    UILabel *labelEva = [UILabel new];
    [self.view addSubview:labelEva];
    labelEva.text = @"www.evacool.com.tr";
    [labelEva setTextColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    [labelEva setTextAlignment:NSTextAlignmentCenter];
    [labelEva setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labelEva.sd_layout
        .centerXEqualToView(btLogo1)
        .topSpaceToView(btLogo1, 10.0/frameHeight*viewY)
        .widthIs(300.0/frameWidth*viewX)
        .heightIs(20.0/frameHeight*viewY);
    
    UILabel *labeleinstein = [UILabel new];
    [self.view addSubview:labeleinstein];
    labeleinstein.text = @"www.einsteinmobilehomes.com";
    [labeleinstein setTextColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    [labeleinstein setTextAlignment:NSTextAlignmentCenter];
    [labeleinstein setFont:[UIFont fontWithName:@"Arial" size:12.0]];
    labeleinstein.sd_layout
        .centerXEqualToView(btLogo2)
        .topSpaceToView(btLogo2, 10.0/frameHeight*viewY)
        .widthIs(400.0/frameWidth*viewX)
        .heightIs(20.0/frameHeight*viewY);
   
}
-(void)gosite1{
    NSURL *URL = [NSURL URLWithString:@"http://www.evacool.com.tr"];
    [[UIApplication sharedApplication] openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
        nil;
    }];
}

-(void)gosite2{
    NSURL *URL = [NSURL URLWithString:@"http://www.einsteinmobilehomes.com"];
    [[UIApplication sharedApplication] openURL:URL options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@NO} completionHandler:^(BOOL success) {
        nil;
    }];
}

//卡车 EVA24VTR EVA12VTR 房车 EVA2700RV
-(void)setrv24{
    HomeViewController *homeViewController = [HomeViewController new];
    homeViewController.brand = @"EVA24VTR";
    [self.navigationController pushViewController:homeViewController animated:YES];
}

-(void)setrv12{
    HomeViewController *homeViewController = [HomeViewController new];
    homeViewController.brand = @"EVA12VRV";
    [self.navigationController pushViewController:homeViewController animated:YES];
}

-(void)setrv2700{
    HomeViewController *homeViewController = [HomeViewController new];
    homeViewController.brand = @"EVA2700RV";
    [self.navigationController pushViewController:homeViewController animated:YES];
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
