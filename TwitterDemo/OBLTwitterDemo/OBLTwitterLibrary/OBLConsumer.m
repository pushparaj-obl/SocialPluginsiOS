//
//  OBLConsumer.m
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/12/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLConsumer.h"

@interface OBLConsumer ()

@end

@implementation OBLConsumer

+ (OBLConsumer *)consumerWithKey:(NSString *)key secret:(NSString *)secret {
    return [[[self class] alloc] initWithKey:key secret:secret];
}

- (instancetype)initWithKey:(NSString *)key secret:(NSString *)secret {
    self = [super init];
    if (self) {
        self.key = key;
        self.secret = secret;
    }
    return self;
}

@end
