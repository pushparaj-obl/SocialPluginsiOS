//
//  OBLToken.m
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/12/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLToken.h"

@interface OBLToken ()

@end

@implementation OBLToken

+ (OBLToken *)tokenWithHTTPResponseBody:(NSString *)body {
    return [[[self class]alloc]initWithHTTPResponseBody:body];
}

- (id)initWithHTTPResponseBody:(NSString *)body {
    self = [super init];
	if (self) {
        
        if (body.length > 0) {
            NSArray *pairs = [body componentsSeparatedByString:@"&"];
            
            for (NSString *pair in pairs) {
                
                NSArray *elements = [pair componentsSeparatedByString:@"="];
                
                if (elements.count > 1) {
                    NSString *field = elements[0];
                    NSString *value = elements[1];
                    
                    if ([field isEqualToString:@"oauth_token"]) {
                        self.key = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    } else if ([field isEqualToString:@"oauth_token_secret"]) {
                        self.secret = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    }
                }
            }
        }
	}
    
    return self;
}

+ (NSString *)loadAccessToken {
    
    NSString * accessTokenString = [[NSUserDefaults standardUserDefaults]objectForKey:@"accessTokenString"];
    return accessTokenString;
}

+ (void)storeAccessToken:(NSString *)accessTokenString {
    
    [[NSUserDefaults standardUserDefaults] setObject:accessTokenString forKey:@"accessTokenString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

