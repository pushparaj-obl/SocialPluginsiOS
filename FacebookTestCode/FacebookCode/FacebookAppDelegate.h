//
//  FacebookAppDelegate.h
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookViewController.h"
@interface FacebookAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FacebookViewController *customLoginViewController;

@end
