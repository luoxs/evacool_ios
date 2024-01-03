//
//  detailViewController.m
//  Evacool
//
//  Created by 罗路雅 on 2024/1/3.
//

#import "detailViewController.h"
#import "TruckViewController.h"
#import "BabyBluetooth.h"
#import "SDAutoLayout.h"
#import "MBProgressHUD.h"
#import "crc.h"

@interface detailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UIButton *btback;
@property(nonatomic,strong) UILabel *labeltitle;
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.tableView = [[UITableView alloc]init];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self autolayout];
    
    self.titles =[ NSArray arrayWithObjects:@"Power",@"Mode",@"Fan Speed",@"Voltage",@"Compressor Current",@"Outer Fan Current",@"inner Fan Current",@"Inlet Air Tempreture",@"Outlet Air Tempreture",@"Battery Pretection Lever",nil];
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
    self.tableView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 100)
    .widthIs(self.view.width-20)
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor whiteColor];
    //cell.backgroundColor = [UIColor colorWithRed:204/255.0 green:208/255.0 blue:195/255.0 alpha:1.0];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    //cell.detailTextLabel.text = @"aaaaa";
    NSString *str = [[NSString alloc]init];
    switch(indexPath.row){
        case 0: str = self.datacode.code22 == 0x00 ? @"Off":@"On";break;
        case 1: {
            if(self.datacode.code29 == 0x00){
                str = @"Eco";
            }else if(self.datacode.code29 == 0x01){
                str = @"Cool";
            }else if(self.datacode.code29 == 0x02){
                str = @"Fan";
            }else{
                str = @"Turbo";
            }
        }; break;
        case 2: str = [NSString stringWithFormat:@"%d",self.datacode.code36 ];break;
        case 3: str = [NSString stringWithFormat:@"%.1fV",(self.datacode.code26*256+self.datacode.code27)/10.0];break;
        case 4: str = [NSString stringWithFormat:@"%.1fA",self.datacode.code30/5.0];break;
        case 5: str = [NSString stringWithFormat:@"%.1fA",self.datacode.code31/10.0];break;
        case 6: str = [NSString stringWithFormat:@"%.1fA",self.datacode.code32/10.0];break;
        case 7: str = [NSString stringWithFormat:@"%d°C",self.datacode.code23];break;
        case 8: str = [NSString stringWithFormat:@"%d°C",self.datacode.code24];break;
        case 9: str = [NSString stringWithFormat:@"%0.1lfV",self.datacode.code28*0.2+21.5];break;
            
    }
    cell.detailTextLabel.text = str;
    return cell;
    
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
