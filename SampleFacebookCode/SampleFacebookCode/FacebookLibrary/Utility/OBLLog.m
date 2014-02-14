//
//  OBLLog.m
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//import this class and set debug to YSE to turn on the error logs.

#import "OBLLog.h"

@implementation OBLLog

/*debug having state of debugging, if it's on of off*/
//user can set it when he wants to start logs.
static bool debug;

/*Used for facebook library - facebookDebug having state of debugging, if it's on of off*/
//user can set it when he wants to start facebook debugging.
static bool facebookDebug;

/*Used for googleplus library - googlePlusDebug having state of debugging, if it's on of off*/
//user can set it when he wants to start facebook debugging.
static bool googlePlusDebug;

/*Used for twitter library - twitterDebug having state of debugging, if it's on of off*/
//user can set it when he wants to start facebook debugging.
static bool twitterDebug;


#pragma mark - init

/*initialize debug variable with NO*/
- (id)init
{
    self = [super init];
    if (self) {
        debug = NO;
        facebookDebug = NO;
        googlePlusDebug = NO;
        twitterDebug = NO;
    }
    return self;
}

#pragma mark - logic

/*change state of debugging - logs */
+ (void)setDebug:(BOOL)debugIn
{
    debug=debugIn;
}

/*change state of facebook debugging */
+ (void)setFacebookDebug:(BOOL)debugIn
{
    facebookDebug=debugIn;
}

/*change state of facebook debugging */
+ (void)setGooglePlusDebug:(BOOL)debugIn
{
    googlePlusDebug=debugIn;
}

/*change state of facebook debugging */
+ (void)setTwitterDebug:(BOOL)debugIn
{
    twitterDebug=debugIn;
}

/*log the values if debugging is on*/
+ (void)logMessage:(NSString *)message
{
    if (debug)
    {
        NSLog(@"%@",message);
    }
}

//changes to be made when session state change or handle the errors...
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state
{
    if (debug)
    {
        // If the session was opened successfully
        if (state == FBSessionStateOpen)
        {
            NSLog(@"Session opened");
            // Show the user the logged-in UI
            return;
        }
        if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed)
        {
            // If the session is closed
            NSLog(@"Session closed");
            // Show the user the logged-out UI
            
        }
    }
}


/*error log if error in login*/
+ (void)FBErrorLog:(NSError *)error
{
    if (facebookDebug)
    {
        if (error)
        {
            NSLog(@"Error");
            NSString *alertText;
            NSString *alertTitle;
            // If the error requires people using an app to make an action outside of the app in order to recover
            if ([FBErrorUtility shouldNotifyUserForError:error] == YES)
            {
                alertTitle = @"Something went wrong";
                alertText = [FBErrorUtility userMessageForError:error];
                NSLog(@"%@ : %@ ",alertTitle,alertText);
            }
            else
            {
                // If the user cancelled login, do nothing
                if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled)
                {
                    NSLog(@"User cancelled login");
                    
                    // Handle session closures that happen outside of the app
                }
                else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession)
                {
                    alertTitle = @"Session Error";
                    alertText = @"Your current session is no longer valid. Please log in again.";
                    NSLog(@"%@ : %@ ",alertTitle,alertText);
                    // For simplicity, here we just show a generic message for all other errors
                }
                else
                {
                    //Get more error information from the error
                    NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                    
                    // Show the user an error message
                    alertTitle = @"Something went wrong";
                    alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                    NSLog(@"%@ : %@ ",alertTitle,alertText);
                }
            }
            // Clear this token
            [FBSession.activeSession closeAndClearTokenInformation];
            // Show the user the logged-out UI
            
        }   //error check close
        
    }   //debug check close
    
}


@end
