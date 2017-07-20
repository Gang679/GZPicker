//
//  GZPickerToolbar.m
//  GZPicker
//
//  Created by xinshijie on 2017/7/20.
//  Copyright © 2017年 Mr.quan. All rights reserved.
//

#import "GZPickerToolbar.h"
@interface GZPickerToolbar()

@property (nonatomic, strong, nullable)UIButton *buttonLeft;
@property (nonatomic, strong, nullable)UILabel *labelTitle;
@property (nonatomic, strong, nullable)UIButton *buttonRight;
@end
@implementation GZPickerToolbar

#pragma mark - --- init 视图初始化 ---
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                okButtonTitle:(nullable NSString *)okButtonTitle
                    addTarget:(nullable id)target
                 cancelAction:(SEL)cancelAction
                     okAction:(SEL)okAction{
    
    self = [self init];
    
    [self.labelTitle setText:title];
    
    [self.buttonLeft setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [self.buttonLeft addTarget:target action:cancelAction forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonRight setTitle:okButtonTitle forState:UIControlStateNormal];
    [self.buttonRight addTarget:target action:okAction forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return self;
    
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    _title = nil;
    _font = [UIFont systemFontOfSize:15];
    _titleColor = [UIColor blackColor];
    _borderButtonColor = GZ_COLOR(205, 205, 205,1.0f);
    
    self.bounds = CGRectMake(0, 0, GZScreenWidth, GZControlSystemHeight);
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.labelTitle];
    [self addSubview:self.buttonLeft];
    [self addSubview:self.buttonRight];
}

#pragma mark - --- delegate 视图委托 ---

#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- setters 属性 ---

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.labelTitle setText:title];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self.buttonLeft.titleLabel setFont:font];
    [self.buttonRight.titleLabel setFont:font];
    [self.labelTitle setFont:font];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self.labelTitle setTextColor:titleColor];
    [self.buttonLeft setTitleColor:titleColor forState:UIControlStateNormal];
    [self.buttonRight setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setBorderButtonColor:(UIColor *)borderButtonColor
{
    _borderButtonColor = borderButtonColor;
    [self.buttonLeft addBorderColor:borderButtonColor];
    [self.buttonRight addBorderColor:borderButtonColor];
}
#pragma mark - --- getters 属性 ---

- (UIButton *)buttonLeft
{
    if (!_buttonLeft) {
        CGFloat leftX = GZMarginBig;
        CGFloat leftY = GZMarginSmall;
        CGFloat leftW = GZControlSystemHeight;
        CGFloat leftH = GZControlSystemHeight - GZMargin;
        _buttonLeft = [[UIButton alloc]initWithFrame:CGRectMake(leftX, leftY, leftW, leftH)];
        [_buttonLeft setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_buttonLeft addBorderColor:self.borderButtonColor];
        [_buttonLeft.titleLabel setFont:self.font];
    }
    return _buttonLeft;
}

- (UIButton *)buttonRight
{
    if (!_buttonRight) {
        CGFloat rightW = GZControlSystemHeight;
        CGFloat rightH = GZControlSystemHeight - GZMargin;
        CGFloat rightX = GZScreenWidth - rightW - GZMarginBig;
        CGFloat rightY = GZMarginSmall;
        _buttonRight = [[UIButton alloc]initWithFrame:CGRectMake(rightX, rightY, rightW, rightH)];
        [_buttonRight setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_buttonRight addBorderColor:self.borderButtonColor];
        [_buttonRight.titleLabel setFont:self.font];
    }
    return _buttonRight;
}

- (UILabel *)labelTitle
{
    if (!_labelTitle) {
        CGFloat titleX = self.buttonLeft.right + GZMarginSmall;
        CGFloat titleY = 0;
        CGFloat titleW = GZScreenWidth - titleX * 2;
        CGFloat titleH = GZControlSystemHeight;
        _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        [_labelTitle setTextColor:self.titleColor];
        [_labelTitle setFont:self.font];
        _labelTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _labelTitle;
}
@end
