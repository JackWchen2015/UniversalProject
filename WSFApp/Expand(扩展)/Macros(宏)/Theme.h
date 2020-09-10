//
//  WSFApp
//
//  Created by USER on 2020/9/7.
//  Copyright © 2020 USER. All rights reserved.
//

#ifndef Theme_h
#define Theme_h

#pragma mark -  * * * * * * * * * * * * * * 主题 * * * * * * * * * * * * * *
/**
 *  无色
 */
#define kClearColor [UIColor clearColor]
/**
 *  默认页面背景色
 */
#define DefaultBackGroundColor HEXRGB(0Xf5f7fa)
/**
 *  默认白色
 */
#define WhiteColor HEXRGB(0Xffffff)
/**
 *  主题颜色
 */
#define ThemeColor HEXRGB(0X0096f4)
/**
 *  page control default color
 */
#define kPageDefaultColor HEXRGB(0X828CA1)
/**
 *  主题辅助颜色（状态，提示等...）
 */
#define OrangeColor HEXRGB(0Xef5a50)
/**
 *  遮盖半透明色
 */
#define kCoverColor [HEXRGB(0X000000)colorWithAlphaComponent:0.3]

/**
 *  分割线灰色等...
 */
#define kBackDefaultGrayColor HEXRGB(0Xdbdfe8)
/**
 *  主要字体颜色
 */
#define kMainFontColor HEXRGB(0X333333)
/**
 *  次要字体颜色
 */
#define kSecondaryFontColor HEXRGB(0X999999)
/**
 *  辅助字体颜色
 */
#define kAuxiliaryFontColor HEXRGB(0Xcccccc)
/**
 *  默认字体颜色(非点击状态)
 */
#define kNormalFontColor HEXRGB(0X999999)


#pragma mark -  * * * * * * * * * * * * * * set Font * * * * * * * * * * * * * *
/**
 *  10号字体
 */
#define TenFontSize [UIFont systemFontOfSize:10]
/**
 *  11号字体
 */
#define ElevenFontSize [UIFont systemFontOfSize:11]
/**
 *  12号字体
 */
#define TwelveFontSize [UIFont systemFontOfSize:12]
/**
 *  13号字体
 */
#define ThirteenFontSize [UIFont systemFontOfSize:13]
/**
 *  14号字体
 */
#define FourteenFontSize [UIFont systemFontOfSize:14]
/**
 *  15号字体
 */
#define FifteenFontSize [UIFont systemFontOfSize:15]
/**
 *  17号字体
 */
#define SeventeenFontSize [UIFont systemFontOfSize:17]
/**
 *  18号字体
 */
#define EighteenFontSize [UIFont systemFontOfSize:18]
/**
 *  20号字体
 */
#define TwentyFontSize [UIFont systemFontOfSize:20]




#pragma mark -  * * * * * * * * * * * * * * set Button * * * * * * * * * * * * * *
/**
 *  按钮的背景默认颜色
 */
#define kButtonBackColorForNormal HEXRGB(0X0097f4)
/**
 *  按钮的背景点击颜色
 */
#define kButtonBackColorForSelect HEXRGB(0X008ce3)
/**
 *  按钮的背景不可点击颜色
 */
#define kButtonBackColorForDisabled HEXRGB(0X7fcaf9)
/**
 *  按钮的圆角
 */
#define kButtonCornerRad 5

/**
 *  R,G,B ／ A
 */
#define kRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define kRGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
/**
 *  十六进制颜色
 */
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/**
 *  随机色
 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


#endif /* Theme_h */
