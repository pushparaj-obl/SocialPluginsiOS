//
//  OBLCategories.h
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/12/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonHMAC.h>
#import <objc/runtime.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <ifaddrs.h>

@interface NSString (OBLTwitterLibrary)

- (NSString *)fhs_URLEncode;
- (NSString *)fhs_trimForTwitter;
- (NSString *)fhs_stringWithRange:(NSRange)range;
+ (NSString *)fhs_UUID;
- (BOOL)fhs_isNumeric;

@end


@interface NSData (OBLTwitterLibrary)

//- (NSString *)appropriateFileExtension;
- (NSString *)base64Encode;

@end

@interface NSError (OBLTwitterLibrary)

+ (NSError *)badRequestError;
+ (NSError *)noDataError;
+ (NSError *)imageTooLargeError;

@end