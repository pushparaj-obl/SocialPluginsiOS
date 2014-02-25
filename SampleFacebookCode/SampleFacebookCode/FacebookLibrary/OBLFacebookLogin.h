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

@interface OBLFacebookLogin : NSObject <OBLLogin>

typedef enum {
    /*! No audience needed; this value is useful for cases where data will only be read from Facebook */
    OBLDefaultAudienceNone                = 0,
    /*! Indicates that only the user is able to see posts made by the application */
    OBLDefaultAudienceOnlyMe              = 10,
    /*! Indicates that the user's friends are able to see posts made by the application */
    OBLDefaultAudienceFriends             = 20,
    /*! Indicates that all Facebook users are able to see posts made by the application */
    OBLDefaultAudienceEveryone            = 30,
} OBLDefaultAudiance;



#pragma mark - Session handler

/*
Restart any tasks that were paused (or not yet started) while the application was inactive.
If the application was previously in the background, optionally refresh the user interface.
*/
+ (void)applicationActiveHandle;

/*handle the incoming URL and update session info*/
//call this function from [UIApplicationDelegate application:openURL:sourceApplication:annotation:]
+ (BOOL)handleOpenUrl:(NSURL *)url;

#pragma mark - Login

/*checks if token is already available and loaded of not*/
//it will check if availabele token is already lodded do we can call login method directly.(session state may not be open)
+ (BOOL)isTokenLodded;


/*checks if user has already logged in or not. returns status*/
//it will check if user is logged in (session state is open or not)
+ (BOOL)isLogin;

/*login with default permission*/
//default permission includes - name, profile-picture, gender, userID, list of friends and information that user made public.
//block-completion handler block with error if any.
+ (void)loginWithFBCompletionHandler:(FBCompletionHandler) block;

/*login with given read permission, user will also get basic info permissions*/
//default permission includes - name, profile-picture, gender, userID, list of friends and information that user made public.
//block- completion handler block with error if any.
//permission- read permissions
+ (void)loginWithFBReadPermissions:(NSArray *)permission
              andCompletionHandler:(FBCompletionHandler) block;

/*login with given publish permission, user will also get basic info permissions*/
//default permission includes - name, profile-picture, gender, userID, list of friends and information that user made public.
//block- completion handler block with error if any.
//permission- publish permissions
+ (void)loginWithFBPublishPermissions:(NSArray *)permission
                      defaultAudience:(OBLDefaultAudiance)defaultAudience
                 andCompletionHandler:(FBCompletionHandler) block;

#pragma mark - FacebookPermission

/*returns array of permission of the current active session*/
+ (NSArray*)getPermissions;

/*request new read permission with completionhandler block*/
+ (void)requestNewReadPermissions:(NSArray *)permission
             andCompletionHandler:(FBCompletionHandler) block;

/*request new publish permission with completionhandler block*/
+ (void)requestNewPublishPermissions:(NSArray *)permission
                     defaultAudience:(OBLDefaultAudiance)defaultAudience
                andCompletionHandler:(FBCompletionHandler) block;

#pragma mark - Debug

/*changes to be made when session state change or handle the errors...*/
//for facebook only
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state;


@end
