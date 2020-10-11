//
//  WSFBaseTipViewController.m
//  WSFApp
//
//  Created by jack on 2020/9/11.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFBaseTipViewController.h"
#import <FBShimmeringView.h>
@interface WSFBaseTipViewController ()
@property (nonatomic, copy) NSString *tip;
@property (nonatomic) FBShimmeringView *bgView;
@property (nonatomic, copy) UILabel *tiplabel;
@end

@implementation WSFBaseTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setContent];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)setContent {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)startAnimateWithTip:(NSString *)tip {
    if (tip && tip.length) {
        self.tiplabel.text = tip;
    }
    else {
        self.tiplabel.text = [UIApplication sharedApplication].appBundleName;
    }
    self.bgView.shimmering = YES;
}

- (void)stopAnimateWithTip:(NSString *)tip {
    if (tip && tip.length) {
        self.tiplabel.text = tip;
    }
    else {
        self.tiplabel.text = [UIApplication sharedApplication].appBundleName;
    }
    self.bgView.shimmering = NO;
}

#pragma mark -getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [FBShimmeringView new];
        _bgView.contentView=self.tiplabel;
        [self.tiplabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self->_bgView);
        }];
    }
    return _bgView;
}

- (UILabel *)tiplabel {
    if (nil == _tiplabel) {
        _tiplabel = [UILabel new];
        _tiplabel.textAlignment=NSTextAlignmentCenter;
        _tiplabel.textColor=UIColorHex(DCDCDC);
        _tiplabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:30];
    }
    return _tiplabel;
}
@end
