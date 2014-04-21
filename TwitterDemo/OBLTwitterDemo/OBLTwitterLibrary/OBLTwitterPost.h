//
//  OBLTwitterPost.h
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/14/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OBLToken.h"
#import "OBLTwitterLogin.h"
#import "OBLTwitterRequest.h"
#import "OBLCategories.h"

@interface OBLTwitterPost : NSObject

+ (NSError *)tweet:(NSString *)tweetString;

@end
