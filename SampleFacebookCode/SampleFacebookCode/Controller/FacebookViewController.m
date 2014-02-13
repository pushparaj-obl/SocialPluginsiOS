//
//  FacebookViewController.m
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "FacebookViewController.h"
#import "FacebookLogin.h"
#import "OBLFacebookQuery.h"
#import "OBLFacebookPost.h"
#import "OBLFacebookPermission.h"

@interface FacebookViewController ()
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UIButton *logout;
@property (weak, nonatomic) IBOutlet UIButton *post;
@property (weak, nonatomic) IBOutlet UIButton *fatchButton;
@end

@implementation FacebookViewController
- (IBAction)login:(id)sender
{
    NSError *error=[FacebookLogin loginWithFBReadPermissions:@[EMAIL]
                                        andCompletionHandler:^{
                                            NSLog(@"hi all permission....");
                                            [self buttonChange];
                                            
                                            /*login check
                                             FBRequest* myRequest = [FBRequest requestForMe];
                                             [myRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                             NSDictionary<FBGraphUser>* result,
                                             NSError *error) {
                                             NSLog(@"gender: %@",[result objectForKey:@"gender"]);
                                             NSLog(@"id: %@",[result objectForKey:@"id"]);
                                             NSLog(@"username: %@",[result objectForKey:@"username"]);
                                             NSLog(@"email : %@",[result objectForKey:@"email"]);
                                             }];
                                             */
                                        }
                    ];
    /*
     if (!error && FBSession.activeSession.state == FBSessionStateOpen)
     {
     self.login.enabled = NO;
     self.logout.enabled = YES;
     
     }
     */
    /*
     [FacebookLogin loginWithFBCompletionHandler:^{
     NSLog(@"Hello logged in...");
     }];
     */
    NSLog(@"%@",error);
}

- (IBAction)logout:(id)sender
{
    BOOL logout=[FacebookLogin logout];
    NSLog(@"%d",logout);
    if (logout)
    {
        self.login.enabled = YES;
        self.logout.enabled = NO;
    }
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


- (IBAction)post:(id)sender
{
    NSLog(@"permissions: %@",[FBSession activeSession].accessTokenData.permissions);
    [FacebookLogin requestNewPublishPermissions:@[PUBLISH_ACTION]
                           andCompletionHandler:^
     {
         NSLog(@"Got permission");
         //              [OBLFacebookPost postStatus:@"New1 status check"];
         [OBLFacebookPost postStatus:@"my new status"
                           withTitle:@"Tea Time:"
                      andDescription:@"the time when u ask ur brain nothing but it gives much"
                            andImage:@"http://www.gstatic.com/webp/gallery/1.jpg"
                              andURL:@"https://developers.facebook.com/docs/reference/fql/permissions/"];
         
     }
     ];
    
}

- (IBAction)fatchDetails:(id)sender
{
    [OBLFacebookQuery fetchUserProfileWithCompletionHandler:^(OBLFacebookUser *result, NSError *error)
     {
         NSLog(@"my id: %@",result.socialMediaId);
         NSLog(@"my name: %@",result.firstName);
     }];
    
    [OBLFacebookQuery fetchFriendsProfileWithCompletionHandler:^(NSArray *result, NSError *error)
     {
         NSLog(@"friend id:%@",((OBLFacebookFriend *)[result firstObject]).socialMediaId);
         NSLog(@"friend name:%@",((OBLFacebookFriend *)[result firstObject]).firstName);
     }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	//Do any additional setup after loading the view.
    [self buttonChange];
    [FacebookLogin debugON:YES];
}

- (void)buttonChange
{
    if ([FacebookLogin isLogin])
    {
        self.login.enabled = NO;
        self.fatchButton.enabled = YES;
        self.post.enabled = YES;
        self.logout.enabled = YES;
    }
    else
    {
        self.login.enabled = YES;
        self.fatchButton.enabled = NO;
        self.post.enabled = NO;
        self.logout.enabled = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
