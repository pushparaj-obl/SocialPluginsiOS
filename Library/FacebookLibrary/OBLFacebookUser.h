//
//  OBLFacebookUser.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//Main class having all profile information of facebook user

#import <Foundation/Foundation.h>
#import "OBLProfileDetails.h"

@interface OBLFacebookUser : NSObject <OBLProfileDetails>

//email-id of user.
@property (nonatomic,strong) NSString *email;

//firstname of user
@property (nonatomic,strong) NSString *firstName;

//middlename of user
@property (nonatomic,strong) NSString *middleName;

//lastname of user
@property (nonatomic,strong) NSString *lastName;

//username of user(may be different from the name)
@property (nonatomic,strong) NSString *userName;

//hometown of user
@property (nonatomic,strong) NSString *homeTown;

//birthday of user
@property (nonatomic,strong) NSString *birthdate;

//current locatiion of user
@property (nonatomic,strong) NSString *currentLocation;

//gender of user
@property (nonatomic,strong) NSString *gender;

//Array of friends of user having OBLFacebookFriend objects.
@property (nonatomic,strong) NSArray *friends;

@end
