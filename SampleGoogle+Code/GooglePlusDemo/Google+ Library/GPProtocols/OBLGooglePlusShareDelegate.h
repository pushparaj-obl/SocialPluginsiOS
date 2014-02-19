//
//  OBLGooglePlusShareDelegate.h
//  Google+Demo
//
//  Created by Jeneena Jose on 2/17/14.
//  Copyright (c) 2014 Jeneena Jose. All rights reserved.
//

// A protocol implemented by the client of |OBLGooglePlusShare| to know
// whether a post is shared successfully or not

#import <Foundation/Foundation.h>

@protocol  OBLGooglePlusShareDelegate


// Finished sharing post from the app
// The operation was successful if |shared| is YES
- (void) sharingCompleted:(BOOL)shared;

@end

@interface OBLGooglePlusShareDelegate : NSObject

@end
