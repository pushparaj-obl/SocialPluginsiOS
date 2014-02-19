//
//  OBLGooglePlusUser.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

//Main class having all profile information of Google Plus user

#import <Foundation/Foundation.h>
#import "OBLProfileDetails.h"

@interface OBLGooglePlusUser : NSObject <OBLProfileDetails>

//email
@property (nonatomic,strong) NSString *email;

//firstname of user
@property (nonatomic,strong) NSString *firstName;

//middlename of user
@property (nonatomic,strong) NSString *middleName;

//lastname of user
@property (nonatomic,strong) NSString *lastName;

//image
@property (nonatomic,strong) UIImage *image;


//the URL of this user's image
@property (copy) NSString *imageUrl;

//the URL of this  user's  profile.
@property (copy) NSString *url;

//birthday of user
@property (nonatomic,strong) NSString *birthdate;

//current locatiion of user
@property (nonatomic,strong) NSString *currentLocation;

//gender of user
@property (nonatomic,strong) NSString *gender;

//array of friends of user having OBLGooglePlusFriend objects.
@property (nonatomic,strong) NSArray *friends;


//places lived information of user
// the key  *primary is "true", this place of residence is this person's primary residence.
//the key *value displays place where this person has lived. For example: "Seattle, WA"
@property (nonatomic,strong) NSArray *placesLived;

//work information of user
@property (nonatomic,strong) NSArray *organizations;

@end
