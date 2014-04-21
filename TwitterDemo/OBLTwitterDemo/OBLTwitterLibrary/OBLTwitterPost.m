//
//  OBLTwitterPost.m
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/14/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLTwitterPost.h"

static NSString * const url_statuses_update = @"https://api.twitter.com/1.1/statuses/update.json";

@implementation OBLTwitterPost


// Tweet on Twitter
+ (NSError *)tweet:(NSString *)tweetString
{
    if (tweetString.length == 0) {
        return [NSError badRequestError];
    }
    
    if (tweetString.length > 140)
    {
        // Truncate string to pass first 137 characters only. Last 3 characters would be @"...".
        tweetString = [[tweetString substringToIndex:136] stringByAppendingString:@"..."];
    }
    
    NSURL *baseURL = [NSURL URLWithString:url_statuses_update];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
    params[@"status"] = tweetString;
    
    NSError * error = [OBLTwitterRequest sendPOSTRequestForURL:baseURL andParams:params];
    
    if (error)
    {
        [OBLLog logMessage:[NSString stringWithFormat:@"Tweet unsuccessful. Error : %@", error]];
    }
    else
    {
        [OBLLog logMessage:[NSString stringWithFormat:@"Tweet successful with text : %@", tweetString]];
    }
    
    return error;
}


@end
