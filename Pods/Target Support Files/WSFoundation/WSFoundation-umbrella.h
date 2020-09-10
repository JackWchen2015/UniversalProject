#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSData+CWAdd.h"
#import "NSDate+CWAdd.h"
#import "NSString+CWAdd.h"
#import "WSFoundation.h"

FOUNDATION_EXPORT double WSFoundationVersionNumber;
FOUNDATION_EXPORT const unsigned char WSFoundationVersionString[];

