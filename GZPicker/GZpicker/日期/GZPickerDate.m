//
//  GZPickerDate.m
//  MeiChou
//
//  Created by xinshijie on 16/5/4.
//  Copyright © 2016年 Mr.quan. All rights reserved.
//

#import "GZPickerDate.h"
#import "NSCalendar+GZpick.h"

static CGFloat const PickerViewHeight = 174;
static CGFloat const PickerViewLabelWeight = 28;

static NSInteger const yearMin = 1900;
static NSInteger const yearSum = 200;

@interface GZPickerDate()<UIPickerViewDataSource, UIPickerViewDelegate>

/** 1.选择器 */
@property (nonatomic, strong, nullable)UIPickerView *pickerView;
/** 2.工具器 */
@property (nonatomic, strong, nullable)GZPickerToolbar *toolbar;
/** 3.边线 */
@property (nonatomic, strong, nullable)UIView *lineView;

/** 4.年 */
@property (nonatomic, assign)NSInteger year;
/** 5.月 */
@property (nonatomic, assign)NSInteger month;
/** 6.日 */
@property (nonatomic, assign)NSInteger day;

@end

@implementation GZPickerDate

#pragma mark - --- init 视图初始化 ---

- (instancetype)initWithDelegate:(nullable id /*<GZPickerDateDelegate>*/)delegate
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
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData
{
    _year  = [NSCalendar currentYear];
    _month = [NSCalendar currentMonth];
    _day   = [NSCalendar currentDay];
    [self.pickerView selectRow:(_year - yearMin) inComponent:0 animated:NO];
    [self.pickerView selectRow:(_month - 1) inComponent:1 animated:NO];
    [self.pickerView selectRow:(_day - 1) inComponent:2 animated:NO];
}

#pragma mark - --- delegate 视图委托 ---

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return yearSum;
    }else if(component == 1) {
        return 12;
    }else {
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + yearMin;
        NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
        return  [NSCalendar getDaysWithYear:yearSelected month:monthSelected];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return PickerViewLabelWeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            break;
        case 1:
            [pickerView reloadComponent:2];
        default:
            break;
    }
    
    [self reloadData];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        text =  [NSString stringWithFormat:@"%ld",row + 1900];
    }else if (component == 1){
        text =  [NSString stringWithFormat:@"%ld", row + 1];
    }else{
        text = [NSString stringWithFormat:@"%ld", row + 1];
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
    
    if ([self.delegate respondsToSelector:@selector(pickerDate:year:month:day:)]) {
         [self.delegate pickerDate:self year:self.year month:self.month day:self.day];
    }
   
    [self remove];
}

- (void)selectedCancel
{
    [self remove];
}

#pragma mark - --- private methods 私有方法 ---

- (void)reloadData
{
    self.year  = [self.pickerView selectedRowInComponent:0] + yearMin;
    self.month = [self.pickerView selectedRowInComponent:1] + 1;
    self.day   = [self.pickerView selectedRowInComponent:2] + 1;
    
    self.toolbar.title = [NSString stringWithFormat:@"%ld-%ld-%ld", self.year, self.month, self.day];
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
        _toolbar = [[GZPickerToolbar alloc]initWithTitle:@"请选择日期"
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

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GZScreenWidth, 0.5)];
        [_lineView setBackgroundColor:GZ_COLOR(205, 205, 205, 1.0f)];
    }
    return _lineView;
}

@end


