//
//  FacebookLogin.h
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.

//OBLFacebookLoging class provide basic utilities for the facebook loging
//login, logout, loging with permissions.

//user has to call handleOpenUrl:(NSURL *)url in the application:openURL:sourceApplication:annotation: of UIApplicationDelegate...
//for handling url
//also call applicationActiveHandle in applicationDidBecomeActive:application for updating session info.

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "OBLLogin.h"
#import "OBLLog.h"
#import "OBLFacebookPermission.h"

/*typedef for completionhandler*/
typedef void (^FBCompletionHandler)(NSError *error);

/*typedef for new permission block completionhandler*/
typedef void (^FBNewCompletionHandler)();

@interface OBLFacebookLogin : NSObject <OBLLogin>


#pragma mark - Session handler

/*
 Restart any tasks that were paused (or not yet started) while the application was inactive.
 If the application was previously in the background, optionally refresh the user interface.
 */
+ (void)applicationActiveHandle;

/*handle the incoming URL and update session info*/
//call this function from [UIApplicationDelegate application:openURL:sourceApplication:annotation:]
+ (BOOL)handleOpenUrl:(NSURL *)url;

/*set the global state change handler*/
//call this method only if unable to assign a session state change handler explicitly
+ (void)sessionHandler:(FBSession *)session state:(FBSessionState)state;

#pragma mark - Login

/*checks if token is already available and lodded*/
+ (BOOL)isTokenLodded;

/*checks if user has already logged in or not. returns status*/
+ (BOOL)isLogin;

/*login with default permission*/
//default permission includes - name, profile-picture, gender, userID, list of friends and information that user made public.
//block-completion handler block with error if any.
+ (void)loginWithFBCompletionHandler:(FBCompletionHandler) block;

/*login with given read permission*/
//block- completion handler block with error if any.
//permission- read permissions
+ (void)loginWithFBReadPermissions:(NSArray *)permission
              andCompletionHandler:(FBCompletionHandler) block;

/*login with given publish permission*/
//block- completion handler block with error if any.
//permission- publish permissions
+ (void)loginWithFBPublishPermissions:(NSArray *)permission
                      defaultAudience:(OBLDefaultAudiance)defaultAudience
                 andCompletionHandler:(FBCompletionHandler) block;

#pragma mark - FacebookPermission

/*returns array of permission of the current active session*/
+ (NSArray*)getPermissions;

/*request new publish permission with completionhandler block*/
+ (void)requestNewPublishPermissions:(NSArray *)permission
                andCompletionHandler:(FBNewCompletionHandler) block;

/*request new read permission with completionhandler block*/
+ (void)requestNewReadPermissions:(NSArray *)permission
             andCompletionHandler:(FBNewCompletionHandler) block;

#pragma mark - Debug

/*changes to be made when session state change or handle the errors...*/
//for facebook only
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state;


@end
