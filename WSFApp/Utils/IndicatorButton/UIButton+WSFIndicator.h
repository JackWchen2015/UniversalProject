//
//  UIButton+WSFIndicator.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (WSFIndicator)
@property(nonatomic,strong)UIColor* normBkCol UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong)UIColor* disaBkCol UI_APPEARANCE_SELECTOR;
@property(nonatomic,strong)UIColor* selectedBkCol UI_APPEARANCE_SELECTOR;

@property(nonatomic,strong)NSString*  titleIndicator;//保存title
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;

- (void)startLoadingAnimation;
- (void)stopLoadingAnimation;
@end

NS_ASSUME_NONNULL_END
