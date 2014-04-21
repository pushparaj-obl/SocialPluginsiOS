//
//  OBLLog.m
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "OBLLog.h"

@implementation OBLLog

// Used to set debugging ON/OFF
static bool twitterDebug;

#pragma mark - init

/*initialize debug variable with NO*/
- (id)init
{
    self = [super init];
    if (self) {
        twitterDebug = NO;
    }
    return self;
}

// Set Twitter debug ON/OFF
+ (void)setTwitterDebug:(BOOL)debugIn
{
    twitterDebug = debugIn;
}

+ (void)logMessage:(NSString *)messag
{
    if (twitterDebug)
    {
        NSLog(@"%@", messag);
    }
}

@end
