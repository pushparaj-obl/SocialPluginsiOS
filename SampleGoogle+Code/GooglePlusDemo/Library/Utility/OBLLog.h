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

@interface OBLLog : NSObject

/*change state of googleplus debugging */
+ (void)setGooglePlusDebug:(BOOL)debugIn;

/*log the values for google plus if debugging is on*/
//for  google plus  only
+ (void)logGPMessage:(NSString *)message;

/* google plus  error log if error in login and debugging is ON*/
//for  google plus  only
+ (void)GPErrorLog:(NSError *)error;


@end
