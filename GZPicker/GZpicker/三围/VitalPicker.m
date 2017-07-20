//
//  VitalPicker.m
//  MeiChou
//
//  Created by xinshijie on 16/5/25.
//  Copyright © 2016年 Mr.quan. All rights reserved.
//

#import "VitalPicker.h"

static CGFloat const PickerViewHeight = 240;
static CGFloat const PickerViewLabelWeight = 32;

@interface VitalPicker()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 1.当前胸围组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayChrst;
/** 2.当前腰围数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayWaist;
/** 3.当前臀围数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arrayButtocks;
/** 4.当前选中数组 */
@property (nonatomic, strong, nullable)NSMutableArray *arraySelected;

/** 5.选择器 */
@property (nonatomic, strong, nullable)UIPickerView *pickerView;
/** 6.工具器 */
@property (nonatomic, strong, nullable)GZPickerToolbar *toolbar;
/** 7.边线 */
@property (nonatomic, strong, nullable)UIView *lineView;

/** 8.胸围 */
@property (nonatomic, strong, nullable)NSString *chrst;
/** 9.腰围 */
@property (nonatomic, strong, nullable)NSString *waist;
/** 10.臀围 */
@property (nonatomic, strong, nullable)NSString *buttocks;
/** 11.提示**/
@property (nonatomic ,strong ,nullable)UIView *tipView ;

@end

@implementation VitalPicker

#pragma mark - --- init 视图初始化 ---

- (instancetype)initWithDelegate:(nullable id)delegate
{
    self = [self init];
    self.delegate = delegate;
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self loadData];
    }
    return self;
}

- (void)setupUI
{
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = GZ_COLOR(0, 0, 0, 102.0/255);
    [self.layer setOpaque:0.0];
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self.pickerView addSubview:self.tipView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}


- (void)loadData
{
    self.chrst = self.arrayChrst[0];
    self.waist = self.arrayWaist[0];
    self.buttocks = self.arrayButtocks[0];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.arrayChrst.count;
    }else if (component == 1) {
        return self.arrayWaist.count;
    }else{
        return self.arrayButtocks.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return PickerViewLabelWeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.arraySelected = self.arrayChrst[row];
    }else if (component == 1) {
        self.selected = self.arrayWaist[row];
    }else{
        self.selected = self.arrayButtocks[row];
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  self.arrayChrst[row];
    }else if (component == 1){
        text =  self.arrayWaist[row];
    }else{
        
        text = self.arrayButtocks[row];
          }
    
    
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:17]];
    [label setText:text];
    return label;
    
    
}
#pragma mark - --- event response 事件相应 ---

- (void)selectedOk
{
    
    
    [self.delegate VitalPicker:self chrst:self.chrst waist:self.waist buttocks:self.buttocks];
    [self remove];
}

- (void)selectedCancel
{
    [self remove];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    NSInteger index0 = [self.pickerView selectedRowInComponent:0];
    NSInteger index1 = [self.pickerView selectedRowInComponent:1];
    NSInteger index2 = [self.pickerView selectedRowInComponent:2];
    self.chrst = self.arrayChrst[index0];
    self.waist = self.arrayWaist[index1];
    self.buttocks = self.arrayButtocks[index2];
    NSString *title = [NSString stringWithFormat:@"%@ %@ %@", self.chrst, self.waist, self.buttocks];
    [self.toolbar setTitle:title];
    
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:1];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}

- (void)remove
{
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y += PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - --- setters 属性 ---

#pragma mark - --- getters 属性 ---
- (NSMutableArray *)arrayChrst
{
    if (!_arrayChrst) {
        _arrayChrst = [NSMutableArray array];
        for (int i = 65; i < 121; i++) {
            NSString *numberstr = [NSString stringWithFormat:@"%d", i];
//            NSString *ChrstStr = [NSString stringWithFormat:@"胸围"];
//            NSString *string = [NSString stringWithFormat:@"%@ %@",numberstr, ChrstStr];
            [_arrayChrst addObject:numberstr];
    }
    }
    return _arrayChrst;
}

- (NSMutableArray *)arrayWaist
{
    if (!_arrayWaist) {
        _arrayWaist = [NSMutableArray array];
        for (int i = 55; i < 101; i++) {
            NSString *numberstr1 = [NSString stringWithFormat:@"%d", i];
//            NSString *WaistStr = [NSString stringWithFormat:@"腰围"];
//            NSString *string1 = [NSString stringWithFormat:@"%@ %@",numberstr1, WaistStr];
            [_arrayWaist addObject:numberstr1];
    }
    }
    return _arrayWaist;

}

- (NSMutableArray *)arrayButtocks
{
    if (!_arrayButtocks) {
        _arrayButtocks = [NSMutableArray array];
        for (int i = 55; i < 101; i++) {
            NSString *numberstr2 = [NSString stringWithFormat:@"%d", i];
//            NSString *ButtocksStr = [NSString stringWithFormat:@"臀围"];
//            NSString *string2 = [NSString stringWithFormat:@"%@ %@",numberstr2, ButtocksStr];
            [_arrayButtocks addObject:numberstr2];
    }
    }
    return _arrayButtocks;
}

- (NSMutableArray *)arraySelected
{
    if (!_arraySelected) {
        _arraySelected = [NSMutableArray array];
    }
    return _arraySelected;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        CGFloat pickerW = GZScreenWidth;
        CGFloat pickerH = PickerViewHeight - GZControlSystemHeight;
        CGFloat pickerX = 0;
        CGFloat pickerY = GZScreenHeight+GZControlSystemHeight;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
    }
    return _pickerView;
}

- (GZPickerToolbar *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[GZPickerToolbar alloc]initWithTitle:@"请选择三围"
                                 cancelButtonTitle:@"取消"
                                     okButtonTitle:@"确定"
                                         addTarget:self
                                      cancelAction:@selector(selectedCancel)
                                          okAction:@selector(selectedOk)];
        _toolbar.x = 0;
        _toolbar.y = GZScreenHeight;
    }
    return _toolbar;
}

- (UIView *)tipView{
    if (! _tipView) {
        _tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 0.5, GZScreenWidth, 30)];
        
//        _tipView.backgroundColor = [UIColor redColor];
        
        UILabel *chrstLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, GZScreenWidth / 3, 30)];
        [self.tipView addSubview:chrstLa];
        chrstLa.text = @"胸围" ;
        chrstLa.textAlignment = NSTextAlignmentCenter ;
        
        UILabel *waistLa = [[UILabel alloc]initWithFrame:CGRectMake(GZScreenWidth / 3, 0, GZScreenWidth / 3, 30)];
        [self.tipView addSubview:waistLa];
        waistLa.text = @"腰围" ;
        waistLa.textAlignment = NSTextAlignmentCenter ;
        
        UILabel *buttocksLa = [[UILabel alloc]initWithFrame:CGRectMake(GZScreenWidth / 3 * 2, 0, GZScreenWidth / 3, 30)];
        [self.tipView addSubview:buttocksLa];
        buttocksLa.text = @"臀围" ;
        buttocksLa.textAlignment = NSTextAlignmentCenter ;
        
    }
    return _tipView ;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GZScreenWidth, 0.5)];
        [_lineView setBackgroundColor:GZ_COLOR(205, 205, 205, 1.0f)];
    }
    return _lineView;
}

@end

