//
//  OBLGooglePlusQuery.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

//Provides methods for querying user's profile information
//in addtition to the users friends profile information.

#import <Foundation/Foundation.h>
#import "GooglePlus/GooglePlus.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "OBLGooglePlusUser.h"
#import "OBLGooglePlusFriend.h"
#import "OBLLog.h"

//Completion block having output of user data and error,if any.
typedef void (^CompletionBlockOFUser)(OBLGooglePlusUser *user,
                                NSError *error);


//Completion block having output of all the friend data in array and error,if any.
typedef void (^CompletionFriendAll)(NSArray *friends,
                                    NSError *error);


@interface OBLGooglePlusQuery : NSObject

//Fetches user data and returns the object of OBLGooglePlusUser class with detail and error if any.
+(void) fetchProfileDetailOfUserWithImageSize:(NSInteger)size  completion:(CompletionBlockOFUser)block;

//Fetches all the friends profile data and returns array of the OBLGooglePlusFriend object.
+ (void)fetchFriendsProfileWithImageSize:(NSInteger)size  completionHandler:(CompletionFriendAll)block;


@end
