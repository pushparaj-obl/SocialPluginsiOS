//
//  Login.h
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.

//Abstract class for login and logout.
//Library for login should implement login protocol.

#import <Foundation/Foundation.h>

/*OBLLogin protocol for login and logout function*/
@protocol OBLLogin

/*logion method - force subclass to implement login functionality*/
+ (void)login;

/*logout method - force subclass to implement logout functionality*/
+ (void)logout;

@end
