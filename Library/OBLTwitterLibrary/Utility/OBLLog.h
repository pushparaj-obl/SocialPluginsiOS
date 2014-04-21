//
//  OBLLog.h
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBLLog : NSObject

// Set debugging ON/OFF
+ (void)setTwitterDebug:(BOOL)debug;

// Log message if Twitter debug is ON
+ (void)logTwitterMessage:(NSString *)message;

@end
