//
//  OBLFacebookFriendPostHandle.m
//  SampleFacebookCode
//
//  Created by pushparaj on 07/07/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

#import "OBLFacebookFriendPostHandle.h"

@implementation OBLFacebookFriendPostHandle

// Parse LoginWithFantasyCricket response
+ (void)parseResult:(FBWebDialogResult)result withURL:(NSURL *)resultURL delegate:(id <OBLFacebookFriendPostDelegate>)delegate
{
    if (result == FBWebDialogResultDialogNotCompleted)
    {
        // User clicked the "x" icon
        [OBLLog logFBMessage:@"User cancelled feed dialog."];
        if (delegate && [delegate respondsToSelector:@selector(userCancelledFeedDialog)])
        {
            [delegate userCancelledFeedDialog];
        }
    }
    else
    {
        // Handle the publish feed callback
        NSDictionary *urlParams = [OBLFacebookFriendPostHandle parseURLParams:[resultURL query]];
        if (![urlParams valueForKey:@"post_id"])
        {
            // User clicked the Cancel button
            [OBLLog logFBMessage:@"User canceled story publishing."];
            if (delegate && [delegate respondsToSelector:@selector(userCancelledShareToFriend)])
            {
                [delegate userCancelledShareToFriend];
            }
        }
        else
        {
            // User clicked the Share button
            NSString *postId = [urlParams valueForKey:@"post_id"];
            [OBLLog logFBMessage:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"Posted story, id: %@",postId]]];
            if (delegate && [delegate respondsToSelector:@selector(userPostedToFriendWithId:)])
            {
                [delegate userPostedToFriendWithId:postId];
            }
        }
    }
}

+ (NSDictionary*)parseURLParams:(NSString *)query
{
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs)
    {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}
@end
