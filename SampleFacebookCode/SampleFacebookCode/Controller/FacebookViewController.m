//
//  FacebookViewController.m
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "FacebookViewController.h"
#import "OBLFacebookLogin.h"
#import "OBLFacebookQuery.h"
#import "OBLFacebookPost.h"
#import "OBLFacebookPermission.h"

@interface FacebookViewController ()
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UIButton *logout;
@property (weak, nonatomic) IBOutlet UIButton *post;
@property (weak, nonatomic) IBOutlet UIButton *fetchButton;
@property (weak, nonatomic) IBOutlet UIButton *requestButton;
@property (weak, nonatomic) IBOutlet UIButton *fetchFriendButton;
@end

@implementation FacebookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Do any additional setup after loading the view.
    
    //changes the state of all buttons.
    [self buttonChange];
    
    //Enables the debugging(Enable log) functionality for facebook.
    //can also disable it with argument NO to the function.
    [OBLLog setFacebookDebug:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //changes the state of all buttons.
    [self buttonChange];
    
    //display all the permission that current session is having
    NSLog(@"permissions: %@",[FBSession activeSession].permissions);
}


- (IBAction)login:(id)sender
{
    //login with facebook with basic info and email permission. Permissions are listed in OBLFacebookPermission class.
    [OBLFacebookLogin loginWithFBReadPermissions:@[EMAIL]
                               andCompletionHandler:^(NSError *error)
                            {
                                if (!error)
                                {
                                    NSLog(@"At start...");
                                }
                                //changes the state of all buttons after login.
                                [self buttonChange];
                            }
     ];
}

- (IBAction)request:(id)sender
{
    //request new publish permission
    [OBLFacebookLogin requestNewPublishPermissions:@[PUBLISH_ACTION]
                                   defaultAudience:OBLDefaultAudienceFriends
                              andCompletionHandler:^(NSError *error)
                            {
                                NSLog(@"Got permission");
                                //[OBLFacebookPost postStatus:@"New status check post"];
                            }
     ];
}


- (IBAction)fetchUserDetails:(id)sender
{
    
    //fetch the user profile
    //returns object of OBLFacebookUser class and error if any in completion handler.
    [OBLFacebookQuery fetchUserProfileWithCompletionHandler:^(OBLFacebookUser *result, NSError *error)
     {
         NSLog(@"my id: %@",result.socialMediaId);
         NSLog(@"my name: %@",result.firstName);
     }];
    
}
- (IBAction)fetchFriendDetails:(id)sender
{
    //fetch the user's friends' profile
    //returns array of objects of OBLFacebookFriend class and error if any in completion handler.
    [OBLFacebookQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *result, NSError *error)
     {
         //friends's profile in "result" array having objects of OBLFacebookFriend
         for (OBLFacebookFriend *friend in result)
         {
             NSLog(@"friend's id: %@",friend.socialMediaId);
             NSLog(@"friend's name: %@",friend.name);
         }
         
     }];
}


- (IBAction)post:(id)sender
{
    //display all the permission that current session is having
    NSLog(@"permissions: %@",[FBSession activeSession].accessTokenData.permissions);

    //post wiht status message
    //[OBLFacebookPost post:@"Hi all"];
    
    //Demo post with status, title, description of link, url of image and url of link respectively.
    //can pass nil as parameters.
    //status:- status message for posting
    //titile:- title of link
    //description:- description of link
    //imageUrl:- preview image associated with the link(image url)
    //LinkUrl:- the URL of a link to attach to the post
    [OBLFacebookPost postStatus:@"Check out our social media library"
                      withTitle:@"SocialPluginsiOS:"
                 andDescription:@"Easy to integrate social media with ios."
                       imageUrl:@"http://images.apple.com/v/iphone-5s/gallery/b/images/download/photo_1.jpg#photo-gallery1"     //sample image
                        linkUrl:@"https://github.com/ObjectLounge/SocialPluginsiOS"
          withCompletionHandler:^(NSError *error)
                        {
                            NSLog(@"Posted");
                        }
     ];
}

- (IBAction)logout:(id)sender
{
    //perform logout from facebook
    [OBLFacebookLogin logout];
    
    //changes the state of all buttons after logout.
    [self buttonChange];
}

- (void)buttonChange
{
    //check if user is already logged in or not
    if ([OBLFacebookLogin isLogin])
    {
        self.login.enabled = NO;
        self.fetchButton.enabled = YES;
        self.fetchFriendButton.enabled = YES;
        self.post.enabled = YES;
        self.requestButton.enabled = YES;
        self.logout.enabled = YES;
    }
    else
    {
        self.login.enabled = YES;
        self.fetchButton.enabled = NO;
        self.fetchFriendButton.enabled = NO;
        self.post.enabled = NO;
        self.requestButton.enabled = NO;
        self.logout.enabled = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
