//
//  OBLTwitter.h
//  OBLTwitterDemo
//
//  Created by Akash Patel on 2/16/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBLTwitterLogin.h"
#import "OBLTwitterPost.h"
#import "OBLTwitterLoginViewController.h"

@interface OBLTwitter : UIViewController

@property (nonatomic, weak) id <OBLTwitterLoginDelegate> loginDelegate;
@property (nonatomic, strong) NSString * consumerKey;
@property (nonatomic, strong) NSString * consumerSecret;

// Returns shared instance
+ (OBLTwitter *)sharedInstance;

// Logs out from Twitter
- (void)logout;

// Tweet on user's account
- (NSError *)tweet:(NSString *)status;

@end
