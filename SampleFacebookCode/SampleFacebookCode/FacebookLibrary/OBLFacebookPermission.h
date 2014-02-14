//
//  OBLFacebookPermission.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/13/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//All the Facebook Permissions that can be used with this library..

#import <Foundation/Foundation.h>

@interface OBLFacebookPermission : NSObject

typedef enum {
    /*! No audience needed; this value is useful for cases where data will only be read from Facebook */
    OBLDefaultAudienceNone                = 0,
    /*! Indicates that only the user is able to see posts made by the application */
    OBLDefaultAudienceOnlyMe              = 10,
    /*! Indicates that the user's friends are able to see posts made by the application */
    OBLDefaultAudienceFriends             = 20,
    /*! Indicates that all Facebook users are able to see posts made by the application */
    OBLDefaultAudienceEveryone            = 30,
} OBLDefaultAudiance;



//basic_info permission, includes:username, userprofileimage, friendlist.
extern NSString * const BASIC_INFO;

//publish permission
extern NSString * const PUBLISH_ACTION;

//email permission
extern NSString * const EMAIL;

//hometown permission
extern NSString * const USER_HOME_TOWN;

//link permission
extern NSString * const LINK;

//gender permission
extern NSString * const GENDER;

//location permission
extern NSString *const CURRENT_LOCATION;

@end