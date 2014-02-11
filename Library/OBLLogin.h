//
//  Login.h
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.

//Abstract class for login and logout.
//Library for login should implement login protocol.

#import <Foundation/Foundation.h>

@protocol login

/*implement logion method*/
+ (NSError *) login;

/*implement logput method*/
+ (BOOL) logout;

@end

@interface OBLLogin : NSObject

@end
