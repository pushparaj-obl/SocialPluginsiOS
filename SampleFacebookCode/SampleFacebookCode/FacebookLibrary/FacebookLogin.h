//
//  FacebookLogin.h
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.

//FacebookLoging class provide basic utilities for the facebook loging
//login, logout, loging with permissions.

//user has to implement application:openURL:sourceApplication:annotation: of UIApplicationDelegate... for handling url

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "OBLLogin.h"

typedef void (^FBCompletionHandler)();

@interface FacebookLogin : NSObject <login>

/*login with default permission*/
//block-comlition handler block
+ (NSError *)loginWithFBCompletionHandler:(FBCompletionHandler) block;

/*login with given read permission*/
//block-comlition handler block
//permission- read permissions
+ (NSError *)loginWithFBReadPermissions:(NSArray *)permission andCompletionHandler: (FBCompletionHandler) block;

/*login with given publish permission*/
//block-comlition handler block
//permission- publish permissions
+ (NSError *)loginWithFBPublishPermissions:(NSArray *)permission andCompletionHandler: (FBCompletionHandler) block;


/*changes to be made when session state change or handle the errors...*/
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state;

/*logs error if any if debbuging mode is ON*/
+ (void)errorLog:(NSError *)error;

/*logout from facebook - current session*/
//returns YES if logged out otherwise NO
+ (BOOL)logout;

/*checks if user has already logged in or not. returns status*/
+ (BOOL)isLogin;

/*turn debugging mode on or off*/
+ (void)debugON:(BOOL)on;


@end
