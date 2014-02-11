//
//  OBLLog.m
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "OBLLog.h"

@implementation OBLLog

/*debug having state of debugging, if it's on of off*/
//user can set it when he wants to start logs.
static bool debug;

#pragma mark - init

/*initialize debug variable with NO*/
- (id)init
{
    self = [super init];
    if (self) {
        debug = NO;
    }
    return self;
}

#pragma mark - logic

/*change state of debugging */
+ (void)setDebug:(BOOL)debugIn
{
    debug=debugIn;
}

/*get the state of debugging mode*/
+ (BOOL)getDebug
{
    return debug;
}

/*log the values if debugging is on*/
+ (void)logMessage:(NSString *)message
{
    if (debug)
    {
        NSLog(@"%@",message);
    }
}

@end
