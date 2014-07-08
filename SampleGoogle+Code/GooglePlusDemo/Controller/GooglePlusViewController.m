//
//  GooglePlus_ViewController.m
//  Google+Demo
//
//  Created by Jeneena Jose on 2/13/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import "GooglePlusViewController.h"

@implementation GooglePlusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    OBLGooglePlusLogin *gpl = [OBLGooglePlusLogin sharedInstance];
    
    //Set your own clientId here.You can get it from Google APIs Console.
    gpl.clientID = @"592155868142-t4dtrahjvtfhvsdi997aq712qf1q8pqi.apps.googleusercontent.com";
    
    gpl.scopes = @[@"https://www.googleapis.com/auth/plus.login"];
   
    //All these values are optional.Set according to your need.
    gpl.loginUsingInstalledApp = YES;
    gpl.shouldFetchGooglePlusUser = YES;
    gpl.shouldFetchGoogleUserEmail = YES;
    gpl.shouldFetchGoogleUserID = YES;
    
    //Setting delegate of <OBLGooglePlusLoginDelegate> to self
    gpl.delegate = self;
    
    //set debugger ON/OFF as per your need.YES will turn on log messages.
    [OBLLog setGooglePlusDebug:YES];
    
    if([gpl trySilentAuthentication])
    {
        [self signInClicked:self];
    }
    
    
    
    [self refereshView];
}

#pragma mark - Sign In

//Signs in the user.
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
        NSLog(@"Successfully logged in");
    }
    
}

#pragma  mark - Fetch Profile details

//fetches user details
- (IBAction)profileButtonClicked:(id)sender
{
    [OBLGooglePlusQuery fetchProfileDetailOfUserWithImageSize:200 completion:^(OBLGooglePlusUser *user, NSError *error)
     {
         if(error)
         {
             NSLog(@"Error :%@  ",error);
         }
         else
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Fetch Status" message:@"Operation succesful.Got your profile data." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
             [alert show];
             NSLog(@"\nUser ID:%@ Email ID:%@",user.socialMediaId,user.email);
             NSLog(@"\nF: %@ M:%@ L:%@",user.firstName, user.middleName, user.lastName);
             NSLog(@"\nProfile name:%@  Birthdate:%@ & Location:%@ & Gender: %@ ", user.name, user.birthdate, user.currentLocation, user.gender);
             NSLog(@"\nProfile URL:%@ ",user.profileUrl);
         }
     }];
}

//fetches the signed in user's friends' profile information
- (IBAction)friendsProfileButtonclicked:(id)sender
{
    self.friendsProfileInfo.enabled=NO;
    [OBLGooglePlusQuery fetchFriendsProfileWithImageSize:200 completionHandler:^(NSArray *friends, NSError *error) {
        
        //NSArray returns an array of objcts of type OBLGooglePlusFriend
        if(error)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Fetch Status" message:@"Query limit exceeded.Details of only some friends are fetched.Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Fetch Status" message:@"Operation succesful.Got friends' profile data." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        for(OBLGooglePlusFriend *friend in friends)
        {
            NSLog(@"F: %@ M:%@ L:%@",friend.firstName, friend.middleName, friend.lastName);
            NSLog(@"\n Profile name:%@  BiIRTHDATE:%@ & LoCaTiOn:%@ & GEnDer: %@ ", friend.name, friend.birthdate, friend.currentLocation, friend.gender);
        }
        self.friendsProfileInfo.enabled=YES;
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
    [gps shareInteractivePost:@"Check it out!!This is too cool."
           withTitle:@"New SuperApp in Town"
      addDescription:@"Get it! Its surely gonna whirl your mind."
         andImageURL:@"https://lh3.googleusercontent.com/proxy/b-cFHz7K29l14N549KTiqiBBngKcpsMwhmCNZ_Vz2gUCCAiAbS-nfi7aztR-kkpJyMM0oA0suAq3QrfTmlNstiXZ0G9I1t8BKddt=w120-h120"
     ];
    
    //Interactive share with URL.
    //To check the list of callTOAction button labels refer the class CallToActinButtonLabels
    //[gps shareInteractivePost:@"Check it out!!" withURL:@"https://www.godaddy.com" withCallToActionLabel:];
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

//Signs out the user.
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

//Disconnects the user.
- (IBAction)disconnectClicked:(id)sender
{
    [[OBLGooglePlusLogin sharedInstance ]disconnect];
    self.disconnect.enabled=NO;
 
}

//Delegate called after disconnecting the user.
- (void)didDisconnectWithError:(NSError *)error
{
    if (error)
    {
        NSLog(@"Error: %@",error.description);
        self.disconnect.enabled=YES;
    }
    else
    {
        NSLog(@"User is disconncted.");
        [self refereshView];
    }
}

#pragma mark - Refresh View

//Used for setting appropriate view.
-(void) refereshView
{
    if([OBLGooglePlusLogin sharedInstance].authentication)
    {
        self.signIn.hidden = YES;
         self.signIn.enabled=YES;
        self.signOut.hidden = NO;
        self.disconnect.hidden = NO;
        self.shareButton.hidden = NO;
        self.profileButton.hidden = NO;
        self.friendsProfileInfo.hidden = NO;
        self.fetchLabel.hidden = NO;
    }
    else
    {
        self.signIn.hidden = NO;
        self.signIn.enabled = YES;
        self.signOut.hidden = YES;
        self.disconnect.hidden = YES;
        self.shareButton.hidden = YES;
        self.profileButton.hidden = YES;
        self.friendsProfileInfo.hidden = YES;
        self.fetchLabel.hidden = YES;
        self.disconnect.enabled=YES;
    }
}

#pragma mark - dealloc

-(void) dealloc
{
    self.signIn = nil;
    self.signIn = nil;
    self.disconnect = nil;
    self.shareButton = nil;
    self.profileButton = nil;
    self.friendsProfileInfo = nil;
    self.fetchLabel = nil;
}

@end
