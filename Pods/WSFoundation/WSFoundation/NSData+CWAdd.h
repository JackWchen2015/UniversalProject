//
//  NSData+CWAdd.h
//  FBSnapshotTestCase
//
//  Created by JackChen on 2019/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CWAdd)
- (NSString *)md5String;
/**
 Returns an NSString for base64 encoded.
 */
- (nullable NSString *)base64EncodedString;
/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (nullable NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;

/**
 Returns string decoded in UTF8.
 */
- (nullable NSString *)utf8String;

/**
 Returns a uppercase NSString in HEX.
 */
- (nullable NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
