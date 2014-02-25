//
//  OBLGooglePlusQuery.m
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import "OBLGooglePlusQuery.h"

@implementation OBLGooglePlusQuery

#pragma  mark - User Profile Details

//Fetches user data
+(void) fetchProfileDetailOfUser:(CompletionBlockOFUser)block
{
    [OBLGooglePlusQuery getProfileDetails:@"me" completion:^(OBLGooglePlusUser *user, NSError *error) {
        
        NSString *accessToken=[GPPSignIn sharedInstance].authentication.accessToken;
        NSString *str=[NSString stringWithFormat:@"https://www.googleapis.com/oauth2/v1/userinfo?access_token=%@",accessToken];
        NSString *escapedUrl = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:escapedUrl];
        NSString *jsonData = [[NSString alloc] initWithContentsOfURL:url usedEncoding:nil error:nil];
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:[jsonData dataUsingEncoding:NSUTF8StringEncoding]
                                                                       options:NSJSONReadingMutableContainers error:&error];
        
        NSString *userId=[jsonDictionary objectForKey:@"id"];
        NSString *emailId=[jsonDictionary objectForKey:@"email"];
        
        user.socialMediaId=userId;
        user.email=emailId;
        
        block(user,error);
    }];
}

+(void) getProfileDetails:(NSString *)id completion:(CompletionBlockOFUser)block
{
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
    plusService.apiVersion = @"v1";
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication ];
    
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:id];
    
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,GTLPlusPerson *person,NSError *error) {
                
                OBLGooglePlusUser *user=[[OBLGooglePlusUser alloc]init];
                
                if (error) {
                    [OBLLog GPErrorLog:error];
                } else {
                    
                    GTLPlusPersonName *name=person.name;
                    user.firstName= [name valueForKey:@"givenName"];
                    user.middleName=[name valueForKey:@"middleName"];
                    user.lastName=[name valueForKey:@"familyName"];
                    
                    user.name=person.displayName;
                    user.birthdate=person.birthday;
                    user.currentLocation=person.currentLocation;
                    user.gender=person.gender;
                    user.profileUrl=person.url;
                    user.placesLived=[person.placesLived copy];
                    user.organizations=[person.organizations copy];
                    
                    GTLPlusPersonImage *image  =person.image;
                    user.imageUrl=[image valueForKey:@"url"];
                    
                    NSData *receivedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[image valueForKey:@"url"] ]];
                    user.image= [[UIImage alloc] initWithData:receivedData ];
                }
                block(user,error);
        }];
}


#pragma  mark - Friend's Profile Details

//Fetches user's friends' data and returns the object of OBLGooglePlusUser class 
+ (void)fetchFriendsProfileWithCompletionHandler:(CompletionFriendAll)block
{
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init];
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication ];
    __block NSMutableArray *friends=[[NSMutableArray alloc]init];
    
    GTLQueryPlus *query1 =[GTLQueryPlus queryForPeopleListWithUserId:@"me"
                                                          collection:kGTLPlusCollectionVisible];
    [plusService executeQuery:query1
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPeopleFeed *peopleFeed,
                                NSError *error)
     {
         if (error)
         {
             [OBLLog GPErrorLog:error];
         }
         else
         {
             NSNumber *n=peopleFeed.totalItems;
             __block   int i=0;
             // Get an array of people from GTLPlusPeopleFeed
             NSArray *peopleList = [peopleFeed.items copy] ;
             
             for(GTLPlusPerson *names in peopleList)
             {
                 NSString *id=(NSString *)((GTLPlusPerson*)names).identifier;
                 
                 GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:id];
                 
                 [plusService executeQuery:query
                         completionHandler:^(GTLServiceTicket *ticket,GTLPlusPerson *person,NSError *error)
                  {
                      OBLGooglePlusFriend *user=[[OBLGooglePlusFriend alloc]init];
                      
                      if (error) {
                          [OBLLog GPErrorLog:error];
                          block(friends,error);
                      }
                      else
                      {
                          user.socialMediaId=id;
                          
                          GTLPlusPersonName *name=person.name;
                          user.firstName= [name valueForKey:@"givenName"];
                          user.middleName=[name valueForKey:@"middleName"];
                          user.lastName=[name valueForKey:@"familyName"];
                          
                          user.name=person.displayName;
                          user.birthdate=person.birthday;
                          user.currentLocation=person.currentLocation;
                          user.gender=person.gender;
                          user.profileUrl=person.url;
                          
                          user.placesLived=[person.placesLived copy];
                          
                          user.organizations=[person.organizations copy];
                          
                          GTLPlusPersonImage *image  =person.image;
                          user.imageUrl=[image valueForKey:@"url"];
                          
                          NSData *receivedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[image valueForKey:@"url"] ]];
                          user.image= [[UIImage alloc] initWithData:receivedData ];
                          
                          [friends addObject:user];
                          i++;
                          
                          if(i == [n intValue])
                          {
                              block(friends,error);
                          }
                      }
                  }];
             }
         }
     }];
}
@end

