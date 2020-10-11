//
//  WSFThemeMacros.h
//  WSFApp
//
//  Created by jack on 2020/9/14.
//  Copyright © 2020 USER. All rights reserved.
//

#ifndef WSFThemeMacros_h
#define WSFThemeMacros_h

//存放App特有主题相关的宏定义

//默认间距
#define KNormalSpace 12.0f


#pragma mark -  颜色区
//主题色 导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"00AE68"]
//#define CNavBgColor  [Ulor colorWithHexString:@"ffffff"]
#define CNavBgFontColor  [UIColor colorWithHexString:@"ffffff"]

//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"f2f2f2"]

//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"ededed"]


//颜色
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]        //随机色生成

#endif /* WSFThemeMacros_h */
