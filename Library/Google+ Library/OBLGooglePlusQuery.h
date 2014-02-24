//
//  OBLGooglePlusQuery.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

//Provides methods for querying user's profile information
//in addtition to the users friends profile information

#import <Foundation/Foundation.h>
#import "GooglePlus/GooglePlus.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "OBLGooglePlusUser.h"
#import "OBLGooglePlusFriend.h"
#import "OBLLog.h"

//completion block having output user data or error if any
typedef void (^CompletionBlockOFUser)(OBLGooglePlusUser *user,
                                NSError *error);


//completion block having output all the friend data in array or error if any
typedef void (^CompletionFriendAll)(NSArray *result,
                                    NSError *error);


@interface OBLGooglePlusQuery : NSObject

//fetch user data and return the object of OBLGooglePlusUser class with detail and error if any
+ (void)fetchUserProfileWithCompletionHandler:(CompletionBlockOFUser)block;

//fetch user data without the friend list and returns the object of OBLGooglePlusUser class with detail and error if any
+(void) fetchProfileDetailOfUser:(CompletionBlockOFUser)block;


//fetch all the friends profile data with completion handler. Returns array of the OBLGooglePlusFriend object
+ (void)fetchFriendsProfileWithCompletionHandler:(CompletionFriendAll)block;


@end
