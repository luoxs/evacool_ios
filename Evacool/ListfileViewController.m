//
//  ListfileViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/2/22.
//

#import "ListfileViewController.h"
#import "SDAutoLayout.h"
#import "ListfileViewController.h"

@interface ListfileViewController ()

@end

@implementation ListfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setAutolayout];
    
}

-(void)setAutolayout{
    double frameWidth = 750;
    double frameHeight = 1624;
    double viewX = [UIScreen mainScreen].bounds.size.width;
    double viewY = [UIScreen mainScreen].bounds.size.height;
    
    //顶部logo图案
    UIImageView *imageTop = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imagetop"]];
    [self.view addSubview:imageTop];
    imageTop.sd_layout
        .centerXEqualToView(self.view)
        .topSpaceToView(self.view, 108.0/frameHeight*viewY)
        .widthIs(228.0/frameWidth*viewX)
        .heightIs(82.0/frameHeight*viewY);
    
    
    UIImageView *imgback = [UIImageView new];
    [self.view addSubview:imgback];
    [imgback setImage:[UIImage imageNamed:@"btreturn"]];
    imgback.sd_layout
        .leftSpaceToView(self.view, 50.0/frameWidth*viewX)
        .topSpaceToView(self.view, 50.0)
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
    
    
    UIButton *btturkey = [UIButton new];
    [self.view addSubview:btturkey];
    [btturkey setTitle:@"Türkçe" forState:UIControlStateNormal];
    [btturkey setSd_cornerRadius:@10.0];
    btturkey.sd_layout
        .centerXEqualToView(self.view)
        .widthIs(250/frameWidth*viewX)
        .topSpaceToView(self.view, 500/frameHeight*viewY)
        .heightIs(80/frameHeight*viewY);
    [btturkey setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
    //  [btmanual addTarget:self action:@selector(goinfo) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btenglish = [UIButton new];
    [self.view addSubview:btenglish];
    [btenglish setTitle:@"English" forState:UIControlStateNormal];
    [btenglish setSd_cornerRadius:@10.0];
    btenglish.sd_layout
        .centerXEqualToView(self.view)
        .widthIs(250/frameWidth*viewX)
        .topSpaceToView(self.view, 700/frameHeight*viewY)
        .heightIs(80/frameHeight*viewY);
    [btenglish setBackgroundColor:[UIColor colorWithRed:29.0/255 green:130.0/255 blue:254.0/255 alpha:1.0]];
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
