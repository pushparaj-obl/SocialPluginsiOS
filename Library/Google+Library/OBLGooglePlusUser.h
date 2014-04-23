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

//Email ID of user.
@property (nonatomic,strong) NSString *email;

//Firstname of user.
@property (nonatomic,strong) NSString *firstName;

//Middlename of user.
@property (nonatomic,strong) NSString *middleName;

//Lastname of user.
@property (nonatomic,strong) NSString *lastName;

//Profile image of user.
@property (nonatomic,strong) UIImage *image;


//The URL of this user's image.
@property (copy) NSString *imageUrl;

//the URL of this  user's  profile.
@property (copy) NSString *profileUrl;

//Birthdate of user.
@property (nonatomic,strong) NSString *birthdate;

//Current locatiion of user.
@property (nonatomic,strong) NSString *currentLocation;

//Gender of user.
@property (nonatomic,strong) NSString *gender;

//Places lived information of user
//If the key  *primary is "true", the place of residence is this person's primary residence.
//The key *value displays place where this person has lived. For example: "New Jersey"
@property (nonatomic,strong) NSArray *placesLived;

//Work information of user.
@property (nonatomic,strong) NSArray *organizations;

@end
