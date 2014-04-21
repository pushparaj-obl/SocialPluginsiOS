//
//  OBLTwitterLogin.m
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/13/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLTwitterLogin.h"

static OBLConsumer * consumer;

@interface OBLTwitterLogin ()

@end

@implementation OBLTwitterLogin

// Set Twitter consumer key and secret
+ (void)setConsumerKey:(NSString *)key secret:(NSString *)secret
{
    consumer = [OBLConsumer consumerWithKey:key secret:secret];
}

+ (OBLConsumer *)getConsumer
{
    return consumer;
}

+ (NSString *)getRequestTokenString {
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/oauth/request_token"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    [OBLTwitterRequest signRequest:request withToken:nil tokenSecret:nil verifier:nil consumer:consumer];
    
    id retobj = [OBLTwitterRequest sendRequest:request];
    
    if ([retobj isKindOfClass:[NSData class]]) {
        return [[NSString alloc]initWithData:(NSData *)retobj encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

+ (NSError *)finishAuthWithRequestToken:(OBLToken *)reqToken {
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/oauth/access_token"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    [OBLTwitterRequest signRequest:request withToken:reqToken.key tokenSecret:reqToken.secret verifier:reqToken.verifier consumer:consumer];
    
    id retobj = [OBLTwitterRequest sendRequest:request];
    
    if ([retobj isKindOfClass:[NSError class]]) {
        return retobj;
    }
    
    NSString *response = [[NSString alloc]initWithData:(NSData *)retobj encoding:NSUTF8StringEncoding];
    
    if (response.length == 0) {

        NSMutableDictionary * details = [NSMutableDictionary dictionary];
        [details setValue:@"Unexpected error. Access token is empty" forKey:NSLocalizedDescriptionKey];
        NSError * error = [NSError errorWithDomain:@"OBLTwitter" code:-1 userInfo:details];
        return error;
    }
    
    [OBLTwitterLogin storeAccessToken:response];
    
    return nil;
}

// Get accesstoken
+ (void)loadAccessToken {
    
    NSString * savedHttpBody = [OBLToken loadAccessToken];
    
    accessToken = [OBLToken tokenWithHTTPResponseBody:savedHttpBody];
    authenticatedUsername = [self extractValueForKey:@"screen_name" fromHTTPBody:savedHttpBody];
    authenticatedID = [self extractValueForKey:@"user_id" fromHTTPBody:savedHttpBody];
}

// Save accesstoken
+ (void)storeAccessToken:(NSString *)accessTokenZ {
    accessToken = [OBLToken tokenWithHTTPResponseBody:accessTokenZ];
    authenticatedUsername = [self extractValueForKey:@"screen_name" fromHTTPBody:accessTokenZ];
    authenticatedID = [self extractValueForKey:@"user_id" fromHTTPBody:accessTokenZ];

    [OBLToken storeAccessToken:accessTokenZ];
}

// Checks if user is authorized
+ (BOOL)isAuthorized {
    if (!consumer) {
        return NO;
    }
    
	if (accessToken.key && accessToken.secret) {
        if (accessToken.key.length > 0 && accessToken.secret.length > 0) {
            return YES;
        }
    }
    
	return NO;
}

// Checks if user is logged in
+ (BOOL)isLoggedIn
{
    [self loadAccessToken];    
    return (accessToken.key && accessToken.secret);
}

+ (NSString *)extractValueForKey:(NSString *)target fromHTTPBody:(NSString *)body {
    if (body.length == 0) {
        return nil;
    }
    
    if (target.length == 0) {
        return nil;
    }
	
	NSArray *tuples = [body componentsSeparatedByString:@"&"];
	if (tuples.count < 1) {
        return nil;
    }
	
	for (NSString *tuple in tuples) {
		NSArray *keyValueArray = [tuple componentsSeparatedByString:@"="];
		
		if (keyValueArray.count >= 2) {
			NSString *key = [keyValueArray objectAtIndex:0];
			NSString *value = [keyValueArray objectAtIndex:1];
			
			if ([key isEqualToString:target]) {
                return value;
            }
		}
	}
	
	return nil;
}

// Logout
+ (void)logout
{
    [self clearAccessToken];
    [OBLLog logMessage:@"Logged out of Twitter."];
}

// Remove accesstoken
+ (void)clearAccessToken
{
    [self storeAccessToken:@""];
    accessToken = nil;
    authenticatedID = nil;
}

@end
