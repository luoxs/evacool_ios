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
@property(nonatomic,strong) UITableView *tableView1;
@property(nonatomic,strong) UITableView *tableView2;
@end

@implementation faultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.tableView1 = [[UITableView alloc]init];
    [self.tableView1 setBackgroundColor:[UIColor whiteColor]];
    self.tableView1.dataSource = self;
    self.tableView1.delegate = self;
    self.tableView2 = [[UITableView alloc]init];
    [self.tableView2 setBackgroundColor:[UIColor whiteColor]];
    self.tableView2.dataSource = self;
    self.tableView2.delegate = self;
    [self autolayout];
    
    self.titles1 =[ NSArray arrayWithObjects:@"No",@"Mode",@"Fan Speed",@"Compressor Current",@"Outer Fan Current",@"Inner Air Temperature",@"Lowest Voltage before Fault",@"Inlet Lowest Temperature",@"Outlet Lowest Temperature",@"Battery Protection Level",nil];
    self.titles2 =[ NSArray arrayWithObjects:@"Time",@"Temperature Set",@"Working Time",@"Voltage At Fault",@"Inner Fan Current",@"Outlet Air Temperature",@"Highest Voltage before Fault",@"Inner Highest Temperature",@"Outlet highest Temperature",@"",nil];
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
    
    [self.view addSubview:self.tableView1];
    self.tableView1.sd_layout
        .leftSpaceToView(self.view, 16.0)
        .topSpaceToView(self.view, 100)
        .widthIs((self.view.width-32)/2.0)
        .bottomSpaceToView(self.view, 10.0);
    
    [self.view addSubview:self.tableView2];
    self.tableView2.sd_layout
        .rightSpaceToView(self.view, 16.0)
        .topSpaceToView(self.view, 100)
        .widthIs((self.view.width-32)/2.0)
        .bottomSpaceToView(self.view, 10.0);
}

-(void) goback{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    //cell.backgroundColor = [UIColor colorWithRed:204/255.0 green:208/255.0 blue:195/255.0 alpha:1.0];
    if(tableView == self.tableView1){
        cell.detailTextLabel.text = [self.titles1 objectAtIndex:indexPath.row];
    }else{
        cell.detailTextLabel.text = [self.titles2 objectAtIndex:indexPath.row];
    }
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    NSString *str = [[NSString alloc]init];
    if(tableView == self.tableView1){
        switch(indexPath.row){
            case 0: str = [NSString stringWithFormat:@"%d",self.datacode.code37];break;
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
    }else{
        switch(indexPath.row){
            case 0: str = [NSString stringWithFormat:@"%c%c/%c%c/20%c%c %c%c:%c%c",self.datacode.code3,self.datacode.code4,self.datacode.code5,self.datacode.code6,self.datacode.code1,self.datacode.code2,self.datacode.code8,self.datacode.code9,self.datacode.code10,self.datacode.code11];break;
            case 1: str = self.datacode.code16<128 ?  [NSString stringWithFormat:@"%d",self.datacode.code16]: [NSString stringWithFormat:@"%d",self.datacode.code16-256] ; break;
            case 2: str = [NSString stringWithFormat:@"%dh",self.datacode.code24/60];break;
            case 3: str = [NSString stringWithFormat:@"%.1fV",self.datacode.code25*256*0.1+self.datacode.code26*0.1];break;
            case 4: str = [NSString stringWithFormat:@"%.1fA",self.datacode.code23*0.1];break;
            case 5: str = self.datacode.code18 <128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code18]:[NSString stringWithFormat:@"%d°C",self.datacode.code18-256];break;
            case 6: str = [NSString stringWithFormat:@"%.1fV",(self.datacode.code27*256+self.datacode.code28)*0.1];break;
            case 7: str = self.datacode.code32<128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code32]:[NSString stringWithFormat:@"%d°C",self.datacode.code32-256];break;
            case 8: str = self.datacode.code34<128 ? [NSString stringWithFormat:@"%d°C",self.datacode.code34]:[NSString stringWithFormat:@"%d°C",self.datacode.code34-256];break;
            case 9: str = @"  ";break;
        }
    }
    cell.textLabel.text = str;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

@end
