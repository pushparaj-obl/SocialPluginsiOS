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


//Used for googleplus library - googlePlusDebug having state of debugging, if it's on of off
//user can set it when he wants to start GooglePlus debugging.
static bool googlePlusDebug;


#pragma mark - init

//initialize debug variable with NO
- (id)init
{
    self = [super init];
    if (self) {
        googlePlusDebug = NO;
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

@end
