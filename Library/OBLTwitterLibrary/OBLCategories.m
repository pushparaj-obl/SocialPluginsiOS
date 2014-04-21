//
//  OBLCategories.m
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/12/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLCategories.h"

@implementation NSString (OBLTwitterLibrary)

- (NSString *)fhs_URLEncode {
    CFStringRef url = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
	return (__bridge NSString *)url;
}

- (NSString *)fhs_trimForTwitter {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (string.length > 140)?[string substringToIndex:140]:string;
}

- (NSString *)fhs_stringWithRange:(NSRange)range {
    return [[self substringFromIndex:range.location]substringToIndex:range.length];
}

+ (NSString *)fhs_UUID {
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 6.0f) {
        return [[NSUUID UUID] UUIDString];
    } else {
        CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef string = CFUUIDCreateString(kCFAllocatorDefault, theUUID);
        CFRelease(theUUID);
        NSString *uuid = [NSString stringWithString:(__bridge NSString *)string];
        CFRelease(string);
        return uuid;
    }
}

- (BOOL)fhs_isNumeric {
	const char *raw = (const char *)[self UTF8String];
    
	for (int i = 0; i < strlen(raw); i++) {
		if (raw[i] < '0' || raw[i] > '9') {
            return NO;
        }
	}
	return YES;
}

@end

static char const Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (OBLTwitterLibrary)

- (NSString *)base64Encode {
    int outLength = ((((self.length*4)/3)/4)*4)+(((self.length*4)/3)%4?4:0);
    const char *inputBuffer = self.bytes;
    char *outputBuffer = malloc(outLength+1);
    outputBuffer[outLength] = 0;
    
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp;
    
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    while (inpos < self.length) {
        switch (cycle) {
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos]&0xFC)>>2];
                cycle = 1;
                break;
            case 1:
                temp = (inputBuffer[inpos++]&0x03)<<4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0)>>4];
                temp = (inputBuffer[inpos++]&0x0F)<<2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0)>>6];
                cycle = 4;
                break;
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++]&0x3f];
                cycle = 0;
                break;
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer);
    return pictemp;
}

@end



@implementation NSError (FHSTwitterEngine)

+ (NSError *)badRequestError {
    return [NSError errorWithDomain:@"OBLTwitter" code:400 userInfo:@{NSLocalizedDescriptionKey:@"The request has missing or malformed parameters."}];
}

+ (NSError *)noDataError {
    return [NSError errorWithDomain:@"OBLTwitter" code:204 userInfo:@{NSLocalizedDescriptionKey:@"The request did not return any content."}];
}

+ (NSError *)imageTooLargeError {
    return [NSError errorWithDomain:@"OBLTwitter" code:422 userInfo:@{NSLocalizedDescriptionKey:@"The image you are trying to upload is too large."}];
}

@end
