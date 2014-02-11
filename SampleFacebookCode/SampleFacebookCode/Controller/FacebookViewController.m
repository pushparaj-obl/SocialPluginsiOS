//
//  FacebookViewController.m
//  FacebookLibrary
//
//  Created by Pushparaj Zala on 2/7/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "FacebookViewController.h"
#import "FacebookLogin.h"

@interface FacebookViewController ()
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UIButton *logout;
@end

@implementation FacebookViewController
- (IBAction)login:(id)sender
{
    NSError *error=[FacebookLogin loginWithFBPublishPermissions:@[@"basic_info", @"email", @"user_likes",@"user_birthday",@"email",@"read_friendlists",@"user_education_history"]
                            andCompletionHandler:^{
                                NSLog(@"hi all permission....");
                                
                                FBRequest* myRequest = [FBRequest requestForMe];
                                [myRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                                         NSDictionary<FBGraphUser>* result,
                                                                         NSError *error) {
                                    NSLog(@"gender: %@",[result objectForKey:@"gender"]);
                                    NSLog(@"id: %@",[result objectForKey:@"id"]);
                                    NSLog(@"username: %@",[result objectForKey:@"username"]);
                                    NSLog(@"email : %@",[result objectForKey:@"email"]);
                                 }];

                            }];
    if (!error)
    {
        self.login.enabled = NO;
        self.logout.enabled = YES;
    }
    /*
    [FacebookLogin loginWithFBCompletionHandler:^{
        NSLog(@"Hello logged in...");
    }];
     */
    
    /*
     NSError *error2=[FacebookLogin loginWithFBReadPermissions:@[@"basic_info", @"email"]
                                          andCompletionHandler:^{
                                              NSLog(@"hi all permission....");
                                              
                                              FBRequest* myRequest = [FBRequest requestForMe];
                                              [myRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                                                       NSDictionary<FBGraphUser>* result,
                                                                                       NSError *error) {
                                                  NSLog(@"gender: %@",[result objectForKey:@"gender"]);
                                                  NSLog(@"id: %@",[result objectForKey:@"id"]);
                                                  NSLog(@"username: %@",[result objectForKey:@"username"]);
                                                  NSLog(@"email : %@",[result objectForKey:@"email"]);
                                              }];
                                              
                                          }];
        */
 
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self buttonChange];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self buttonChange];
}

- (void)buttonChange
{
    if ([FacebookLogin isLogin])
    {
        self.login.enabled = NO;
        self.logout.enabled = YES;
    }
    else
    {
        self.login.enabled = YES;
        self.logout.enabled = NO;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
