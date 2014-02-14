//
//  OBLGooglePlusFriend.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OBLProfileDetails.h"

@interface OBLGooglePlusFriend : NSObject  <ProfileDetails>

//firstname of friend
@property (nonatomic,strong) NSString *firstName;

//middlename of friend
@property (nonatomic,strong) NSString *middleName;

//lastname of friend
@property (nonatomic,strong) NSString *lastName;

//username of friend(may be different from the name)
@property (nonatomic,strong) NSString *userName;

//birthday of friend
@property (nonatomic,strong) NSString *birthdate;

//current locatiion of friend
@property (nonatomic,strong) NSString *currentLocation;

@end
