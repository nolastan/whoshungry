//
//  Resource.h
//  whoshungry
//
//  Created by Paul Carleton on 11/18/11.
//  Copyright 2011 Washington University in St. Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resource : NSObject

+ (NSString *)get:(NSString *)url;
+ (NSString *)post:(NSString *)body to:(NSString *)url;
+ (NSString *)put:(NSString *)body to:(NSString *)url;
+ (NSString *)delete:(NSString *)url;

+ (NSString *)sendBy:(NSString *)method to:(NSString *)url withBody:(NSString *)body;

+ (NSString *)sendRequest:(NSMutableURLRequest *)request;

@end
