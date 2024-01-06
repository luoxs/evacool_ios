//
//  faultsViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/3.
//

#import "faultsViewController.h"
#import "TruckViewController.h"
#import "BabyBluetooth.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"
#import "crc.h"

@interface faultsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIButton *btback;
@property(nonatomic,strong) UILabel *labeltitle;
@property(nonatomic,strong) NSArray *titles1;
@property(nonatomic,strong) NSArray *titles2;
@property(nonatomic,strong) UITableView *tableView;
//@property(nonatomic,strong) UITableView *tableView2;
@end

@implementation faultsViewController

 - (void)viewDidLoad {
     [super viewDidLoad];
     // Do any additional setup after loading the view.
     [self.view setBackgroundColor:[UIColor whiteColor]];
     
     if (@available(iOS 13.0, *)) {
         self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.width, self.view.height-110) style:UITableViewStyleInsetGrouped];
     } else {
         // Fallback on earlier versions
     }
     [self.tableView setBackgroundColor:[UIColor grayColor]];
     self.tableView.dataSource = self;
     self.tableView.delegate = self;
     //[self.tableView setSeparatorColor : [UIColor grayColor]];
     [self.tableView setShowsVerticalScrollIndicator:NO]; //不显示滚动条
     [self autolayout];
 
     self.titles1 =[ NSArray arrayWithObjects:@"No",@"Time",@"Temperature Set",@"Accumulated Running Time",@"Voltage At Fault",@"Inner Fan Current",@"Outlet Air Temperature",@"Highest Voltage before Fault",@"Inner Highest Temperature",@"Outlet highest Temperature",nil];
     self.titles2 =[ NSArray arrayWithObjects: @"Fault Code", @"Mode",@"Fan Speed",@"Compressor Current",@"Outer Fan Current",@"Inner Air Temperature",@"Lowest Voltage before Fault",@"Inlet Lowest Temperature",@"Outlet Lowest Temperature",@"Battery Protection Level",nil];
 }

 -(void) autolayout{
     
     self.btback = [UIButton new];
     [self.view addSubview:self.btback];
     [self.btback setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
     self.btback.sd_layout
         .leftSpaceToView(self.view, 30)
         .topSpaceToView(self.view, 40.0)
         .widthIs(10)
         .heightIs(20);
     [self.btback addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
     
     self.labeltitle = [UILabel new];
     [self.view addSubview: self.labeltitle];
     [self.labeltitle setTextColor:[UIColor blackColor]];
     [self.labeltitle setFont:[UIFont fontWithName:@"Arial" size:18.0]];
     self.labeltitle.sd_layout
         .centerXEqualToView(self.view)
         .topSpaceToView(self.view, 60.0)
         .widthIs(self.view.width)
         .heightIs(40);
     [self.labeltitle setTextAlignment:NSTextAlignmentCenter];
     [self.labeltitle setText:@"EVA 24V Trunck Air Conditioner"];
    
     [self.view addSubview:self.tableView];
    /* self.tableView.sd_layout
         .leftSpaceToView(self.view, 16.0)
         .topSpaceToView(self.view, 100)
         .widthIs(self.view.width-32)
         .bottomSpaceToView(self.view, 10.0);*/
 }

 -(void) goback{
     [self dismissViewControllerAnimated:YES completion:nil];
 }

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([self.dataErrors count]>0){
        return [self.dataErrors count];
    }else{
        return 1;
    }
}


 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return 10;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  20;
}
- (BOOL)tableView:(UITableView *)tv shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Determine if row is selectable based on the NSIndexPath.

    return NO;
}


 // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
 // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *cellID = @"cell";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
     
     if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
     }else{
         while ([cell.subviews lastObject] != nil) {
                    [(UIView*)[cell.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
                }
     }

     cell.backgroundColor = [UIColor whiteColor];
     //左上
     UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width/2.0-20, cell.frame.size.height/2.0)];
     [label1 setTextColor:[UIColor grayColor]];
     [label1 setTextAlignment:NSTextAlignmentLeft];
     [label1 setFont:[UIFont fontWithName:@"Arial" size:10.0]];
     [cell addSubview:label1];
     
     //左下
     UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(10, cell.frame.size.height/2.0, cell.frame.size.width/2.0-10, cell.frame.size.height/2.0)];
     [label2 setTextColor:[UIColor blackColor]];
     [label2 setTextAlignment:NSTextAlignmentLeft];
     [label2 setFont:[UIFont fontWithName:@"Arial" size:15.0]];
     [cell addSubview:label2];
     
     //右上
     UILabel *label3 =[[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width/2.0-10, 0,cell.frame.size.width/2.0-20, cell.frame.size.height/2.0)];
     [label3 setTextColor:[UIColor grayColor]];
     [label3 setTextAlignment:NSTextAlignmentLeft];
     [label3 setFont:[UIFont fontWithName:@"Arial" size:10.0]];
     [cell addSubview:label3];
     
     //左下
     UILabel *label4 =[[UILabel alloc] initWithFrame:CGRectMake( cell.frame.size.width/2.0-10,cell.frame.size.height/2.0, cell.frame.size.width/2.0-20, cell.frame.size.height/2.0)];
     [label4 setTextColor:[UIColor blackColor]];
     [label4 setTextAlignment:NSTextAlignmentLeft];
     [label4 setFont:[UIFont fontWithName:@"Arial" size:15.0]];
     [cell addSubview:label4];
     
     
     label1.text = [self.titles1 objectAtIndex:indexPath.row];
     label3.text = [self.titles2 objectAtIndex:indexPath.row];
     
     self.datacode = [self.dataErrors objectAtIndex:[self.dataErrors count] - indexPath.section -1 ];
     
     NSString *str = [[NSString alloc]init];
     switch(indexPath.row){
         case 0: str = [NSString stringWithFormat:@"%d",self.datacode.code37];break;
         case 1: str = [NSString stringWithFormat:@"%c%c/%c%c/20%c%c %c%c:%c%c",self.datacode.code3,self.datacode.code4,self.datacode.code5,self.datacode.code6,self.datacode.code1,self.datacode.code2,self.datacode.code8,self.datacode.code9,self.datacode.code10,self.datacode.code11];break;
         case 2: str = self.datacode.code16<128 ?  [NSString stringWithFormat:@"%d",self.datacode.code16]: [NSString stringWithFormat:@"%d",self.datacode.code16-256] ; break;
         case 3: str = [NSString stringWithFormat:@"%dh",self.datacode.code24/60];break;
         case 4: str = [NSString stringWithFormat:@"%.1fV",self.datacode.code25*256*0.1+self.datacode.code26*0.1];break;
         case 5: str = [NSString stringWithFormat:@"%.1fA",self.datacode.code23*0.1];break;
         case 6: str = self.datacode.code18 <128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code18]:[NSString stringWithFormat:@"%d°C",self.datacode.code18-256];break;
         case 7: str = [NSString stringWithFormat:@"%.1fV",(self.datacode.code27*256+self.datacode.code28)*0.1];break;
         case 8: str = self.datacode.code32<128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code32]:[NSString stringWithFormat:@"%d°C",self.datacode.code32-256];break;
         case 9: str = self.datacode.code34<128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code34]:[NSString stringWithFormat:@"%d°C",self.datacode.code34-256];break;
     }
     label2.text = str;
     switch(indexPath.row){
         case 0: str = [[NSString alloc] initWithFormat:@"E%d",self.datacode.code12];break;
         case 1: {
             if(self.datacode.code14 == 0x00){
                 str = @"Eco";
             }else if(self.datacode.code14 == 0x01){
                 str = @"Normal";
             }else if(self.datacode.code14 == 0x02){
                 str = @"Fan";
             }else{
                 str = @"Turbo";
             }
         }; break;
         case 2: str = [NSString stringWithFormat:@"%d",self.datacode.code15 ];break;
         case 3: str = [NSString stringWithFormat:@"%.1fA",self.datacode.code21*0.2];break;
         case 4: str = [NSString stringWithFormat:@"%.1fA",self.datacode.code22 *0.1];break;
         case 5: str = self.datacode.code17<128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code17]:[NSString stringWithFormat:@"%d°C",self.datacode.code17-256];break;
         case 6: str = [NSString stringWithFormat:@"%.1fV",(self.datacode.code29*256+self.datacode.code30)*0.1];break;
         case 7: str = self.datacode.code31<128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code31]:[NSString stringWithFormat:@"%d°C",self.datacode.code31-256];break;
         case 8: str = self.datacode.code33<128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code33]:[NSString stringWithFormat:@"%d°C",self.datacode.code33-256];break;
         case 9: str = [NSString stringWithFormat:@"%0.1lfV",self.datacode.code13*0.2+21.5];break;
     }
     label4.text = str;
     return cell;
 }
@end
