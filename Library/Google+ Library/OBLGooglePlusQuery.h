//
//  OBLGooglePlusQuery.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GooglePlus/GooglePlus.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

#import "OBLGooglePlusUser.h"
#import "OBLGooglePlusFriend.h"

#import "OBLLog.h"

//completion block having output user data or error if any
typedef void (^CompletionBlock)(OBLGooglePlusUser *result,
                                NSError *error);

//completion block having output friend data or error if any
typedef void (^CompletionFriendBlock)(OBLGooglePlusFriend *result,
                                      NSError *error);

//completion block having output all the friend data in array or error if any
typedef void (^CompletionFriendAll)(NSArray *result,
                                    NSError *error);


@interface OBLGooglePlusQuery : NSObject

//fetch user data and return the object of OBLGooglePlusUser class with detail and error if any
+ (void)fetchUserProfileWithCompletionHandler:(CompletionBlock)block;

//returns all the friends of signed-in user
+ (NSArray *)allFriends;

//fetch all the friends profile data with completion handler. Returns array of the OBLGooglePlusFriend object
+ (void)fetchFriendsProfileWithCompletionHandler:(CompletionFriendAll)block;

//fetch user's friends' data and return the object of OBLGooglePlusUser class with detail and error if any
+ (void)fetchFriendsProfile:(NSArray *)facebookId withCompletionHandler:(CompletionFriendBlock)block;

@end
