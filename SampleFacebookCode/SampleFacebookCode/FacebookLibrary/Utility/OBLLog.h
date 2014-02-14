//
//  OBLLog.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//call this class and set debug to YSE to turn on the error logs.
//for facebook, googleplus and twitter additional debuggin use setFacebookDebug:, setGooglePlusDebug and setTwitterDebug respectively.

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface OBLLog : NSObject

/*change state of facebook debugging */
+ (void)setFacebookDebug:(BOOL)debugIn;

/*change state of googleplus debugging */
+ (void)setGooglePlusDebug:(BOOL)debugIn;

/*change state of twitter debugging */
+ (void)setTwitterDebug:(BOOL)debugIn;


/*log the values if debugging is on*/
//any one can use it. change method accordingly.
+ (void)logMessage:(NSString *)message;

/*changes to be made when session state change or handle the errors...*/
//for facebook only
+ (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state;

/*logs error if any if debbuging mode is ON*/
//for facebook only
+ (void)FBErrorLog:(NSError *)error;


@end
