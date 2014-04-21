//
//  OBLViewController.m
//  OBLTwitterDemo
//
//  Created by Akash Patel on 2/16/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLViewController.h"

@interface OBLViewController ()

@property (nonatomic, weak) IBOutlet UIButton * login;
@property (nonatomic, weak) IBOutlet UIButton * logout;
@property (nonatomic, weak) IBOutlet UIButton * tweet;

@end

@implementation OBLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Turn debug logs ON/OFF. Recommended to keep it ON while testing.
    [OBLLog setTwitterDebug:YES];
    
    // If logged in then hide login button, else hide logout button
    if ([OBLTwitterLogin isLoggedIn])
    {
        self.login.hidden = YES;
    }
    else
    {
        self.tweet.hidden = YES;
        self.logout.hidden = YES;
    }
}

- (IBAction)login:(UIButton *)sender
{
    // Check if logged in
    if ([OBLTwitterLogin isLoggedIn])
    {
        [self showAlertWithTitle:nil message:@"Already logged in."];
    }
    else
    {
        // Set consumer key and secret
        [OBLTwitterLogin setConsumerKey:TWITTER_CONSUMER_KEY secret:TWITTER_CONSUMER_SECRET];
        
        // Present login screen
        OBLLoginViewController * loginController = [[OBLLoginViewController alloc] init];
        
        // Set appropriate delegate to handle login completion event
        loginController.loginDelegate = self;
        [self presentViewController:loginController animated:YES completion:nil];
    }
}

- (IBAction)logout:(UIButton *)sender
{
    // Get OBLTwitter instance
    OBLTwitter * twitter = [OBLTwitter sharedInstance];
    [twitter logout];
    
    self.logout.hidden = YES;
    self.tweet.hidden = YES;
    self.login.hidden = NO;
}

- (IBAction)tweet:(UIButton *)sender
{
    // Set consumer key and secret
    [OBLTwitterLogin setConsumerKey:TWITTER_CONSUMER_KEY secret:TWITTER_CONSUMER_SECRET];
    
    // Get OBLTwitter instance
    OBLTwitter * twitter = [OBLTwitter sharedInstance];
    
    // Generating random string to post on Twitter
    NSString * tweet = [NSString stringWithFormat:@"Testing %d", arc4random() % 1000];
    NSError * error = [twitter tweet:tweet];
    
    if (error)
    {
        [self showAlertWithTitle:@"Error" message:@"There was some error in posting tweet."];
    }
    else
    {
        [self showAlertWithTitle:@"Tweet successful" message:[NSString stringWithFormat:@"Status posted : %@", tweet]];
    }
}

// Twitter login delegate methods. It is called when login is completed.
- (void)loginCompleted:(NSError *)error
{
    if (error)
    {
        // If user canceled login process
        if ([error.localizedDescription isEqualToString:LOGIN_CANCELED])
        {
            [self showAlertWithTitle:nil message:@"User canceled login."];
        }
        else
        {
            // Any other error
            [self showAlertWithTitle:@"Error" message:@"There was some error in login."];
        }
    }
    else
    {
        // Login successful
        [self showAlertWithTitle:nil message:@"Login successful."];
        
        self.login.hidden = YES;
        self.logout.hidden = NO;
        self.tweet.hidden = NO;
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.login = nil;
    self.logout = nil;
    self.tweet = nil;
}

@end
