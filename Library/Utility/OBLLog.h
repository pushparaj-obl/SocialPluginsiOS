//
//  OBLLog.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBLLog : NSObject

/*change state of debugging */
+ (void)setDebug:(BOOL)debugIn;

/*get the state of debugging mode*/
+ (BOOL)getDebug;

/*log the values if debugging is on*/
+ (void)logMessage:(NSString *)message;


@end
