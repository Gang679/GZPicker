//
//  VitalPicker.h
//  MeiChou
//
//  Created by xinshijie on 16/5/25.
//  Copyright © 2016年 Mr.quan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class VitalPicker;
@protocol  VitalPickerDelegate<NSObject>

- (void)VitalPicker:(VitalPicker *)VitalPicker chrst:(NSString *)chrst waist:(NSString *)waist buttocks:(NSString *)buttocks;

@end
@interface VitalPicker : UIButton

@property(nonatomic, weak)id <VitalPickerDelegate>delegate ;

- (instancetype)initWithDelegate:(nullable id)delegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END