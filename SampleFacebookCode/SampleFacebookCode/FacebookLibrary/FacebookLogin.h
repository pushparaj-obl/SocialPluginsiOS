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

//@property (nonatomic,strong)

/*handle the incoming URL and update session info*/
//call this function from [UIApplicationDelegate application:openURL:sourceApplication:annotation:]
+ (BOOL)handleOpenUrl:(NSURL *)url;

/*set the global state change handler*/
//call this method only if unable to assign a session state change handler explicitly
+ (void)sessionHandler:(FBSession *)session state:(FBSessionState)state;


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

/*checks if user has already logged in or not. returns status*/
+ (BOOL)isLogin;



/*logout from facebook - current session*/
//returns YES if logged out otherwise NO
+ (BOOL)logout;



/*returns array of permission of the current active session*/
+ (NSArray*)getPermissions;

/*request new publish permission with completionhandler block*/
+ (void)requestNewPublishPermissions:(NSArray *)permission
                andCompletionHandler: (FBCompletionHandler) block;

/*request new read permission with completionhandler block*/
+ (void)requestNewReadPermissions:(NSArray *)permission
             andCompletionHandler: (FBCompletionHandler) block;


/*logs error if any if debbuging mode is ON*/
+ (void)errorLog:(NSError *)error;

/*changes to be made when session state change or handle the errors...*/
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state;

/*turn debugging mode on or off*/
+ (void)debugON:(BOOL)on;


@end
