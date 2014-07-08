//
//  OBLFacebookFriendPostHandle.h
//  SampleFacebookCode
//
//  Created by pushparaj on 07/07/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "OBLLog.h"

@protocol OBLFacebookFriendPostDelegate <NSObject>

// Delegate For user cancelled the feed dialog, user clicked the "x" icon
- (void)userCancelledFeedDialog;

// Delegate For user peressed cancle on dialog
- (void)userCancelledShareToFriend;

// Delegate For user shared post successfully to his friend
- (void)userPostedToFriendWithId:(NSString *)postId;

@end

@interface OBLFacebookFriendPostHandle : NSObject

+ (void)parseResult:(FBWebDialogResult)result withURL:(NSURL *)resultURL delegate:(id <OBLFacebookFriendPostDelegate>)delegate;

@end
