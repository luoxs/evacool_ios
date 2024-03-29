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
    [self Autolayout];
    
    self.titles =[ NSArray arrayWithObjects:@"Power",@"Mode",@"Fan Speed",@"Voltage",@"Compressor Current",@"Outer Fan Current",@"Inner Fan Current",@"Inlet Air Temprature",@"Outlet Air Temprature",@"Battery Protection Level",nil];
}

-(void)Autolayout{
    UIImageView *imgback = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jian"]];
    [self.view addSubview:imgback];
    imgback.sd_layout
    .leftSpaceToView(self.view, 20)
    .topSpaceToView(self.view, 50.0)
    .widthIs(10)
    .heightIs(20);
    
    self.btback = [UIButton new];
    [self.view addSubview:self.btback];
    [self.btback setBackgroundColor:[UIColor clearColor]];
    self.btback.sd_layout
    .leftSpaceToView(self.view, 4)
    .topSpaceToView(self.view, 20)
    .widthIs(80)
    .heightIs(50);
    [self.btback addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    
    self.labeltitle = [UILabel new];
    [self.view addSubview: self.labeltitle];
    [self.labeltitle setTextColor:[UIColor blackColor]];
    [self.labeltitle setFont:[UIFont fontWithName:@"Arial" size:18.0]];
    self.labeltitle.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 50.0)
    .widthIs(self.view.width)
    .heightIs(40);
    [self.labeltitle setTextAlignment:NSTextAlignmentCenter];
    //[self.labeltitle setText:@"EVA 24V Trunck Air Conditioner"];
    [self.labeltitle setText:self.brand];
    
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

    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(10, cell.frame.size.height/4, cell.frame.size.width/2.0-20, cell.frame.size.height/2.0)];
    [label1 setTextColor:[UIColor grayColor]];
    [label1 setTextAlignment:NSTextAlignmentLeft];
    [label1 setFont:[UIFont fontWithName:@"Arial" size:10.0]];
    [cell addSubview:label1];
    label1.text = [self.titles objectAtIndex:indexPath.row];
    
    //cell.detailTextLabel.textColor = [UIColor grayColor];
    //cell.detailTextLabel.text = @"aaaaa";
    
    NSString *str = [[NSString alloc]init];
    switch(indexPath.row){
        case 0: str = self.datacode.code22 == 0x00 ? @"Off":@"On";break;
        case 1: {
            if(self.datacode.code29 == 0x00){
                str = @"Eco";
            }else if(self.datacode.code29 == 0x01){
                str = @"Normal";
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
        case 9: str = [NSString stringWithFormat:@"B%d:%0.1lfV",self.datacode.code28,self.datacode.code28*0.2+21.5];break;
            
    }
  //  cell.detailTextLabel.text = str;
    UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width/2.0, cell.frame.size.height/8.0, cell.frame.size.width/2.0-10, cell.frame.size.height/1.2)];
    [label2 setTextColor:[UIColor blackColor]];
    [label2 setTextAlignment:NSTextAlignmentLeft];
    [label2 setFont:[UIFont fontWithName:@"Vedana-Bold" size:38.0]];
   // [label2 setFont: [UIFont boldSystemFontOfSize:15.0]];
    label2.text = str;
    [cell addSubview:label2];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
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
