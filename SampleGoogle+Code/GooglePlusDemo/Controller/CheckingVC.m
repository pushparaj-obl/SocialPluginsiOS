//
//  CheckingVC.m
//  Google+Demo
//
//  Created by Jeneena Jose on 2/13/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import "CheckingVC.h"

@interface CheckingVC ()
@property (nonatomic, strong) OBLGooglePlusLogin * vc;
@end

@implementation CheckingVC


- (IBAction)signOutClicked:(id)sender
{
    
    BOOL logout=[[OBLGooglePlusLogin sharedInstance ]logout];
    if(logout)
    {
        [OBLLog logGPMessage:@"User is logged out!!"];
        [self refereshView];
    }
}

- (IBAction)disconnectClicked:(id)sender
{
    [[OBLGooglePlusLogin sharedInstance ]disconnect];
    [self refereshView];
}

- (IBAction)profileButtonClicked:(id)sender
{
    [OBLGooglePlusQuery fetchUserProfileWithCompletionHandler:^(OBLGooglePlusUser *result, NSError *error)
     {
         if(error) NSLog(@"EErrorr :%@ ",error);
         else
         {
             [OBLLog logGPMessage:[NSString stringWithFormat:@"F: %@ M:%@ L:%@",result.firstName, result.middleName, result.lastName]];
             [OBLLog logGPMessage:[NSString stringWithFormat:@"\n Profile name:%@  BiIRTHDATE:%@ & LoCaTiOn:%@ & GEnDer: %@ ", result.name, result.birthdate, result.currentLocation, result.gender]];

             [OBLLog logGPMessage:[NSString stringWithFormat:@"\n UseR ID:%@",result.socialMediaId]];

             [OBLLog logGPMessage:[NSString stringWithFormat:@"\n Email ID:%@ Friends:%@",result.email,result.friends]];
         }
     }];
    
//    [OBLGooglePlusQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *result, NSError *error) {
//        //NSArray returns an array of objcts of type OBLGooglePlusFriend
//        for(OBLGooglePlusFriend *user in result)
//        {
//    [OBLLog logMessage:[NSString stringWithFormat:@"F: %@ M:%@ L:%@",result.firstName, result.middleName, result.lastName]];
//        }
//        
//    }];

}

- (IBAction)shareButtonClicked:(id)sender
{
    OBLGooglePlusShare *gps=[OBLGooglePlusShare sharedInstance];
    gps.delegate=self;
 
//    [gps shareStatus:@"Check it out!!"
//           withTitle:@"New SuperHero in Town"
//      addDescription:@"He just ran 5000 meters in 26:16! That's a new record!"
//         andImageURL:@"http://wikicheats.gametrailers.com/images/d/de/Super_Smash_Bros_Link_01.jpg"
//              andURL:@"https://www.ridesharebuddy.com" ];

//    [gps shareStatus:@"Check it out!!"
//           withTitle:@"New SuperHero in Town"
//      addDescription:@"He just ran 5000 meters in 26:16! That's a new record!"
//         andImageURL:@"http://wikicheats.gametrailers.com/images/d/de/Super_Smash_Bros_Link_01.jpg"
//              andURL:nil ];

    [gps post:@"Hello!!"];

}

-(void) sharingCompleted:(BOOL)shared
{
    if(shared)   [OBLLog logGPMessage:@"Sharing Completed"];
    else    [OBLLog logGPMessage:@"Posting failed"];


}

- (void)didDisconnectWithError:(NSError *)error {
    if (error)
    {
        [OBLLog GPErrorLog:error];

    } else
    {
        // The user is signed out and disconnected.
        // Clean up user data
        [OBLLog logGPMessage:@"Clean Up"];

    }
}

- (IBAction)signInClicked:(id)sender {
    
   NSError *error= [[OBLGooglePlusLogin sharedInstance] login];
    
    if(!error)
    {
        self.signIn.hidden=YES;
        self.signOut.hidden=NO;
        self.disconnect.hidden=NO;
        
        self.shareButton.hidden=NO;
        self.profileButton.hidden=NO;
    }
    else
    {
        [OBLLog GPErrorLog:error];

    }
}

-(void) refereshView
{
    self.signIn.hidden=NO;
    self.signOut.hidden=YES;
    self.disconnect.hidden=YES;
    
    self.shareButton.hidden=YES;
    self.profileButton.hidden=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    OBLGooglePlusLogin *gpl=[OBLGooglePlusLogin sharedInstance];
    
    gpl.clientID=@"592155868142-t4dtrahjvtfhvsdi997aq712qf1q8pqi.apps.googleusercontent.com";
    gpl.scopes=@[@"https://www.googleapis.com/auth/plus.login"];
    gpl.loginUsingInstalledApp=YES;
    gpl.shouldFetchGooglePlusUser=YES;
    gpl.shouldFetchGoogleUserEmail=YES;
    gpl.shouldFetchGoogleUserID=YES;
    gpl.delegate=self;
    
    [OBLLog setGooglePlusDebug:YES];
    self.shareButton.hidden=YES;
    self.profileButton.hidden=YES;
    self.signOut.hidden=YES;
    self.disconnect.hidden=YES;
    
}
- (void) finishedWithLogin:(NSError *)error
{
    if(error)
    {
        [OBLLog GPErrorLog:error];
    }
    else
    {
        [OBLLog logGPMessage:@"Success"];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
