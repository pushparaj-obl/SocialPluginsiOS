//
//  OBLFacebookPost.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//This class allows user to post on user's wall.

#import <Foundation/Foundation.h>
#import "OBLPost.h"

@interface OBLFacebookPost : NSObject <post>

//implement post:status method of post protocol
+ (void)post:(NSString *)status;

//post on user's wall with status
+ (BOOL) postStatus:(NSString *)status;

/*
//post status with title, description and image
//status:- status message for posting
//titile:- title of link
//description:- description of link
//imageUrl:- preview image associated with the link(image url)
//url:- the URL of a link to attach to the post
*/
+ (BOOL) postStatus:(NSString *)status
          withTitle:(NSString *)title
     andDescription:(NSString *)description
           andImage:(NSString *)imageUrl
             andURL:(NSString *)url;

//post on friend's wall
+ (BOOL) postStatus:(NSString *)status
      onFriendsWall:(NSArray *)facebookId;


//post on friend's wall with title, description and image
+ (BOOL) postStatus:(NSString *)status
      onFriendsWall:(NSArray *)facebookId
          withTitle:(NSString *)title
        description:(NSString *)description
           andImage:(UIImage *)image
                url:(NSString *)url;

@end
