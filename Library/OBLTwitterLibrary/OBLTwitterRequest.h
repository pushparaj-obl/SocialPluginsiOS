//
//  OBLTwitterRequest.h
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/14/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import "OBLCategories.h"
#import "OBLConsumer.h"
#import "OBLToken.h"
#import "OBLTwitterLogin.h"
#import "OBLLog.h"

@interface OBLTwitterRequest : NSObject

+ (void)signRequest:(NSMutableURLRequest *)request withToken:(NSString *)tokenString tokenSecret:(NSString *)tokenSecretString verifier:(NSString *)verifierString consumer:(OBLConsumer *)consumer;
+ (id)sendRequest:(NSURLRequest *)request;
+ (void)signRequest:(NSMutableURLRequest *)request consumer:(OBLConsumer *)consumer;
+ (NSError *)sendPOSTRequestForURL:(NSURL *)url andParams:(NSDictionary *)params;

@end
