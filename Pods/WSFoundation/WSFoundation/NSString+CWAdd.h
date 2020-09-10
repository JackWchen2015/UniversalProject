//
//  NSString+CWAdd.h
//  FBSnapshotTestCase
//
//  Created by JackChen on 2019/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CWAdd)
- (nullable NSString *)md5String;
/**
 Returns an NSString for base64 encoded.
 Base64是一种基于64个可打印字符来表示二进制数据的表示方法 可打印字符包括字母A-Z、a-z、数字0-9，这样共有62个字符，此外两个可打印符号在不同的系统中而不同,常用于在通常处理文本数据的场合，表示、传输、存储一些二进制数据
 */
- (nullable NSString *)base64EncodedString;

/**
 Returns an NSString from base64 encoded string.
 @param base64EncodedString The encoded string.
 */
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 nil, @"", @"  ", @"\n" will Returns NO; otherwise Returns YES.
 */
- (BOOL)isNotBlank;

/**
 Trim blank characters (space and newline) in head and tail.
 @return the trimmed string.
 */
- (NSString *)stringByTrim;
@end

NS_ASSUME_NONNULL_END
