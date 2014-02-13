//
//  FBAppDelegate.m
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "FBAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FacebookLogin.h"

@implementation FBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    //[self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    // Note this handler block should be the exact same as the handler passed to any open calls.
    /*
     [FBSession.activeSession setStateChangeHandler:
     ^(FBSession *session, FBSessionState state, NSError *error) {
     // Retrieve the app delegate
     //         FacebookAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
     // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
     //FacebookLogin *cv=[[FacebookLogin alloc]init];
     if (error)
     {
     [FacebookLogin errorLog:error];
     }
     else
     {
     [FacebookLogin sessionStateChanged:session state:state];
     }
     }];
     */
    
    return [FacebookLogin handleOpenUrl:(NSURL *)url];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActive];
}

@end
