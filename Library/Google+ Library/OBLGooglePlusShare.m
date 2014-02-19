//
//  OBLGooglePlusShare.m
//  Google+Demo
//
//  Created by Jeneena Jose on 2/17/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import "OBLGooglePlusShare.h"

@implementation OBLGooglePlusShare

#pragma mark -  Singleton Instantiation

static OBLGooglePlusShare * _sharedInstance = nil;

+ (OBLGooglePlusShare  *)sharedInstance
{
    @synchronized([OBLGooglePlusShare class])
    {
        if (!_sharedInstance)   _sharedInstance= [[self alloc] init];
        
        return _sharedInstance;
    }
    return nil;
}


#pragma mark - GPPShareDelegate


- (void)finishedSharingWithError:(NSError *)error {
    if (!error) {
        NSLog(@"Successfully posted!");
        [OBLLog logGPMessage:@"Successfully posted!"];
        [self.delegate sharingCompleted:YES];

    } else if (error.code == kGPPErrorShareboxCanceled) {
        NSLog(@"Canceled posted!");
        NSError *err;
        NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : @"User has cancelled sharing Post process"};
        err = [[NSError alloc] initWithDomain:@"google+signin"  code:-1 userInfo:errorDictionary];

        [OBLLog GPErrorLog:error];

        [self.delegate sharingCompleted:NO];

    } else {
        NSString  *text = [NSString stringWithFormat:@"Error (%@)", [error localizedDescription]];
        [OBLLog logGPMessage:text];
        [self.delegate sharingCompleted:NO];
    }
}

#pragma mark - Post methods

- (void)post:(NSString *)status;
{
    
    [GPPShare sharedInstance].delegate = self;
    
    // Use the native share dialog in your app:
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    
    [shareBuilder setPrefillText:status];
    
    [shareBuilder open];
}

- (void) shareStatus:(NSString *)status
{
    [GPPShare sharedInstance].delegate = self;
    
    // Use the native share dialog in your app:
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    
    [shareBuilder setPrefillText:status];
  
    [shareBuilder open];

}


- (void) shareStatus:(NSString *)status withTitle:(NSString *)title addDescription:(NSString *)description andImageURL:(NSString *)imageUrl andURL:(NSString *)url
{
    
    [GPPShare sharedInstance].delegate = self;
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    
    // This line will manually fill out the title, description, and thumbnail of the
    // item you're sharing.
    [shareBuilder setTitle:title
               description:description
              thumbnailURL:[NSURL URLWithString:imageUrl]];
    
    // The share preview, which includes the title, description, and a thumbnail,
    // is generated from the page at the specified URL location.
   [shareBuilder setURLToShare:[NSURL URLWithString:url]];
    
    [shareBuilder setPrefillText:@"Check it out!!"];
    
    // This line passes the string "rest=1234567" to your native application
    // if somebody opens the link on a supported mobile device
    [shareBuilder setContentDeepLinkID:@"rest=1234567"];

    if(url)
    {
    // This method creates a call-to-action button with the label "RSVP".
    // - URL specifies where people will go if they click the button on a platform
    // that doesn't support deep linking.
    // - deepLinkID specifies the deep-link identifier that is passed to your native
    // application on platforms that do support deep linking
    [shareBuilder setCallToActionButtonWithLabel:@"RSVP"
                                             URL:[NSURL URLWithString:url]
                                      deepLinkID:@"rsvp=4815162342"];
    
    }
    [shareBuilder open];

}


@end
