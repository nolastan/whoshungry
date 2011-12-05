//
//  User.m
//  whoshungry
//
//  Created by Paul Carleton on 11/18/11.
//  Copyright 2011 Washington University in St. Louis. All rights reserved.
//

#import "User.h"
#import "JSONKit.h"
#import "Resource.h"

@implementation User

static NSString *siteURL = @"http://localhost:3000";

@synthesize phoneNumber;
@synthesize availability;
@synthesize userId;
@synthesize friends;

-(id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.phoneNumber = [dict valueForKey:@"phone_number"];
        
        self.availability = [dict valueForKey:@"availability"];
        self.userId = [dict valueForKey:@"id"];
    }
    
    return self;
    
}

-(id) initWithPhoneNumber:(NSString *) phoneNumber {
    if (self = [super init]) {
        NSString *url = [NSString stringWithFormat:@"%@/users/%@.json",siteURL, phoneNumber];

        NSString *jsonString = [Resource get:url];
        availability = [[NSMutableDictionary alloc] init];
        
        if (jsonString) {
            NSDictionary *dict = [jsonString objectFromJSONString];
            NSString *userId = [dict valueForKey:@"id"];
            NSLog(@"Got dict from remote id is: %@", jsonString);
            friends = [[NSMutableArray alloc] init];
            
            NSArray *friendsResult = [dict valueForKey:@"friends"];
            
            for (NSDictionary *friend in friendsResult) {
                NSLog(@"%@", [friend valueForKey:@"phone_number"]);
                User *f = [[User alloc ]initWithDictionary:friend];
                [friends addObject:f];
            }
            
            NSDictionary *avails = [dict valueForKey:@"availability"];
            
            NSEnumerator *keyEnum = [avails keyEnumerator];
            NSString *key;
            while(key = [keyEnum nextObject]) {
                NSDictionary *thisDir = [avails objectForKey:key];
                [availability setValue:thisDir forKey:key];
            }
        }
    }
    return  self;
}

- (void) dealloc {
    [phoneNumber release];
    [availability release];
    [super dealloc];
}

+ (NSArray *)findAllRemote {
    NSString *url = [NSString stringWithFormat:@"%@/users.json",siteURL];
    
    
    NSString *jsonString = [Resource get:url];
    
    NSMutableArray *users = [NSMutableArray array];
    
    if (jsonString) {
        NSLog(@"Got from remote: %@",jsonString);
        NSArray *results = [jsonString objectFromJSONString];
        for (NSDictionary *dict in results) {
            User *user = [[User alloc] initWithDictionary:dict];
            [users addObject:user];
            [user release];
        }
        
    }
    return users;
}

- (NSString *)params {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:self.phoneNumber forKey:@"phone_number"];
    [attributes setValue:self.availability forKey:@"availability"];
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObject:attributes forKey:@"user"];
    
    return [params JSONString];
}



- (void)createRemote {
    NSString *url =
    [NSString stringWithFormat:@"%@/users.json", siteURL];
    [Resource post:[self params] to:url];
}

- (void)updateRemote {
    NSString *url =
    [NSString stringWithFormat:@"%@/users/%@.json", siteURL, self.userId];
    [Resource put:[self params] to:url];
}

- (void)saveRemote {
    if (self.userId == nil) {
        [self createRemote];
    } else {
        [self updateRemote];
    }
}

- (void)destroyRemote {
    NSString *url =
    [NSString stringWithFormat:@"%@/users/%@.json", siteURL, self.userId];
    [Resource delete:url];
}

@end
