//
//  GZSinglePicker.h
//  GZPicker
//
//  Created by xinshijie on 2017/7/20.
//  Copyright © 2017年 Mr.quan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class GZSinglePicker;

@protocol  GZSinglePickerDelegate<NSObject>
- (void)pickerSingle:(GZSinglePicker *)pickerSingle selectedTitle:(NSString *)selectedTitle;

@end

@interface GZSinglePicker : UIButton

/** 1.设置字符串数据数组 */

@property (nonatomic, strong)NSMutableArray<NSString *> *arrayData;
/** 2.设置单位标题 */
@property (nonatomic, strong)NSString *titleUnit;
/** 3.标题 */
@property (nonatomic, strong)NSString *title;

@property(nonatomic, weak)id <GZSinglePickerDelegate>delegate;

- (instancetype)initWithArrayData:(NSArray<NSString *>*)arrayData
                        titleUnit:(NSString *)titleUnit
                         delegate:(nullable id)delegate;

- (void)show;

@end
NS_ASSUME_NONNULL_END

