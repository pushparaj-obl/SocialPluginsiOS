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


/*change state of googleplus debugging */
+ (void)setGooglePlusDebug:(BOOL)debugIn;

/*change state of twitter debugging */
+ (void)setTwitterDebug:(BOOL)debugIn;


#pragma mark - facebook

/*change state of facebook debugging */
+ (void)setFacebookDebug:(BOOL)debugIn;

/*log the values for facebook if debugging is on*/
//for facebook only
+ (void)logFBMessage:(NSString *)message;

/*facebook error log if error in login and debugging is ON*/
//for facebook only
+ (void)FBErrorLog:(NSError *)error;


@end
