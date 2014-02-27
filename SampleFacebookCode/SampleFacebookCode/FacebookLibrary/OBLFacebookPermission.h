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

//basic_info permission, includes:username, userprofileimage, friendlist.
extern NSString *const BASIC_INFO;

//publish permission
extern NSString *const PUBLISH_ACTION;

//email permission
extern NSString *const EMAIL;

//hometown permission
extern NSString *const USER_HOME_TOWN;

//link permission
extern NSString *const LINK;

//gender permission
extern NSString *const GENDER;

//location permission
extern NSString *const CURRENT_LOCATION;

//user's birthday
extern NSString *const BIRTH_DAY;

//friend's bithday
extern NSString *const FRIEND_BIRTH_DAY;

@end