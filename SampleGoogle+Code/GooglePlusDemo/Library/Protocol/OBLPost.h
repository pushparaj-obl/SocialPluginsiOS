//
//  OBLPost.h
//  SampleFacebookCode
//
//  Created by Pushparaj Zala on 2/11/14.
//  Copyright (c) 2014 Pushparaj Zala. All rights reserved.
//

//Abstract class for post.

#import <Foundation/Foundation.h>

//OBLPost protocol (should be implemented by classes provideing posting features to social media.
@protocol OBLPost

//post method - force subclass to implement the post feature.
//returns YES if sucess and NO otherwise
+ (BOOL)post:(NSString *)status;

@end
