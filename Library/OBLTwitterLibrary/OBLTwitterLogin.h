//
//  OBLTwitterLogin.h
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/13/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OBLToken.h"
#import "OBLConsumer.h"
#import "OBLCategories.h"
#import "OBLTwitterRequest.h"

static OBLToken * accessToken;
static NSString * authenticatedUsername;
static NSString * authenticatedID;

@interface OBLTwitterLogin : NSObject

// Set Twitter consumer key and secret
+ (void)setConsumerKey:(NSString *)key secret:(NSString *)secret;

+ (NSString *)getRequestTokenString;

+ (NSError *)finishAuthWithRequestToken:(OBLToken *)reqToken;

// Returns YES/NO based on if user is logged in already
+ (BOOL)isLoggedIn;

// Logout
+ (void)logout;

+ (OBLConsumer *)getConsumer;

@end
