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

//firstname of user's friend
@property (nonatomic,strong) NSString *firstName;

//middlename of user's friend
@property (nonatomic,strong) NSString *middleName;

//lastname of user's friend
@property (nonatomic,strong) NSString *lastName;

//image of user's friend
@property (nonatomic,strong) UIImage *image;

//the URL of image of user's friend
@property (copy) NSString *imageUrl;

// The URL of user's friend profile
@property (copy) NSString *url;

//birthday of user's friend
@property (nonatomic,strong) NSString *birthdate;

//current locatiion of user's friend
@property (nonatomic,strong) NSString *currentLocation;

//gender of user's friend
@property (nonatomic,strong) NSString *gender;

//place lived information of user's friend
@property (nonatomic,strong) NSArray *placesLived;

//work information of user's friend
@property (nonatomic,strong) NSArray *organizations;

@end
