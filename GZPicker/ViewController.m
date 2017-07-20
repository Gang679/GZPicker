//
//  ViewController.m
//  GZPicker
//
//  Created by xinshijie on 2017/7/20.
//  Copyright © 2017年 Mr.quan. All rights reserved.
//

#import "ViewController.h"
#import "GZSinglePicker.h"
#import "GZPickerDate.h"
#import "VitalPicker.h"
#import "GZPickerAreaThree.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,GZSinglePickerDelegate,GZPickerDateDelegate,VitalPickerDelegate,GZPickerAreaThreeDelegate>

//.strong
@property (nonatomic,strong) UITableView *PickerTableView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.PickerTableView.backgroundColor = [UIColor clearColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4 ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *Arr = @[@"单数组形式",@"三围",@"地址",@"日期"];
    //.自定义Cell方法
    static NSString *rid=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
    cell.textLabel.textColor = [UIColor orangeColor];
    cell.textLabel.text = Arr[indexPath.row];
    NSLog(@"%@",cell.textLabel.text);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSMutableArray *arrayData = [NSMutableArray array];
        for (int i = 150; i < 220; i++) {
            NSString *string = [NSString stringWithFormat:@"%d", i];
            [arrayData addObject:string];
        }
        GZSinglePicker *sing = [[GZSinglePicker alloc]init];
        [sing setArrayData:arrayData];
        [sing setTitle:@"请选择身高"];
        [sing setTitleUnit:@""];
        [sing setDelegate:self];
        [sing show];
    }else if (indexPath.row == 1){
        [[[VitalPicker alloc]initWithDelegate:self]show];
    }else if (indexPath.row == 2){
        [[[GZPickerAreaThree alloc]initWithDelegate:self]show];
    }else{
        GZPickerDate *datePicker = [[GZPickerDate alloc]initWithDelegate:self];
        [datePicker show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//个人信息数据源
- (void)pickerSingle:(GZSinglePicker *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@ cm", selectedTitle];
    [self.view gz_showAlertView:@"温馨提示" message:text];
}

- (void)pickerDate:(GZPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, (long)month, (long)day];
    [self.view gz_showAlertView:@"温馨提示" message:text];
}

- (void)VitalPicker:(VitalPicker *)VitalPicker chrst:(NSString *)chrst waist:(NSString *)waist buttocks:(NSString *)buttocks{
    NSString *text = [NSString stringWithFormat:@"%@-%@-%@", chrst, waist , buttocks];
     [self.view gz_showAlertView:@"温馨提示" message:text];
}

- (void)pickerArea:(GZPickerAreaThree *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
   
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city , area];
    [self.view gz_showAlertView:@"温馨提示" message:text];
}



-(UITableView *)PickerTableView{
    if (!_PickerTableView) {
        _PickerTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 100, GZScreenWidth -20, GZScreenHeight - 200)];
        [self.view addSubview:_PickerTableView];
        _PickerTableView.delegate = self ;
        _PickerTableView.dataSource = self ;
    }
    return _PickerTableView ;
}


@end
