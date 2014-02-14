//
//  OBLGooglePlusQuery.m
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import "OBLGooglePlusQuery.h"

@implementation OBLGooglePlusQuery


//fatch user data and return the object of OBLfacebookUser class with detail and error if any.
+ (void)fetchUserProfileWithCompletionHandler:(CompletionBlock)block
{
    
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication ];
    
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,GTLPlusPerson *person,NSError *error) {
                
                OBLGooglePlusUser *user=[[OBLGooglePlusUser alloc]init];
                
                if (error) {
                    GTMLoggerError(@"Error: %@", error);
                } else {

                    GTLPlusPersonName *name=person.name;
                    user.firstName= [name valueForKey:@"givenName"];
                    user.middleName=[name valueForKey:@"middleName"];
                    user.lastName=[name valueForKey:@"familyName"];
                
                    user.profileName=person.displayName;
                    user.birthdate=person.birthday;
                    user.currentLocation=person.currentLocation;
                    user.gender=person.gender;
          
                    NSLog(@"F: %@ M:%@ L:%@",user.firstName, user.middleName, user.lastName);
                    
                    NSLog(@"\n ProfileNaMe:%@  BiIRTHDATE:%@ & LoCaTiOn:%@ & GEnDer: %@ ", user.profileName, user.birthdate, user.currentLocation, user.gender);
                    
         //         NSArray *placesLived=[person.placesLived copy];
                    user.placesLived=[person.placesLived copy];
           
                    for(NSString *place in user.placesLived)
                    {
                        NSLog(@"\n PlaCes LiVeD: %@",place);
                    }
                    
                    user.organizations=[person.organizations copy];
                    for(NSString *place in user.organizations)
                    {
                        NSLog(@"\n WoRkS aT: %@",place);
                    }
                    
//                    GTLPlusPersonImage *image  =person.image;
//                    NSString *strimag=[image valueForKey:@"url"];
//                    // [self setImageFromURL:[NSURL URLWithString:strimag]];
//                    NSData *receivedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strimag]];
//                    UIImage *img = [[UIImage alloc] initWithData:receivedData ];
//                    receivedData=UIImageJPEGRepresentation(img,50);
//                    UIImage *img1=[UIImage imageWithData:receivedData];
//                    [self.imageView setImage:img1];
//                    NSLog(@"\nPersoN ImagE: %@",image);
                }
                
                block(user,error);
                
            }];
}

//returns all the friends.
+ (NSArray *)allFriends
{
    __block NSArray *friends=nil;
    
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication ];
    
    GTLQueryPlus *query1 =[GTLQueryPlus queryForPeopleListWithUserId:@"me"
                                                          collection:kGTLPlusCollectionVisible];
    [plusService executeQuery:query1
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPeopleFeed *peopleFeed,
                                NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                }
                else {
                    // Get an array of people from GTLPlusPeopleFeed
                    NSDictionary *peopleList = [peopleFeed.items copy] ;
                    
                    for(NSDictionary *names in peopleList)
                    {
                        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:(NSString *)((GTLPlusPerson*)names).identifier];
                     
                        
                        
                    }
//    [OBLFacebookQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *result, NSError *error) {
//        if (error)
//        {
//            [OBLLog logMessage:error.description];
//        }
//        else
//        {
//            friends=result;
//        }
//    }];
//    
    return friends;
}


/*
 
//fetch user's friends' data and return the object of OBLfacebookUser class with detail and error if any.
+ (void)fetchFriendsProfileWithCompletionHandler:(CompletionFriendAll)block
{
    
    
    
    
//    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
//    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
//                                                  NSDictionary* result,
//                                                  NSError *error) {
//        NSError *errorIn=nil;
//        NSMutableArray *friendArray = [[NSMutableArray alloc] init];
//        if (error)
//        {
//            errorIn=error;
//            [OBLLog logMessage:error.description];
//        }
//        else
//        {
//            NSArray *friends = [result objectForKey:@"data"];
//            
//            for (NSDictionary<FBGraphUser>* friend in friends)
//            {
//                OBLFacebookFriend *userFriend = [[OBLFacebookFriend alloc] init];
//                userFriend.socialMediaId = [friend objectForKey:@"id"];
//                userFriend.name  = [friend objectForKey:@"name"];
//                userFriend.firstName  = [friend objectForKey:@"first_name"];
//                userFriend.middleName  = [friend objectForKey:@"middle_name"];
//                userFriend.lastName  = [friend objectForKey:@"last_name"];
//                userFriend.userName  = [friend objectForKey:@"username"];
//                userFriend.birthdate  = [friend objectForKey:@"birthdate"];
//                userFriend.currentLocation  = [friend objectForKey:@"location"];
//                [friendArray addObject:userFriend];
//            }
//        }
//        NSArray *newArray = [[NSArray alloc] initWithArray:friendArray];
//        block(newArray,errorIn);
//    }];
    
}

//fatch user's friends' data and return the object of OBLfacebookUser class with detail and error if any.   ...!!(Remaining)
+ (void)fetchFriendsProfile:(NSArray *)facebookId withCompletionHandler:(CompletionFriendBlock)block
{
    
}
*/

@end
