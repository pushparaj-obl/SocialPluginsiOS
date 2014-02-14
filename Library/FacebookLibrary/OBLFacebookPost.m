//
//  OBLFacebookPost.m
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "OBLFacebookPost.h"

@implementation OBLFacebookPost

//implements method of post protocol - post status on user's wall
+ (BOOL)post:(NSString *)status
{
    return ([OBLFacebookPost postStatus:(NSString *)status
                              withTitle:nil
                         andDescription:nil
                               andImage:nil
                                 andURL:nil]);
}

//post status with title, description and image
+ (BOOL) postStatus:(NSString *)status      //status message for posting
          withTitle:(NSString *)title       //title of link
     andDescription:(NSString *)description //description of link
           andImage:(NSString *)imageUrl        //preview image associated with the link(image url)
             andURL:(NSString *)url         //the URL of a link to attach to the post
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            status, @"message",
                            url,@"link",
                            imageUrl,@"picture",
                            title,@"name",
                            description,@"description",
                            nil
                            ];
    __block BOOL success=NO;
    /* make the API call */
    [FBRequestConnection startWithGraphPath:@"/me/feed"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection,id result,NSError *error)
     {
         if (error)
         {
             [OBLLog logMessage:error.description];
         }
         else
         {
             [OBLLog logMessage:@"Post successful"];
             success=YES;
         }
     }
     ];
    return success;
}

//post on friend's wall     ...!!(Remaining)
+ (BOOL) postStatus:(NSString *)status
      onFriendsWall:(NSArray *)facebookId
{
    [OBLFacebookPost postStatus:status
                  onFriendsWall:facebookId
                      withTitle:nil
                    description:nil
                       andImage:nil
                            url:nil];
    return YES;
}

//post on friend's wall with title, description and image   ...!!(Remaining)
+ (BOOL) postStatus:(NSString *)status
      onFriendsWall:(NSArray *)facebookId
          withTitle:(NSString *)title
        description:(NSString *)description
           andImage:(UIImage *)imageUrl
                url:(NSString *)url
{
    return YES;
}

@end
