//
//  WSFAppLaunchAdManager.m
//  WSFApp
//
//  Created by jack on 2020/9/17.
//  Copyright © 2020 USER. All rights reserved.
//

#import "WSFAppLaunchAdManager.h"
#import "WSFBaseWebViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface WSFAppLaunchAdManager ()
@property(nonatomic,strong)UIWindow* adwindow;
@property (nonatomic, weak) UIButton* downCountButton;
@property (nonatomic, assign) NSInteger downCount;
@end
@implementation WSFAppLaunchAdManager
+(void)load
{
    [self shareInstance];
}
+(void)shareInstance
{
    static WSFAppLaunchAdManager*  singleCWADLan=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleCWADLan=[[WSFAppLaunchAdManager alloc] init];
    });
}

-(instancetype)init
{
    self=[super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                [self showADIfNeed];
        }];
//        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//                [self showADIfNeed];
//        }];
    }
    return self;
}

-(BOOL)checkADValid
{
    return true;
}
-(void)showADIfNeed
{
    if ([self checkADValid]) {//广告有效暂不请求网络
        [self buildADUI];
    }
    else
    {
        //网络请求广告
//        [IVAppManager getStartPageRedirectInfoCompletion:^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                  [self buildADUI];
//            });
//        }];
    }
}

-(void)buildADUI
{
    _adwindow=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _adwindow.rootViewController=[UIViewController new];
    _adwindow.rootViewController.view.backgroundColor=[UIColor clearColor];
    _adwindow.rootViewController.view.userInteractionEnabled=NO;
    
    [self buildSubViewsInWindow:_adwindow];
    _adwindow.windowLevel=UIWindowLevelStatusBar+1;
    _adwindow.hidden=NO;
    _adwindow.alpha=1;
    
}
-(UIImage*)getLaunchImage
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = nil;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {
        viewOrientation = @"Portrait";
    } else {
        viewOrientation = @"Landscape";
    }
    NSString *launchImage = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImage];
}

-(NSString*)getAdImage
{
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];

    return imageUrl;;
}
-(void)buildSubViewsInWindow:(UIWindow*)window
{
   
    
    UIImageView *laView = [[UIImageView alloc] initWithFrame:window.bounds];
    laView.backgroundColor = [UIColor whiteColor];
    
    [laView sd_setImageWithURL:[NSURL URLWithString:[self getAdImage]]
              placeholderImage:[self getLaunchImage]
                       options:SDWebImageRefreshCached];
    
//    NSString *redirect = [[NSUserDefaults standardUserDefaults] objectForKey:@"startpage"];
//    if(redirect != nil && redirect.length>0){
        laView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openRedirect)];
        [laView addGestureRecognizer:tap];
//    }
    [window addSubview:laView];
    
    UIButton *btn           = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame               = CGRectMake(SCREEN_WIDTH - 100, 20, 80, 25);
    btn.backgroundColor     = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
    btn.titleLabel.font     = SYSTEMFONT(14);
    btn.layer.cornerRadius  = 8;
    btn.layer.masksToBounds = YES;
    btn.tag                 = 200;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(endLaunch) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    self.downCountButton = btn;
    
    self.downCount = 3;
    [self timer];
}
-(void)endLaunch
{
    [self hide];
}

-(void)openRedirect
{
//    NSString *redirect = [[NSUserDefaults standardUserDefaults] objectForKey:@"startpage"];
    WSFBaseWebViewController *webVC = [[WSFBaseWebViewController alloc] init];
    webVC.url =@"http://hao123.com";
    UIViewController* currentVC=[[AppDelegate shareAppDelegate] getCurrentVC];
    WSFBaseNavigationController *loginNavi =[[WSFBaseNavigationController alloc] initWithRootViewController:webVC];
           [currentVC presentViewController:loginNavi animated:YES completion:nil];
    [self hide];
}
-(void)timer
{
    [self.downCountButton setTitle:[NSString stringWithFormat:@"跳过：%ld",(long)self.downCount] forState:UIControlStateNormal];
    if (self.downCount <= 0) {
        [self hide];
    }
    else {
        self.downCount --;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self timer];
        });
    }
}
- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.adwindow.alpha = 0;
    } completion:^(BOOL finished) {
        [self.adwindow.subviews.copy enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        self.adwindow.hidden = YES;
        self.adwindow = nil;
    }];
}

@end
