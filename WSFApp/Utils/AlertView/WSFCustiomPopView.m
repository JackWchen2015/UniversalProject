//
//  WSFCustiomPopView.m
//  WSFApp
//
//  Created by jack on 2020/9/29.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFCustiomPopView.h"
@interface WSFCustiomPopView()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation WSFCustiomPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame content:(NSString*)text
{
    self=[super initWithFrame:frame];
    if (self) {
        self.contentLabel.text=text;
        [self buildSubViews];
    }
    return self;
}
-(void)buildSubViews
{
    [self addSubview:self.bgBtn];
    [self addSubview:self.mainView];
    [self.mainView addSubview:self.leftBtn];
    [self.mainView addSubview:self.contentLabel];
    [self.mainView addSubview:self.rightBtn];
    [self.bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.mainView setFrame:CGRectMake((SCREEN_WIDTH-285)/2, SCREEN_HEIGHT, 285, 200)];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(-20);
           make.bottom.equalTo(self.mainView).offset(-20);
           make.width.mas_equalTo(115);
           make.height.mas_equalTo(45);
       }];
    
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(115);
            make.height.mas_equalTo(45);
            make.left.mas_equalTo(20);
            make.centerY.equalTo(self.rightBtn);
        }];
    
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainView).offset(20);
            make.left.mas_equalTo(self.mainView).offset(20);
            make.right.mas_equalTo(self.mainView).offset(-20);
        }];
    
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = UIColorHex(#212426);
        _contentLabel.font =SYSTEMFONT(17);
        _contentLabel.numberOfLines=0;
    }
    return _contentLabel;
}
- (void)cancelAction:(UIButton *)btn {
    [self dismiss];
}

- (void)confirmAction:(UIButton *)btn {
    [self dismiss];
}

#pragma mark - getter methods

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        ViewBorderRadius(_leftBtn,4,1,UIColorHex(#EBEBEB));
        [_leftBtn setTitle:@"仍然拒绝" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:UIColorHex(#212426) forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] init];
        ViewRadius(_rightBtn,4);
        [_rightBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageWithColor:UIColorHex(#0AB0ED)] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _rightBtn;
}
- (UIButton *)bgBtn {
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc] init];
        _bgBtn.backgroundColor = [UIColor blackColor];
        _bgBtn.alpha = 0.3;
        [_bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgBtn;
}

- (UIView *)mainView {
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_mainView, 6);
    }
    return _mainView;
}
- (void)show
{
    self.bgBtn.alpha = 0.3;
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.top = SY(240);
    }];
}
- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.mainView.top = SCREEN_HEIGHT;
        self.bgBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


-(void)setLeftTitle:(NSString *)leftTitle
{
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
}
- (void)setLeftBkCol:(UIColor *)leftBkCol
{
    [self.leftBtn setImage:[UIImage imageWithColor:leftBkCol] forState:UIControlStateNormal];
}
-(void)setRightBkCol:(UIColor *)rightBkCol
{
    [self.rightBtn setImage:[UIImage imageWithColor:rightBkCol] forState:UIControlStateNormal];
}
- (void)setRightTitle:(NSString *)rightTitle
{
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
}
@end
