//
//  GZPickerArea.h
//  MeiChou
//
//  Created by xinshijie on 16/5/4.
//  Copyright © 2016年 Mr.quan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class GZPickerAreaThree;
@protocol  GZPickerAreaThreeDelegate<NSObject>

- (void)pickerArea:(GZPickerAreaThree *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end
@interface GZPickerAreaThree : UIButton

@property(nonatomic, weak)id <GZPickerAreaThreeDelegate>delegate ;

- (instancetype)initWithDelegate:(nullable id /*<STPickerAreaDelegate>*/)delegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END
