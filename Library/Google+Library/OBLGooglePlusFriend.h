//
//  OBLGooglePlusFriend.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/14/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

//Main class having all profile information of Google Plus user's friend

#import <Foundation/Foundation.h>
#import "OBLProfileDetails.h"

@interface OBLGooglePlusFriend : NSObject  <OBLProfileDetails>

//Firstname of user's friend.
@property (nonatomic,strong) NSString *firstName;

//Middlename of user's friend.
@property (nonatomic,strong) NSString *middleName;

//Lastname of user's friend.
@property (nonatomic,strong) NSString *lastName;

//Image of user's friend.
@property (nonatomic,strong) UIImage *image;

//The URL of image of user's friend.
@property (copy) NSString *imageUrl;

//The URL of user's friend profile.
@property (copy) NSString *profileUrl;

//Birthday of user's friend.
@property (nonatomic,strong) NSString *birthdate;

//Current locatiion of user's friend.
@property (nonatomic,strong) NSString *currentLocation;

//Gender of user's friend.
@property (nonatomic,strong) NSString *gender;

//Places lived information of user's friend.
@property (nonatomic,strong) NSArray *placesLived;

//Work information of user's friend.
@property (nonatomic,strong) NSArray *organizations;

@end
