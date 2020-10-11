//
//  WSFCustiomPopView.h
//  WSFApp
//
//  Created by jack on 2020/9/29.
//  Copyright © 2020 USER. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFCustiomPopView : UIView
@property(nonatomic,copy)NSString* leftTitle;
@property(nonatomic,copy)NSString* rightTitle;

@property(nonatomic)UIColor* leftBkCol;
@property(nonatomic)UIColor* rightBkCol;

-(instancetype)initWithFrame:(CGRect)frame content:(NSString*)text;

- (void)show;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
