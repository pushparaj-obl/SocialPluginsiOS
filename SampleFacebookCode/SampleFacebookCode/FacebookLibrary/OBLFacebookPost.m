//
//  OBLFacebookPost.m
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//This class allows user to post on user's wall.

#import "OBLFacebookPost.h"

@implementation OBLFacebookPost

//implements method of post protocol - post status on user's wall
+ (BOOL)post:(NSString *)status
{
    return ([OBLFacebookPost postStatus:(NSString *)status
                              withTitle:nil
                         andDescription:nil
                               imageUrl:nil
                                linkUrl:nil
                  withCompletionHandler:nil]);
}

//
+ (BOOL)post:(NSString *)status withCompletionHandler:(FBPostCompletionHandler)block
{
    return ([OBLFacebookPost postStatus:(NSString *)status
                              withTitle:nil
                         andDescription:nil
                               imageUrl:nil
                                linkUrl:nil
                  withCompletionHandler:block]);
}

//post status with title, description and image
+ (BOOL) postStatus:(NSString *)status      //status message for posting
          withTitle:(NSString *)title       //title of link
     andDescription:(NSString *)description //description of link
              imageUrl:(NSString *)imageUrl //preview image associated with the link(image url)
             linkUrl:(NSString *)url        //LinkUrl of a link to attach to the post
withCompletionHandler:(FBPostCompletionHandler)block
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
                                    [OBLLog logFBMessage:error.description];
                                }
                                else
                                {
                                    [OBLLog logFBMessage:@"Post successful"];
                                    success = YES;
                                }
                                block(error);
                            }
     ];
    return success;
}

//post status with title, description and image
+ (BOOL)postToFacebookFriendWithTitle:(NSString *)title         //status message for posting
                               status:(NSString *)status        //title of post
                       andDescription:(NSString *)description   //description of post
                             imageUrl:(NSString *)imageUrl      //preview image associated with the link(image url)
                              linkUrl:(NSString *)url           //LinkUrl of a link to attach to the post
                              caption:(NSString *)caption       //caption in post
                                 from:(NSString *)from          //user's id
                                   to:(NSString *)to            //friend's profile (facebookId)
                             delegate:(id <OBLFacebookFriendPostDelegate>)delegate
                withCompletionHandler:(FBPostCompletionHandler)block
{
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     title, @"name",
     caption, @"caption",
     status, @"message",
     description, @"description",
     url, @"link",
     imageUrl, @"picture",
     [NSString stringWithFormat:@"%@",from], @"from",
     [NSString stringWithFormat:@"%@",to], @"to",
     nil];
    
    __block BOOL success=NO;
    // Invoke the dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                           parameters:params
                                              handler:
     ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error)
         {
             // Error launching the dialog or publishing a story.
             [OBLLog logFBMessage:error.description];
             [OBLLog logFBMessage:@"Error publishing story."];
         }
         else
         {
             [OBLFacebookFriendPostHandle parseResult:result withURL:resultURL delegate:delegate];
             success = YES;
         }
         block(error);
     }];
    return success;
}

@end
