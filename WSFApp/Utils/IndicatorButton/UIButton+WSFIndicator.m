//
//  UIButton+WSFIndicator.m
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#import "UIButton+WSFIndicator.h"
#import <objc/runtime.h>


@implementation UIButton (WSFIndicator)

@dynamic indicatorView,titleIndicator;

-(void)setSelectedBkCol:(UIColor *)selectedBkCol
{
    [self setBackgroundImage:[UIImage imageWithColor:selectedBkCol] forState:UIControlStateSelected];
    objc_setAssociatedObject(self, @selector(selectedBkCol), selectedBkCol, OBJC_ASSOCIATION_RETAIN);
}
-(UIColor*)selectedBkCol
{
    return  objc_getAssociatedObject(self, @selector(selectedBkCol));
}
-(void)setNormBkCol:(UIColor *)normBkCol
{
    [self setBackgroundImage:[UIImage imageWithColor:normBkCol] forState:UIControlStateNormal];
    objc_setAssociatedObject(self, @selector(normBkCol), normBkCol, OBJC_ASSOCIATION_RETAIN);
}
-(UIColor*)normBkCol
{
    return  objc_getAssociatedObject(self, @selector(normBkCol));
}
-(void)setDisaBkCol:(UIColor *)disaBkCol
{
    [self setBackgroundImage:[UIImage imageWithColor:disaBkCol] forState:UIControlStateDisabled];
    objc_setAssociatedObject(self, @selector(disaBkCol), disaBkCol, OBJC_ASSOCIATION_RETAIN);
}
-(UIColor*)disaBkCol
{
    return  objc_getAssociatedObject(self, @selector(disaBkCol));
}

- (void)startLoadingAnimation {
    [self.indicatorView startAnimating];
    [self titleIndicator];
    [self setTitle:@"" forState:UIControlStateNormal];
}

- (void)stopLoadingAnimation {
    [self.indicatorView stopAnimating];
    [self setTitle:self.titleIndicator forState:UIControlStateNormal];
}
-(NSString*)titleIndicator
{
    NSString* titleTmp=  objc_getAssociatedObject(self, @selector(titleIndicator));
    if (!titleTmp) {
        titleTmp=self.titleLabel.text;
        objc_setAssociatedObject(self, @selector(titleIndicator), titleTmp, OBJC_ASSOCIATION_RETAIN);
    }
    return titleTmp;
}

-(UIActivityIndicatorView*)indicatorView
{
    UIActivityIndicatorView*  Indicator= objc_getAssociatedObject(self, @selector(indicatorView));
    if (!Indicator) {
        Indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        Indicator.hidesWhenStopped = YES;
        [self addSubview:Indicator];
        [Indicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        objc_setAssociatedObject(self, @selector(indicatorView), Indicator, OBJC_ASSOCIATION_RETAIN);
    }
    return Indicator;
}
@end
