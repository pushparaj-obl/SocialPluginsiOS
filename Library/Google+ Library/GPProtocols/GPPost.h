//
//  GPPost.h
//
//  Created by Jeneena Jose on 2/19/14.
//  Copyright (c) 2014 Jeneena. All rights reserved.
//

#import <Foundation/Foundation.h>


//GPPost protocol is be implemented by class OBLGooglePlusShare for providing posting features to social media.
@protocol GPPost

//post method - force subclass to implement the post feature.
//returns YES if sucess and NO otherwise
- (void)post:(NSString *)status;

@end


