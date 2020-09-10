//
//  WSFApp
//
//  Created by USER on 2020/9/7.
//  Copyright © 2020 USER. All rights reserved.
//
/**
 *  Bounds
 */
#define UI_Window [UIApplication sharedApplication].keyWindow
#define UI_ScreenBounds [[UIScreen mainScreen] bounds]
#define UI_ScreenWidth kScreenBounds.size.width
#define UI_ScreenHeight kScreenBounds.size.height
/**
 *  Version
 */
#define kVersion [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]
#define kSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
/**
 *  Network
 */
#define kNetworkType [AppUtility getNetworkType]
/**
 *  NotificationCenter
 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]
/**
 *  iPhone or iPad
 */
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
/**
 *  NSLog
 */
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
/**
*  AppDelegate对象
*/
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]
/**
*  获取图片资源
*/
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
/**
*  Library/Caches 文件路径
*/
#define FilePath ([[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil])
/**
*  获取temp
*/
#define kPathTemp NSTemporaryDirectory()
/**
*  获取沙盒 Document
*/
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/**
*  获取沙盒 Cache
*/
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
/**
*  在Main线程上运行
*/
#define DISPATCH_ON_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
/**
*  弱引用/强引用  可配对引用在外面用WSFWeakSelf(self)，block用WSFStrongSelf(self)
*/
#define WSFWeakSelf(type)  __weak typeof(type) weak##type = type;
#define WSFStrongSelf(type)  __strong typeof(type) type = weak##type;


//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
//
//#endif
