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

- (void)finishedSharingWithError:(NSError *)error
{
    BOOL didShare;

    if (!error)
    {
        didShare=YES;
    }
    else if (error.code == kGPPErrorShareboxCanceled)
    {
        didShare=NO;
        NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : @"User has cancelled sharing Post process"};
        NSError *error = [[NSError alloc] initWithDomain:@"google+share"  code:-1 userInfo:errorDictionary];
        [OBLLog GPErrorLog:error];
    }
    else
    {
        [OBLLog GPErrorLog:error];
        didShare=NO;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sharingCompleted:)])
    {
        [self.delegate sharingCompleted:didShare];
    }

}

#pragma mark - Share methods

- (void) share:(NSString *)status;
{
    [self shareStatus:status withURL:nil];
}

-(void) shareStatus:(NSString *)status withURL:(NSString *)url
{
    [GPPShare sharedInstance].delegate = self;
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    
    [shareBuilder setPrefillText:status];
    
    if(url)
    {
        // The share preview includes the title, description, and a thumbnail
        // generated from the page at the specified URL location.
        [shareBuilder setURLToShare:[NSURL URLWithString:url]];
    }
    
    [shareBuilder open];
}

-(void) shareInteractivePost:(NSString *)status withTitle:(NSString *)title addDescription:(NSString *)description andImageURL:(NSString *)imageUrl
{
    [self shareInteractivePost:status withTitle:title addDescription:description andImageURL:imageUrl withURL:nil withCallToActionLabel:nil];
}

- (void) shareInteractivePost:(NSString *)status withURL:(NSString *)url withCallToActionLabel:(NSString *)label
{
    [self shareInteractivePost:status withTitle:nil addDescription:nil andImageURL:nil withURL:url withCallToActionLabel:label];
}

-(void) shareInteractivePost:(NSString *)status withTitle:(NSString *)title addDescription:(NSString *)description andImageURL:(NSString *)imageUrl withURL:(NSString *)url  withCallToActionLabel:(NSString *)label
{
    [GPPShare sharedInstance].delegate = self;
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    
    // This will manually fill out the title, description, and thumbnail of the item you're sharing.
    [shareBuilder setTitle:title
               description:description
              thumbnailURL:[NSURL URLWithString:imageUrl]];
    
    [shareBuilder setPrefillText:status];
    
    // This line passes the string "rest=001198" to your native application
    // if somebody opens the link on a supported mobile device
    [shareBuilder setContentDeepLinkID:@"rest=001198"];
    
    if(url)
    {
         [shareBuilder setURLToShare:[NSURL URLWithString:url]];
        // This method creates a call-to-action button with the given label.
        // - URL specifies where people will go if they click the button on a platform
        // that doesn't support deep linking.
        // - deepLinkID specifies the deep-link identifier that is passed to your native
        // application on platforms that do support deep linking
        [shareBuilder setCallToActionButtonWithLabel:label
                                                 URL:[NSURL URLWithString:url]
                                          deepLinkID:@"ID=905162"];
        
    }
    
    [shareBuilder open];
}

@end
