//
//  OBLFacebookFriend.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/12/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//class having all profile information of facebook friend

#import <Foundation/Foundation.h>
#import "OBLProfileDetails.h"

@interface OBLFacebookFriend : NSObject <OBLProfileDetails>

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

