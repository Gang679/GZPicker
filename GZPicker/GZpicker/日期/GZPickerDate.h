//
//  GZPickerDate.h
//  MeiChou
//
//  Created by xinshijie on 16/5/4.
//  Copyright © 2016年 Mr.quan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class GZPickerDate;
@protocol  GZPickerDateDelegate<NSObject>
- (void)pickerDate:(GZPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
@interface GZPickerDate : UIButton

@property(nonatomic, weak)id <GZPickerDateDelegate>delegate ;

- (instancetype)initWithDelegate:(nullable id /*<STPickerDateDelegate>*/)delegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END
