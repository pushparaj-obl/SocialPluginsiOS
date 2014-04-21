//
//  OBLToken.h
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/12/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBLToken : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *verifier;

+ (OBLToken *)tokenWithHTTPResponseBody:(NSString *)body;
+ (void)storeAccessToken:(NSString *)accessTokenString;
+ (NSString *)loadAccessToken;

@end