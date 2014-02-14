//
//  OBLFacebookPermission.m
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/13/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "OBLFacebookPermission.h"

@implementation OBLFacebookPermission

//basic_info permission, includes:username, userprofileimage, friendlist.
NSString *const BASIC_INFO = @"basic_info";

//publish permission
NSString *const PUBLISH_ACTION = @"publish_actions";

//email permission
NSString *const EMAIL = @"email";

//hometown permission
NSString *const USER_HOME_TOWN = @"user_hometown";

//link permission
NSString *const LINK = @"link";

//gender permission
NSString *const GENDER = @"gender";

//location permission
NSString *const CURRENT_LOCATION = @"user_location";

//user's bithday
NSString *const BIRTH_DAY = @"user_birthday";

//friend's bithday
NSString *const FRIEND_BIRTH_DAY = @"friends_birthday";

@end
