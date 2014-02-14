//
//  OBLGooglePlusUser.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

//Main class having all profile information of facebook user

#import <Foundation/Foundation.h>
#import "OBLProfileDetails.h"

@interface OBLGooglePlusUser : NSObject <ProfileDetails>

//email-id of user.
@property (nonatomic,strong) NSString *email;

//firstname of user
@property (nonatomic,strong) NSString *firstName;

//middlename of user
@property (nonatomic,strong) NSString *middleName;

//lastname of user
@property (nonatomic,strong) NSString *lastName;

//username of user(may be different from the name)
@property (nonatomic,strong) NSString *profileName;

//image


//hometown of user
//@property (nonatomic,strong) NSString *homeTown;

//birthday of user
@property (nonatomic,strong) NSString *birthdate;

//current locatiion of user
@property (nonatomic,strong) NSString *currentLocation;

//gender of user
@property (nonatomic,strong) NSString *gender;

//Array of friends of user having OBLGooglePlusFriend objects.
@property (nonatomic,strong) NSArray *friends;


//place information of user..
@property (nonatomic,strong) NSArray *placesLived;

//work information of user..
@property (nonatomic,strong) NSArray *organizations;

@end
