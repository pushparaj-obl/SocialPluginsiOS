//
//  OBLFacebookPost.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//This class allows user to post on user's wall.

#import "OBLPost.h"
#import <FacebookSDK/FacebookSDK.h>
#import "OBLLog.h"

@interface OBLFacebookPost : NSObject <OBLPost>

//implement post:status method of post protocol
//post on user's wall with status
+ (BOOL)post:(NSString *)status;

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

@end
