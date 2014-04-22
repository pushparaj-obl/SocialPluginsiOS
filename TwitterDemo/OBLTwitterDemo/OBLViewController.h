//
//  OBLViewController.h
//  OBLTwitterDemo
//
//  Created by Akash Patel on 2/16/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OBLTwitter.h"
#import "OBLLog.h"

#define TWITTER_CONSUMER_KEY @"YOUR_CONSUMER_KEY"
#define TWITTER_CONSUMER_SECRET @"YOUR_CONSUMER_SECRET"

@interface OBLViewController : UIViewController <OBLTwitterLoginDelegate>

@end
