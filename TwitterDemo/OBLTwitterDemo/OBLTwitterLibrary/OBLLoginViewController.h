//
//  OBLLoginViewController.h
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/12/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonHMAC.h>
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <objc/runtime.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <ifaddrs.h>
#import "OBLTwitterLogin.h"
#import "OBLLog.h"

#define LOGIN_CANCELED @"User canceled login"

@protocol OBLTwitterLoginDelegate <NSObject>

// Called when login is completed
- (void)loginCompleted:(NSError *)error;

@end


@interface OBLLoginViewController : UIViewController <UIWebViewDelegate>

// Delegate for login
@property (nonatomic, weak) id <OBLTwitterLoginDelegate> loginDelegate;
// Used to set background color to login screen
@property (nonatomic, strong) UIColor * backgroundColor;

@end
