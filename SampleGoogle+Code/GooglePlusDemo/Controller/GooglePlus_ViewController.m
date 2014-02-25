//
//  GooglePlus_ViewController.m
//  Google+Demo
//
//  Created by Jeneena Jose on 2/13/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import "GooglePlus_ViewController.h"

@implementation GooglePlus_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    OBLGooglePlusLogin *gpl=[OBLGooglePlusLogin sharedInstance];
    
    //set your own clientId here.You can get it from Google APIs Console.
    gpl.clientID=@"592155868142-t4dtrahjvtfhvsdi997aq712qf1q8pqi.apps.googleusercontent.com";
    gpl.scopes=@[@"https://www.googleapis.com/auth/plus.login"];
    gpl.loginUsingInstalledApp=YES;
    gpl.shouldFetchGooglePlusUser=YES;
    gpl.shouldFetchGoogleUserEmail=YES;
    gpl.shouldFetchGoogleUserID=YES;
    gpl.delegate=self;
    
    //set debugger ON/OFF as per your need
    [OBLLog setGooglePlusDebug:YES];
    [self refereshView];
}

#pragma mark - Sign In

- (IBAction)signInClicked:(id)sender {
    self.signIn.enabled=NO;
    NSError *error= [[OBLGooglePlusLogin sharedInstance] login];
    
    if(error)
    {
        NSLog(@"Error: %@",error.description);
    }
}

// delegate implemented after |login| method.
- (void) finishedWithLogin:(NSError *)error
{
    if(error)
    {
        NSLog(@"\nError: %@",error.description);
    }
    else
    {
        [self refereshView];
        [OBLLog logGPMessage:@"Successfully logged in"];
    }
    
}

#pragma  mark - Fetch Profile details

//fetches user details
- (IBAction)profileButtonClicked:(id)sender
{
    [OBLGooglePlusQuery fetchProfileDetailOfUser:^(OBLGooglePlusUser *result, NSError *error)
     {
         if(error) NSLog(@"Error :%@  ",error);
         else
         {
             NSLog(@"\nUseR ID:%@ email ID:%@",result.socialMediaId,result.email);
             NSLog(@"\nF: %@ M:%@ L:%@",result.firstName, result.middleName, result.lastName);
             NSLog(@"\nProfile name:%@  BiIRTHDATE:%@ & LoCaTiOn:%@ & GEnDer: %@ ", result.name, result.birthdate, result.currentLocation, result.gender);
             NSLog(@"\nProfile URL:%@ ",result.profileUrl);
         }
     }];
}

//fetches the signed in user's friends profile information
- (IBAction)friendsProfileButtonclicked:(id)sender
{
    [OBLGooglePlusQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *result, NSError *error) {
        //NSArray returns an array of objcts of type OBLGooglePlusFriend
        if(error){
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Status" message:@"Operation failed.Please click again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            for(OBLGooglePlusFriend *user in result)
            {
                NSLog(@"F: %@ M:%@ L:%@",user.firstName, user.middleName, user.lastName);
                NSLog(@"\n Profile name:%@  BiIRTHDATE:%@ & LoCaTiOn:%@ & GEnDer: %@ ", user.name, user.birthdate, user.currentLocation, user.gender);
            }
        }
    }];
}


#pragma mark - Share

//There are various share methods in OBLGooglePlusShare with differnt parameter lists.
//Call appropriate share method as per your need.
- (IBAction)shareButtonClicked:(id)sender
{
    OBLGooglePlusShare *gps=[OBLGooglePlusShare sharedInstance];
    gps.delegate=self;

//Remove comments to share a post with title,imageURL and description.
//    [gps shareInteractivePost:@"Check it out!!"
//           withTitle:@"New SuperHero in Town"
//      addDescription:@"He just ran 5000 meters in 26:16! That's a new record!"
//         andImageURL:@"http://wikicheats.gametrailers.com/images/d/de/Super_Smash_Bros_Link_01.jpg"
//     ];
    
    //Interactive share with URL.
    //To check the list of callTOAction button labels refer the class CallToActinButtonLabels
    [gps shareInteractivePost:@"Check it out!!" withURL:@"https://www.ridesharebuddy.com" withCallToActionLabel:JOIN];
}

//Delegate called after sharing.
//It shows whether sharing was successful or  not.
-(void) sharingCompleted:(BOOL)shared
{
    if(shared)
    {
        NSLog(@"Sharing Completed.");
    }
    else
    {
        NSLog(@"Posting failed.");
    }
}

#pragma  mark - Sign Out

- (IBAction)signOutClicked:(id)sender
{
    BOOL logout=[[OBLGooglePlusLogin sharedInstance ]logout];
    if(logout)
    {
        NSLog(@"User is logged out!!");
        [self refereshView];
    }
}

#pragma mark - Disconnect

- (IBAction)disconnectClicked:(id)sender
{
    [[OBLGooglePlusLogin sharedInstance ]disconnect];
    [self refereshView];
}

//Delegate called after disconnecting the user.
- (void)didDisconnectWithError:(NSError *)error {
    if (error)
    {
        NSLog(@"Error: %@",error.description);

    } else
    {
        NSLog(@"User is disconncted.");

    }
}

#pragma mark - Refresh View

-(void) refereshView
{
    if([OBLGooglePlusLogin sharedInstance].authentication)
    {
        self.signIn.hidden=YES;
        self.signOut.hidden=NO;
        self.disconnect.hidden=NO;
        self.shareButton.hidden=NO;
        self.profileButton.hidden=NO;
        self.friendsProfileInfo.hidden=NO;
        self.fetchLabel.hidden=NO;
    }
    else
    {
        self.signIn.hidden=NO;
        self.signOut.hidden=YES;
        self.disconnect.hidden=YES;
        self.shareButton.hidden=YES;
        self.profileButton.hidden=YES;
        self.friendsProfileInfo.hidden=YES;
        self.fetchLabel.hidden=YES;
    }
}

@end
