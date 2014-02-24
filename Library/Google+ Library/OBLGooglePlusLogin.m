//
//  OBLGooglePlusLogin.m
//  GooglePlusDemo
//
//  Created by Jeneena Jose on 2/11/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

#import "OBLGooglePlusLogin.h"

@implementation OBLGooglePlusLogin

#pragma mark - Singleton Instantiation

static OBLGooglePlusLogin * _sharedInstance = nil;

+ (OBLGooglePlusLogin  *)sharedInstance
{
    @synchronized([OBLGooglePlusLogin class])
    {
        if (!_sharedInstance)   _sharedInstance= [[self alloc] init];
        
        return _sharedInstance;
    }
    
    return nil;
}

#pragma mark -  Silent Authentication

- (BOOL)trySilentAuthentication
{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.clientID=self.clientID;
    signIn.scopes=self.scopes;
    signIn.actions=self.actions;
    signIn.delegate=self;
    return  [[GPPSignIn sharedInstance] trySilentAuthentication];
}

#pragma mark - Log in

- (NSError *) login
{
    if(!self.clientID|| !self.scopes)
    {
        NSError *err=[[NSError alloc]initWithDomain:@"ClientID and Scopes not specified" code:0 userInfo:nil];
        [OBLLog GPErrorLog:err];
        return err;
    }
    else
    {
        GPPSignIn *signIn = [GPPSignIn sharedInstance];
        [GPPSignInButton class];
        signIn.clientID=self.clientID;
        signIn.scopes=self.scopes;
        signIn.actions=self.actions;
        signIn.shouldFetchGooglePlusUser = self.shouldFetchGooglePlusUser;
        signIn.shouldFetchGoogleUserEmail=self.shouldFetchGoogleUserEmail;
        signIn.shouldFetchGoogleUserID=self.shouldFetchGoogleUserID;
        signIn.delegate=self;
        [signIn authenticate];
        return nil;
    }
}

//called after login to show authenication result
- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    [OBLLog GPErrorLog:error];
    [OBLLog logGPMessage:auth.accessToken];
    NSError *err;

    if(error.code == -1)
    {
        NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : @"User has cancelled sign in process"};
        err = [[NSError alloc] initWithDomain:@"google+signin"  code:-1 userInfo:errorDictionary];
    }
    else
    {
        err=nil;
    }

    if(auth) self.authentication =auth;

    [self.delegate finishedWithLogin:err];
}

#pragma mark - Log Out

- (BOOL) logout
{
    [[GPPSignIn sharedInstance]signOut];
    self.authentication=[GPPSignIn sharedInstance].authentication;
    if([GPPSignIn sharedInstance].authentication) return NO;
    else return YES;
}


#pragma mark - Disconnect

- (void)disconnect
{
    [[GPPSignIn sharedInstance] disconnect];
}

//delegate called after disconnect
- (void)didDisconnectWithError:(NSError *)error
{
    [self.delegate didDisconnectWithError:error];
}


#pragma mark - HandleUrl

- (BOOL)handleURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication  annotation:(id)annotation;
{
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
}

@end
