//
//  OBLTwitterRequest.m
//  OBLTwitterLibrary
//
//  Created by Akash Patel on 2/14/14.
//  Copyright (c) 2014 Object Lounge. All rights reserved.
//

#import "OBLTwitterRequest.h"

@implementation OBLTwitterRequest

+ (void)signRequest:(NSMutableURLRequest *)request consumer:(OBLConsumer *)consumer
{
    NSString * accessTokenString = [OBLToken loadAccessToken];
    OBLToken * accessToken = [OBLToken tokenWithHTTPResponseBody:accessTokenString];
    [OBLTwitterRequest signRequest:request withToken:accessToken.key tokenSecret:accessToken.secret verifier:nil consumer:consumer];
}

+ (void)signRequest:(NSMutableURLRequest *)request withToken:(NSString *)tokenString tokenSecret:(NSString *)tokenSecretString verifier:(NSString *)verifierString consumer:(OBLConsumer *)consumer {
    
    NSString *consumerKey = [consumer.key fhs_URLEncode];
    NSString *nonce = [NSString fhs_UUID];
    NSString *timestamp = [NSString stringWithFormat:@"%ld",time(nil)];
    NSString *urlWithoutParams = [[self removeURLParams:request.URL] fhs_URLEncode];
    
    // OAuth Spec, Section 9.1.1 "Normalize Request Parameters"
    // build a sorted array of both request parameters and OAuth header parameters
    NSMutableDictionary *mutableParams = [NSMutableDictionary dictionary];
    
    mutableParams[@"oauth_consumer_key"] = consumerKey;
    mutableParams[@"oauth_signature_method"] = @"HMAC-SHA1";
    mutableParams[@"oauth_timestamp"] = timestamp;
    mutableParams[@"oauth_nonce"] = nonce;
    mutableParams[@"oauth_version"] = @"1.0";
    
    if (tokenString.length > 0) {
        mutableParams[@"oauth_token"] = [tokenString fhs_URLEncode];
        if (verifierString.length > 0) {
            mutableParams[@"oauth_verifier"] = [verifierString fhs_URLEncode];
        }
    } else {
        mutableParams[@"oauth_callback"] = @"oob";
    }
    
    NSMutableArray *paramPairs = [NSMutableArray arrayWithCapacity:mutableParams.count];
    
    for (NSString *key in mutableParams.allKeys) {
        [paramPairs addObject:[NSString stringWithFormat:@"%@=%@",[key fhs_URLEncode],[mutableParams[key] fhs_URLEncode]]];
    }
    
    if ([request.HTTPMethod isEqualToString:@"GET"]) {
        
        NSArray *halves = [request.URL.absoluteString componentsSeparatedByString:@"?"];
        
        if (halves.count > 1) {
            NSArray *parameters = [halves[1] componentsSeparatedByString:@"&"];
            
            if (parameters.count > 0) {
                [paramPairs addObjectsFromArray:parameters];
            }
        }
    }
    
    [paramPairs sortUsingSelector:@selector(compare:)];
    
    NSString *normalizedRequestParameters = [[paramPairs componentsJoinedByString:@"&"] fhs_URLEncode];
    
    // OAuth Spec, Section 9.1.2 "Concatenate Request Elements"
    // Sign request elements using HMAC-SHA1
    NSString *signatureBaseString = [NSString stringWithFormat:@"%@&%@&%@",request.HTTPMethod,urlWithoutParams,normalizedRequestParameters];
    
    NSString *tokenSecretSantized = (tokenSecretString.length > 0)?[tokenSecretString fhs_URLEncode]:@""; // this way a nil token won't make a bad signature
    
    NSString *secret = [NSString stringWithFormat:@"%@&%@",[consumer.secret fhs_URLEncode],tokenSecretSantized];
    
    NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [signatureBaseString dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[20];
	CCHmac(kCCHmacAlgSHA1, secretData.bytes, secretData.length, clearTextData.bytes, clearTextData.length, result);
    NSData *theData = [[[NSData dataWithBytes:result length:20] base64Encode]dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *signature = [[[NSString alloc]initWithData:theData encoding:NSUTF8StringEncoding] fhs_URLEncode];
    
	NSString *oauthToken = (tokenString.length > 0)?[NSString stringWithFormat:@"oauth_token=\"%@\", ",[tokenString fhs_URLEncode]]:@"oauth_callback=\"oob\", ";
    NSString *oauthVerifier = (verifierString.length > 0)?[NSString stringWithFormat:@"oauth_verifier=\"%@\", ",verifierString]:@"";
    
    NSString *oauthHeader = [NSString stringWithFormat:@"OAuth oauth_consumer_key=\"%@\", %@%@oauth_signature_method=\"HMAC-SHA1\", oauth_signature=\"%@\", oauth_timestamp=\"%@\", oauth_nonce=\"%@\", oauth_version=\"1.0\"",consumerKey,oauthToken,oauthVerifier,signature,timestamp,nonce];
    
    [request setValue:oauthHeader forHTTPHeaderField:@"Authorization"];
}

+ (id)sendRequest:(NSURLRequest *)request {
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        return error;
    }
    
    if (response == nil) {
        return error;
    }
    
    if (response.statusCode >= 304) {
        return error;
    }
    
    if (data.length == 0) {
        return error;
    }
    
    return data;
}

+ (NSString *)removeURLParams:(NSURL *)url
{
    if (url.absoluteString.length == 0) {
        return nil;
    }
    
    NSArray *parts = [url.absoluteString componentsSeparatedByString:@"?"];
    return (parts.count == 0)?nil:parts[0];
}

// Execute url request
+ (NSError *)sendPOSTRequestForURL:(NSURL *)url andParams:(NSDictionary *)params {
    
    if (![OBLTwitterLogin isLoggedIn]) {
        return [NSError errorWithDomain:@"OBLTwitter" code:401 userInfo:@{NSLocalizedDescriptionKey:@"You are not authorized via OAuth", @"url": url, @"parameters": params}];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0f];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    
    NSString *boundary = [NSString fhs_UUID];
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    OBLConsumer * consumer = [OBLTwitterLogin getConsumer];
    [OBLTwitterRequest signRequest:request consumer:consumer];
    
    NSMutableData *body = [NSMutableData dataWithLength:0];
    
    for (NSString *key in params.allKeys) {
        id obj = params[key];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData *data = nil;
        
        if ([obj isKindOfClass:[NSData class]]) {
            [body appendData:[@"Content-Type: application/octet-stream\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            data = (NSData *)obj;
        } else if ([obj isKindOfClass:[NSString class]]) {
            data = [[NSString stringWithFormat:@"%@\r\n",(NSString *)obj]dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:data];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setValue:@(body.length).stringValue forHTTPHeaderField:@"Content-Length"];
    request.HTTPBody = body;
    
    id retobj = [OBLTwitterRequest sendRequest:request];
    
    if (retobj == nil) {
        return [NSError noDataError];
    }
    
    if ([retobj isKindOfClass:[NSError class]]) {
        return retobj;
    }
    
    id parsed = [self removeNull:[NSJSONSerialization JSONObjectWithData:(NSData *)retobj options:NSJSONReadingMutableContainers error:nil]];
    
    if ([parsed isKindOfClass:[NSDictionary class]]) {
        NSString *errorMessage = parsed[@"error"];
        NSArray *errorArray = parsed[@"errors"];
        if (errorMessage.length > 0) {
            return [NSError errorWithDomain:@"OBLTwitter" code:[parsed[@"code"] intValue] userInfo:@{NSLocalizedDescriptionKey: errorMessage, @"request":request}];
        } else if (errorArray.count > 0) {
            if (errorArray.count > 1) {
                return [NSError errorWithDomain:@"OBLTwitter" code:418 userInfo:@{NSLocalizedDescriptionKey:@"There were multiple errors when processing the request.", @"request":request}];
            } else {
                NSDictionary *theError = errorArray[0];
                return [NSError errorWithDomain:@"OBLTwitter" code:[theError[@"code"]integerValue] userInfo:@{NSLocalizedDescriptionKey: theError[@"message"], @"request":request}];
            }
        }
    }
    
    return nil; // eventually return the parsed response
}

+ (NSError *)errorWithDomain:(NSString *)domain code:(int)code message:(NSString *)message
{
    NSMutableDictionary * details = [NSMutableDictionary dictionary];
    [details setValue:message forKey:NSLocalizedDescriptionKey];
    NSError * error = [NSError errorWithDomain:domain code:code userInfo:details];
    
    return error;
}

+ (id)removeNull:(id)rootObject
{
    if ([rootObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *sanitizedDictionary = [NSMutableDictionary dictionaryWithDictionary:rootObject];
        [rootObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id sanitized = [self removeNull:obj];
            if (!sanitized) {
                [sanitizedDictionary setObject:@"" forKey:key];
            } else {
                [sanitizedDictionary setObject:sanitized forKey:key];
            }
        }];
        return [NSMutableDictionary dictionaryWithDictionary:sanitizedDictionary];
    }
    
    if ([rootObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *sanitizedArray = [NSMutableArray arrayWithArray:rootObject];
        [rootObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id sanitized = [self removeNull:obj];
            if (!sanitized) {
                [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:@""];
            } else {
                [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:sanitized];
            }
        }];
        return [NSMutableArray arrayWithArray:sanitizedArray];
    }
    
    if ([rootObject isKindOfClass:[NSNull class]]) {
        return (id)nil;
    } else {
        return rootObject;
    }
}

@end
