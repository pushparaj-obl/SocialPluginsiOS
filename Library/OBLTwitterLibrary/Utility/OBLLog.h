//
//  OBLLog.h
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBLLog : NSObject

// Set debugging ON/OFF
+ (void)setTwitterDebug:(BOOL)debugIn;

// Log message if Twitter debug is ON
+ (void)logMessage:(NSString *)message;

@end
