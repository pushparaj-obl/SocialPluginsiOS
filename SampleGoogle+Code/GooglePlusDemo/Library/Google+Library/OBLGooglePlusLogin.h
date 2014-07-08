//
//  OBLGooglePlusLogin.h
//  GooglePlusDemo
//
//  Created by Jeneena Jose on 2/11/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

//Provides basic functionalities which are
//logging in the user by giving a |authentication| object for the current user
//logging out the user
//and disconnectng the user from the app and revokes previous authentication.


#import <UIKit/UIKit.h>

#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "OBLGooglePlusLoginDelegate.h"
#import "OBLLog.h"
#import "GPLogin.h"

@class GPPSignInButton;

@interface OBLGooglePlusLogin : UIViewController <GPPSignInDelegate,GPLogin>

// The object to be notified when authentication is finished.
@property(nonatomic, weak) id<OBLGooglePlusLoginDelegate> delegate;

// The authentication object for the current user, or nil if there is
// currently no logged in user.
@property(nonatomic, strong) GTMOAuth2Authentication *authentication;

// The client ID of the app from the Google APIs console.
// Must set it before calling |login|
@property(nonatomic, strong) NSString *clientID;

// The API scopes requested by the app in an array of NSString.
// The default value is |@[@"https://www.googleapis.com/auth/plus.login"]|.
@property(nonatomic, strong) NSArray *scopes;


// All properties below are optional parameters. If they need to be set, set
// before calling |authenticate|.

// An NSString array of moment types used by your app. Use values from the
// full list at
// https://developers.google.com/+/api/moment-types .
// such as "http://schemas.google.com/AddActivity".
// This property is required only for writing moments, with
// "https://www.googleapis.com/auth/plus.login" as a scope.
@property(nonatomic, strong) NSArray *actions;

// Whether or not to fetch user email after signing in. The email is saved in
// the |GTMOAuth2Authentication| object. Note that using this flag automatically
// adds "https://www.googleapis.com/auth/userinfo.email" scope to the request.
@property(nonatomic) BOOL shouldFetchGoogleUserEmail;

// Whether or not to fetch user ID after signing in. The ID can be retrieved
// by googleUserID after user has been authenticated. Note that using this
// flag automatically adds "https://www.googleapis.com/auth/userinfo.profile"
// scope to the request if a scope that provides user ID is not already present.
@property(nonatomic) BOOL shouldFetchGoogleUserID;

// Whether or not to fetch Google+ user profile after signing in. The user
// profile object can be retrieved by googlePlusUser after user has been
// authenticated. Note that using this flag automatically adds
// "https://www.googleapis.com/auth/plus.me" scope to the request if needed.
@property(nonatomic) BOOL shouldFetchGooglePlusUser;

// Returns a shared |OBLGooglePlusLogin| instance.
+ (OBLGooglePlusLogin  *)sharedInstance;

// Attempts to authenticate silently without user interaction.
// Returns YES and calls the delegate if the user has either currently signed
// in or has previous authentication saved in keychain.
// Note that if the previous authentication was revoked by the user, this method
// still returns YES but |finishedWithAuth:error:| callback will indicate
// that authentication has failed.
- (BOOL)trySilentAuthentication;

// The Google user ID. It is only available if |shouldFetchGoogleUserID| is set
// and either |trySilentAuthentication| or |authenticate| has been completed
// successfully.
@property(nonatomic, strong, readonly) NSString *userID;

// The Google user's email. It is only available if |shouldFetchGoogleUserEmail|
// is set and either |trySilentAuthentication| or |authenticate| has been
// completed successfully.
@property(nonatomic, strong, readonly) NSString *userEmail;

// If setloginUsingInstalledApp has value true,it sets |attemptSSO| to true and hence the sign-in button tries to authenticate with the
// Google+ application if it is installed. If false, it always uses Google+ via
// Chrome for iOS, if installed, or Mobile Safari for authentication.
@property (nonatomic) BOOL loginUsingInstalledApp;

// Disconnects the user from the app and revokes previous authentication.
// The token is needed to disconnect so do not call |logout| if |disconnect| is
// to be called.
- (void)disconnect;

// This method should be called from your |UIApplicationDelegate|'s
// |application:openURL:sourceApplication:annotation|.
- (BOOL)handleURL:(NSURL *)url  sourceApplication:(NSString *)sourceApplication  annotation:(id)annotation;


@end
