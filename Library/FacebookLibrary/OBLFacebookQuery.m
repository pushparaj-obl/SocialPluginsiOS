//
//  OBLFacebookQuery.m
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "OBLFacebookQuery.h"

@implementation OBLFacebookQuery

//fatch user data and return the object of OBLfacebookUser class with detail and error if any.
+ (void)fetchUserProfileWithCompletionHandler:(CompletionBlock)block
{
    FBRequest* myRequest = [FBRequest requestForMe];
    [myRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                             NSDictionary<FBGraphUser>* result,
                                             NSError *error) {
        NSError *errorIn=nil;
        OBLFacebookUser *user = [[OBLFacebookUser alloc] init];
        if (error)
        {
            errorIn=error;
            [OBLLog logMessage:error.description];
        }
        else
        {
            user.socialMediaId = [result objectForKey:@"id"];
            user.name = [result objectForKey:@"name"];
            user.email = [result objectForKey:@"email"];
            user.firstName = [result objectForKey:@"first_name"];
            user.middleName = [result objectForKey:@"middle_name"];
            user.lastName = [result objectForKey:@"last_name"];
            user.userName = [result objectForKey:@"username"];
            user.homeTown = [result objectForKey:@"hometown"];
            user.birthdate = [result objectForKey:@"birthday"];
            user.currentLocation = [result objectForKey:@"location"];
            user.gender = [result objectForKey:@"gender"];
        }
        
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           block(user,errorIn);
                       });
    }];
}

//fatch user's friends' data and return the object of OBLfacebookUser class with detail and error if any.
+ (void)fetchFriendsProfileWithCompletionHandler:(CompletionFriendAll)block
{
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        NSError *errorIn=nil;
        NSMutableArray *friendArray = [[NSMutableArray alloc] init];
        if (error)
        {
            errorIn=error;
            [OBLLog logMessage:error.description];
        }
        else
        {
            NSArray *friends = [result objectForKey:@"data"];
            
            for (NSDictionary<FBGraphUser>* friend in friends)
            {
                OBLFacebookFriend *userFriend = [[OBLFacebookFriend alloc] init];
                userFriend.socialMediaId = [friend objectForKey:@"id"];
                userFriend.name  = [friend objectForKey:@"name"];
                userFriend.firstName  = [friend objectForKey:@"first_name"];
                userFriend.middleName  = [friend objectForKey:@"middle_name"];
                userFriend.lastName  = [friend objectForKey:@"last_name"];
                userFriend.userName  = [friend objectForKey:@"username"];
                userFriend.birthdate  = [friend objectForKey:@"birthdate"];
                userFriend.currentLocation  = [friend objectForKey:@"location"];
                [friendArray addObject:userFriend];
            }
        }
        NSArray *newArray = [[NSArray alloc] initWithArray:friendArray];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           block(newArray,errorIn);
                       });
    }];
    
}


@end
