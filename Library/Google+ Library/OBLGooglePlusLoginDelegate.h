//
//  OBLGooglePlusLoginDelegate.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/18/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//


// A protocol implemented by the client of |OBLGooglePlusLogin| to receive a refresh
// token or an error.

#import <Foundation/Foundation.h>



@protocol  OBLGooglePlusLoginDelegate

// The authorization has finished and is successful if |error| is |nil|.
- (void) finishedWithLogin:(NSError *)error;

// Finished disconnecting user from the app.
// The operation was successful if |error| is |nil|.
- (void)didDisconnectWithError:(NSError *)error;

@end

@interface OBLGooglePlusLoginDelegate : NSObject
@end
