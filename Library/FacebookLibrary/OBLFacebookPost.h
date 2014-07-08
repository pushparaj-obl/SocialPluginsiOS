//
//  OBLFacebookPost.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//This class allows user to post on user's wall.

#import "OBLPost.h"
#import "OBLLog.h"
#import "OBLFacebookFriendPostHandle.h"

@interface OBLFacebookPost : NSObject <OBLPost>

typedef void (^FBPostCompletionHandler)(NSError *error);

//implement post:status method of post protocol
+ (BOOL)post:(NSString *)status;


//post on user's wall with status
+ (BOOL)post:(NSString *)status withCompletionHandler:(FBPostCompletionHandler) block;

/*
//post status with title, description and image
//status:- status message for posting
//titile:- title of link
//description:- description of link
//imageUrl:- preview image associated with the link(image url)
//LinkUrl:- the URL of a link to attach to the post
*/
+ (BOOL) postStatus:(NSString *)status
          withTitle:(NSString *)title
     andDescription:(NSString *)description
           imageUrl:(NSString *)imageUrl
            linkUrl:(NSString *)url
withCompletionHandler:(FBPostCompletionHandler) block;

/*
//post status on friend's wall
//caption - Caption on the post
//from - facebookId of the sender(logged in user)
//to - facebookId of the friend
//delegate - OBLFacebookFriendPostDelegate for dialog handling
//Other arguments are same as post method
*/

+ (BOOL)postToFacebookFriendWithTitle:(NSString *)title         //status message for posting
                               status:(NSString *)status        //title of post
                       andDescription:(NSString *)description   //description of post
                             imageUrl:(NSString *)imageUrl      //preview image associated with the link(image url)
                              linkUrl:(NSString *)url           //LinkUrl of a link to attach to the post
                              caption:(NSString *)caption       //caption in post
                                 from:(NSString *)from          //user's facebookId
                                   to:(NSString *)to            //friend's facebookId
                             delegate:(id <OBLFacebookFriendPostDelegate>)delegate
                withCompletionHandler:(FBPostCompletionHandler)block;

@end
