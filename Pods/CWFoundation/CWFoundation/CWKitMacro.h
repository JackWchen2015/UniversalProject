//
//  CWKitMacro.h
//  Pods
//
//  Created by Jack Chen on 2020/10/6.
//

#ifndef CWKitMacro_h
#define CWKitMacro_h

//适配
#define IS_FUllSCREEN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)) : NO)

//
//系统控件的默认高度   目前所有的刘海屏的上下安全距离大小是一样的状态栏高度为44，底部高度为34。
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

//设备宽度 跟横竖屏的无关
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication]statusBarOriention])
#define DEVICE_WIDTH (IS_LANDSCAPE?[UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.width))
#define DEVICE_HEIGHT (IS_LANDSCAPE?[UIScreen mainScreen].bounds.size.width):([UIScreen mainScreen].bounds.size.height))

//屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define WidthScale    SCREEN_WIDTH / 375.f
#define HeightScale   SCREEN_HEIGHT / 667.f

#define SX(v) (WidthScale * v)
#define SY(v) (HeightScale * v)

// **************************************** FRAME ADAPTER ********************************************
#define CGRectMakeFrame(X,Y,W,H) CGRectMake((X) * WidthScale, (Y) * WidthScale, (W) * WidthScale,(H) * WidthScale) //适配

//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


//----------------------字体类---------------------------
#define FONT(NAME,FONTSIZE) [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define BOLDSYSTEMFONT(FONTSIZE)   [UIFont boldSystemFontOfSize:FONTSIZE]



//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]


//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

#endif /* CWKitMacro_h */
