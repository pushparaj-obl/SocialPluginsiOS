//
//  OBLTwitter.m
//  OBLTwitterDemo
//
//  Created by Akash Patel on 2/16/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLTwitter.h"

@implementation OBLTwitter

+ (OBLTwitter *)sharedInstance {
    static OBLTwitter *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc]init];
    });
    return sharedInstance;
}

//- (void)setConsumerKey:(NSString *)consumerKey secret:(NSString *)consumerSecret
//{
//    self.consumerKey = consumerKey;
//    self.consumerSecret = consumerSecret;
//}

//- (NSError *)login
//{
//    // Check if logged in
//    if ([OBLTwitterLogin isLoggedIn])
//    {
//        NSLog(@"Logged in.");
//    }
//    else
//    {
//        if (!self.consumerKey || !self.consumerSecret)
//        {
//            return [NSError errorWithDomain:@"OBLTwitter" code:403 userInfo:@{NSLocalizedDescriptionKey:@"Consumer key and/or secret not set."}];
//        }
//        
//        NSLog(@"Not logged in.");
//        
//        // Present login screen
//        OBLLoginViewController * loginController = [[OBLLoginViewController alloc] init];
//        //        loginController.backgroundColor = [UIColor blueColor];
//        loginController.loginDelegate = self.loginDelegate;
//        
//        [self presentViewController:loginController animated:YES completion:nil];
//    }
//    
//    return nil;
//}

- (void)logout
{
    [OBLTwitterLogin logout];
}

- (NSError *)tweet:(NSString *)status
{
    return [OBLTwitterPost tweet:status];
}

@end
