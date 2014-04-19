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

//Used for facebook library - facebookDebug having state of debugging, if it's on of off
//user can set it when he wants to start facebook debugging.
static bool facebookDebug;

//Used for googleplus library - googlePlusDebug having state of debugging, if it's on of off
//user can set it when he wants to start GooglePlus debugging.
static bool googlePlusDebug;

//Used for twitter library - twitterDebug having state of debugging, if it's on of off
//user can set it when he wants to start Twitter debugging.
static bool twitterDebug;


#pragma mark - init

//initialize debug variable with NO
- (id)init
{
    self = [super init];
    if (self) {
        facebookDebug = NO;
        googlePlusDebug = NO;
        twitterDebug = NO;
    }
    return self;
}

#pragma mark - googleplus

//change state of google plus debugging
+ (void)setGooglePlusDebug:(BOOL)debugIn
{
    googlePlusDebug = debugIn;
}


//log the values for  google plus if debugging is on
//use this Google+ logs
+ (void)logGPMessage:(NSString *)message
{
    if (googlePlusDebug)
    {
        NSLog(@"%@",message);
    }
}

// google plus error log if error
//use this Google+ logs
+ (void)GPErrorLog:(NSError *)error
{
    if (googlePlusDebug)
    {
        if (error)
        {
            NSLog(@"Error: %@",error.description);
        }
    }
}



#pragma mark - twitter

//change state of facebook debugging
+ (void)setTwitterDebug:(BOOL)debugIn
{
    twitterDebug = debugIn;
}
#pragma mark - facebook

//change state of facebook debugging
//for facebook only
+ (void)setFacebookDebug:(BOOL)debugIn
{
    facebookDebug = debugIn;
}


//log the values for facebook if debugging is on
//for facebook only
+ (void)logFBMessage:(NSString *)message
{
    if (facebookDebug)
    {
        NSLog(@"%@",message);
    }
}

//facebook error log if error in login
//for facebook only
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
                    alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact facebook and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                    NSLog(@"%@ : %@ ",alertTitle,alertText);
                }
            }
            // Clear this token
            //[FBSession.activeSession closeAndClearTokenInformation];
            // Show the user the logged-out UI
            
        }   //error check close
        
    }   //debug check close
    
}


@end
