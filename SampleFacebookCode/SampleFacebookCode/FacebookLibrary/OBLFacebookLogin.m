//
//  FacebookLogin.m
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//FacebookLoging class provide basic utilities for the facebook loging
//login, logout, loging with permissions.

//user has to call handleOpenUrl:(NSURL *)url in the application:openURL:sourceApplication:annotation: of UIApplicationDelegate...
//for handling url
//also call applicationActiveHandle in applicationDidBecomeActive:application for updating session info.

#import "OBLFacebookLogin.h"

@implementation OBLFacebookLogin

#pragma mark - Session handler

/*
Restart any tasks that were paused (or not yet started) while the application was inactive.
If the application was previously in the background, optionally refresh the user interface.
*/
+ (void)applicationActiveHandle
{
    [FBAppCall handleDidBecomeActive];
}

/*handle the incoming URL and update session info*/
//call this function from [UIApplicationDelegate application:openURL:sourceApplication:annotation:]
+ (BOOL)handleOpenUrl:(NSURL *)url
{
    return [FBSession.activeSession handleOpenURL:url];
}

/*set the global state change handler*/
//call this method only if unable to assign a session state change handler explicitly
+ (void)sessionHandler:(FBSession *)session state:(FBSessionState)state
{
    [FBSession.activeSession setStateChangeHandler:
     ^(FBSession *session, FBSessionState state, NSError *error)
     {
         if (error)
         {
             [OBLLog FBErrorLog:error];
         }
         else
         {
             [OBLFacebookLogin sessionStateChanged:session state:state];
         }
     }];
}

#pragma mark - Login

/*checks if user has already logged in or not. returns status*/
+ (BOOL)isLogin
{
    return (FBSession.activeSession.state == FBSessionStateOpen||FBSession.activeSession.state == FBSessionStateOpenTokenExtended);
}


/* basic login method with default permission and nil completionhandler */
//default permission includes - name, profile-picture, gender, userID, list of friends and information that user made public.
+ (void)login
{
    [OBLFacebookLogin login:@[BASIC_INFO] withCompltion:nil];
}


/*login with default permission*/
//default permission includes - name, profile-picture, gender, userID, list of friends and information that user made public.
//block-completion handler block with error if any.
+ (void)loginWithFBCompletionHandler:(FBCompletionHandler) block
{
    [OBLFacebookLogin login:@[BASIC_INFO] withCompltion:block];
    
}

/*login with given read permission*/
//block-completion handler block with error if any.
//permission- read permissions

+ (void)loginWithFBReadPermissions:(NSArray *)permission
                    andCompletionHandler: (FBCompletionHandler) block
{
    [OBLFacebookLogin login:permission withCompltion:block];
    
}

/*private method for login with read permissions or login with basic info*/
//block-completion handler block with error if any.
+ (void)login:(NSArray*)permission withCompltion:(FBCompletionHandler)block
{
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
    {
        NSLog(@"Found a cached session");
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:permission
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          if (error)
                                          {
                                              [OBLLog FBErrorLog:error];
                                          }
                                          else
                                          {
                                              [OBLFacebookLogin sessionStateChanged:session state:state];
                                          }
                                          dispatch_async(dispatch_get_main_queue(),
                                                         ^{
                                                             block(error);
                                                         });
                                      }];
        // If there's no cached session..
    }
    else
    {
        FBSession *session = [[FBSession alloc] initWithPermissions:permission];
        // Set the active session
        [FBSession setActiveSession:session];
        // Open the session
        
        [session openWithBehavior:FBSessionLoginBehaviorWithFallbackToWebView
                completionHandler:^(FBSession *session,
                                    FBSessionState state,
                                    NSError *error) {
                    if (error)
                    {
                        [OBLLog FBErrorLog:error];
                    }
                    else
                    {
                        [OBLFacebookLogin sessionStateChanged:session state:state];
                    }
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       block(error);
                                   });
                }];
    }
}

/*login with given publish permission*/
//block - comlition handler block with error if any.
//permission - publish permissions
+ (void) loginWithFBPublishPermissions:(NSArray *)permission
                       defaultAudience:(OBLDefaultAudiance)defaultAudience
                  andCompletionHandler:(FBCompletionHandler) block
{
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
    {
        NSLog(@"Found a cached session");
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithPublishPermissions:permission
                                           defaultAudience:(FBSessionDefaultAudience)defaultAudience
                                              allowLoginUI:NO
                                         completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                             // Handler for session state changes
                                             // This method will be called EACH time the session state changes,
                                             if (error)
                                             {
                                                 [OBLLog FBErrorLog:error];
                                             }
                                             else
                                             {
                                                 [OBLFacebookLogin sessionStateChanged:session state:state];
                                             }
                                             dispatch_async(dispatch_get_main_queue(),
                                                            ^{
                                                                block(error);
                                                            });
                                         }];
        
        // If there's no cached session..
    }
    else
    {
        FBSession *session = [[FBSession alloc] initWithPermissions:permission];
        // Set the active session
        [FBSession setActiveSession:session];
        // Open the session
        
        [session openWithBehavior:FBSessionLoginBehaviorWithFallbackToWebView
                completionHandler:^(FBSession *session,
                                    FBSessionState state,
                                    NSError *error) {
                    //AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                    if (error)
                    {
                        [OBLLog FBErrorLog:error];
                    }
                    else
                    {
                        [OBLFacebookLogin sessionStateChanged:session state:state];
                    }
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       block(error);
                                   });
                }];
    }
}

#pragma mark - Logout

/*logout from facebook - current session*/
//implementation of method logout of OBLLogin protocol
+ (void)logout
{
    [FBSession.activeSession closeAndClearTokenInformation];
}

#pragma mark - FacebookPermission

/*returns array of permission of the current active session*/
+ (NSArray*)getPermissions
{
    return ([FBSession activeSession].accessTokenData.permissions);
}

/*request new publish permission with completionhandler block*/
+ (void)requestNewPublishPermissions:(NSArray *)permission
                andCompletionHandler:(FBNewCompletionHandler) block
{
    [FBSession.activeSession requestNewPublishPermissions:permission
                                          defaultAudience:FBSessionDefaultAudienceFriends
                                        completionHandler:^(FBSession *session, NSError *error)
     {
         if (!error)
         {
             BOOL granted = YES;
             for (NSObject *a in permission)
             {
                 if ([FBSession.activeSession.permissions indexOfObject:a] == NSNotFound)
                 {
                     // Permission not granted
                     [OBLLog logFBMessage:@"Permission not granted"];
                     granted = NO;
                     break;
                 }
             }
             if(granted)
             {
                 // Permission granted, call the handler block
                 dispatch_async(dispatch_get_main_queue(),
                                ^{
                                    block();
                                });
             }
         }
         else
         {
             [OBLLog logFBMessage:error.description];
         }
     }
     ];
}


/*request new read permission with completionhandler block*/
+ (void)requestNewReadPermissions:(NSArray *)permission
             andCompletionHandler:(FBNewCompletionHandler) block
{
    [FBSession.activeSession requestNewReadPermissions:permission
                                     completionHandler:^(FBSession *session, NSError *error)
     {
         if (!error)
         {
             BOOL granted = YES;
             for (NSObject *a in permission)
             {
                 if ([FBSession.activeSession.permissions indexOfObject:a] == NSNotFound)
                 {
                     // Permission not granted
                     [OBLLog logFBMessage:@"Permission not granted"];
                     granted = NO;
                     break;
                 }
             }
             if(granted)
             {
                 // Permission granted, call the handler block
                 dispatch_async(dispatch_get_main_queue(),
                                ^{
                                    block();
                                });
             }
         }
         else
         {
             [OBLLog logFBMessage:error.description];
         }
     }
     ];
}

#pragma mark - Debug

//changes to be made when session state change or handle the errors...
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state
{
    // If the session was opened successfully
    if (state == FBSessionStateOpen)
    {
        [OBLLog logFBMessage:@"Session opened"];
        // Show the user the logged-in UI
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed)
    {
        // If the session is closed
        [OBLLog logFBMessage:@"Session closed"];
        // Show the user the logged-out UI
    }
}

@end
