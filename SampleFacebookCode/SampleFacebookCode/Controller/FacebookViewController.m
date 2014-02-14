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
@property (weak, nonatomic) IBOutlet UIButton *fatchButton;
@property (weak, nonatomic) IBOutlet UIButton *requestButton;
@end

@implementation FacebookViewController
- (IBAction)login:(id)sender
{
    //                                  defaultAudience:OBLDefaultAudienceEveryone

    [OBLFacebookLogin loginWithFBReadPermissions:@[EMAIL]
                               andCompletionHandler:^(NSError *error)
                            {
                                if (!error)
                                {
                                    NSLog(@"At start...");
                                }
                            [self buttonChange];
                            }
     ];
     /*
     if (!error && FBSession.activeSession.state == FBSessionStateOpen)
     {
     self.login.enabled = NO;
     self.logout.enabled = YES
     }
     */
    
     /*
     [FacebookLogin loginWithFBCompletionHandler:^{
     NSLog(@"Hello logged in...");
     }];
     */
}

- (IBAction)logout:(id)sender
{
    [OBLFacebookLogin logout];
    [self buttonChange];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self buttonChange];
    /*
     [OBLFacebookQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *result, NSError *error)
     {
     NSLog(@"%@",((OBLFacebookFriend *)[result firstObject]).socialMediaId);
     NSLog(@"%@",((OBLFacebookFriend *)[result lastObject]).socialMediaId);
     }];
     NSLog(@"HAha");
     */
    NSLog(@"permissions: %@",[FBSession activeSession].permissions);
}

- (IBAction)request:(id)sender
{
    [OBLFacebookLogin requestNewPublishPermissions:@[PUBLISH_ACTION]
                              andCompletionHandler:^
     {
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            NSLog(@"Got permission");
                        });

         //[OBLFacebookPost postStatus:@"New1 status check"];
     }
     ];
}


- (IBAction)post:(id)sender
{
    NSLog(@"permissions: %@",[FBSession activeSession].accessTokenData.permissions);

    //[OBLFacebookPost post:@"Hi all"];
    [OBLFacebookPost postStatus:@"my new status"
                      withTitle:@"Tea Time:"
                 andDescription:@"the time when u ask ur brain nothing but it gives much"
                       andImage:@"http://www.gstatic.com/webp/gallery/1.jpg"
                         andURL:@"https://developers.facebook.com/docs/reference/fql/permissions/"];
    
  
}

- (IBAction)fatchDetails:(id)sender
{

    [OBLFacebookQuery fetchUserProfileWithCompletionHandler:^(OBLFacebookUser *result, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            NSLog(@"my id: %@",result.socialMediaId);
                            NSLog(@"my name: %@",result.firstName);
                        });
     }];
    [OBLFacebookQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *result, NSError *error)
     {
         //friends in result array having objects of OBLFacebookFriend
     }];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	//Do any additional setup after loading the view.
    [self buttonChange];
    [OBLLog setFacebookDebug:YES];
}

- (void)buttonChange
{
    if ([OBLFacebookLogin isLogin])
    {
        self.login.enabled = NO;
        self.fatchButton.enabled = YES;
        self.post.enabled = YES;
        self.requestButton.enabled = YES;
        self.logout.enabled = YES;
    }
    else
    {
        self.login.enabled = YES;
        self.fatchButton.enabled = NO;
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
