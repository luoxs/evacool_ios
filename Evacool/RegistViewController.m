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

@interface RegistViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *celltitles;
@property(nonatomic,strong)UITextField *userNmae;
@property(nonatomic,strong)UITextField *phone;
@property(nonatomic,strong)UITextField *email;
@property(nonatomic,strong)NSString *product;
@property(nonatomic,strong)NSDate *regdate;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIDatePicker *datePicker;

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
    
    self.celltitles = [[NSArray alloc]initWithObjects:@"User Name",@"Contact No",@"Buying Day",@"Notes",@"Type of Car",@"Type of Product",@"Mode",@"Sub Mode", nil];
    
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
        .heightIs(900/frameHeight*viewY);
    
    
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
    [btconfirm addTarget:self action:@selector(goinfo) forControlEvents:UIControlEventTouchUpInside];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    
    //行标题
    UILabel *labelname = [UILabel new];
    [cell addSubview:labelname];
    [labelname setFrame:CGRectMake(20, 0, cell.frame.size.width*0.5, cell.frame.size.height)];
    [labelname setTextColor:[UIColor blackColor]];
    [labelname setFont:[UIFont fontWithName:@"Arial" size:18]];
    [labelname setTextAlignment:NSTextAlignmentLeft];
    [labelname setText:[self.celltitles objectAtIndex:indexPath.row]];
    
    //行内容
    UITextField *txtField = [UITextField new];
    [cell addSubview:txtField];
    [txtField setFrame:CGRectMake(self.view.width/2, 0, cell.frame.size.width*0.5, cell.frame.size.height)];
    if(indexPath.row == 1 ||indexPath.row == 6)
        [txtField setPlaceholder:@"required"];
    [txtField setTag:indexPath.row+1];
    txtField.delegate = self;

    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITextField *txtField = [[self.tableView cellForRowAtIndexPath:indexPath] viewWithTag:indexPath.row+1];
    [txtField becomeFirstResponder];
}
/*
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
 */

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

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

//是痘弹出键盘
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   // double frameWidth = 750;
    double frameHeight = 1624;
   // double viewX = [UIScreen mainScreen].bounds.size.width;
    double viewY = [UIScreen mainScreen].bounds.size.height;
    // 如果需要显示键盘，则隐藏 datePicker
    if (textField.tag != 3) {
        if (self.datePicker.superview) {
            [self.datePicker removeFromSuperview];
        }
        return YES;
    }
    
    [self.view endEditing:YES];
    self.datePicker.frame = CGRectMake(self.view.width/2, 530/frameHeight*viewY, self.view.width/2, 100/frameHeight*viewY);
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
    UITextField *txtField = [(UITextField *) self.view viewWithTag:3];
    txtField.text = str;
    if (self.datePicker.superview) {
        [self.datePicker removeFromSuperview];
    }
    
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
