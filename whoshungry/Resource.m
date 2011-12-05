//
//  Resource.m
//  whoshungry
//
//  Created by Paul Carleton on 11/18/11.
//  Copyright 2011 Washington University in St. Louis. All rights reserved.
//

#import "Resource.h"

@implementation Resource

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (NSString *)get:(NSString *)url {
    return [self sendBy:@"GET" to:url withBody:nil];
}

+ (NSString *)post:(NSString *)body to:(NSString *)url {
    return [self sendBy:@"POST" to:url withBody:body];
}

+ (NSString *)put:(NSString *)body to:(NSString *)url {
    return [self sendBy:@"PUT" to:url withBody:body];
}

+ (NSString *)delete:(NSString *)url {
    return [self sendBy:@"DELETE" to:url withBody:nil];
}

+ (NSString *)sendBy:(NSString *)method to:(NSString *)url withBody:(NSString *)body {
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:method];
    if (body) {
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return [self sendRequest:request];
}

+ (NSString *)sendRequest:(NSMutableURLRequest *)request {
    NSHTTPURLResponse *response;
    NSError *error;
    
    NSData *responseData =
    [NSURLConnection sendSynchronousRequest:request                        
                          returningResponse:&response
                                      error:&error];
    
    NSString *responseString =
    [[NSString alloc] initWithData:responseData
                          encoding:NSUTF8StringEncoding];
    [responseString autorelease];
    NSLog(responseString);
    return responseString;
}


@end
