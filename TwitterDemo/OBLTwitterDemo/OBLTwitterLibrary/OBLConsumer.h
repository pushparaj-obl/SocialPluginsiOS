//
//  OBLConsumer.h
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/12/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OBLConsumer : NSObject

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *secret;

+ (OBLConsumer *)consumerWithKey:(NSString *)key secret:(NSString *)secret;

@end