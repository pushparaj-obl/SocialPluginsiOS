//
//  GPLogin.h
//
//
//  Created by Jeneena Jose on 2/19/14.
//  Copyright (c) 2014 Jen. All rights reserved.
//

#import <Foundation/Foundation.h>


//GPLogin protocol for login and logout methods
//implemented by class OBLGooglePlusLogin

@protocol GPLogin

//logion method - force subclass to implement login functionality
- (NSError *) login;

//logout method - force subclass to implement logout functionality
- (BOOL)logout;

@end


