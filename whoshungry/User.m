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
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation User

static NSString *siteURL = @"http://localhost:3000";

@synthesize phoneNumber;
@synthesize availability;
@synthesize userId;
@synthesize friends;
@synthesize name;

-(id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.phoneNumber = [dict valueForKey:@"phone_number"];
        
        self.availability = [dict valueForKey:@"availability"];
        self.userId = [dict valueForKey:@"id"];
        self.name = [self getNameFromPhoneNumber:self.phoneNumber];
        
        [self getAvailFromRemote];
    }
    
    return self;
    
}

-(id) initWithPhoneNumber:(NSString *) phoneNum {
    if (self = [super init]) {
        NSString *url = [NSString stringWithFormat:@"%@/users/bynum/%@.json",siteURL, phoneNum];
        
        phoneNumber = phoneNum;

        NSString *jsonString = [Resource get:url];
        availability = [[NSMutableDictionary alloc] init];
        NSLog(@"Json result: %@", jsonString);
        
        if (![jsonString isEqualToString:@"null"]) {
            NSDictionary *dict = [jsonString objectFromJSONString];
            userId = [dict valueForKey:@"id"];
            NSLog(@"Got dict from remote id is: %@", jsonString);
            friends = [[NSMutableArray alloc] init];
            
            NSArray *friendsResult = [dict valueForKey:@"friends"];
            
            for (NSDictionary *friend in friendsResult) {
                NSLog(@"%@", [friend valueForKey:@"phone_number"]);
                User *f = [[User alloc ]initWithDictionary:friend];
                [friends addObject:f];
            }
            
            [self getAvailFromRemote];
        
        } else {
            NSLog(@"NO REMOTE USER");
            
            NSLog(@"Posting: %@", [self params]);
            [self createRemote];
            
        }
    }
    NSLog(@"Params: %@", [self params]);
    return  self;
}

-(void)getAvailFromRemote {
    
    NSString *url = [NSString stringWithFormat:@"%@/users/avail/%@.json",siteURL, userId];
    
    NSString *jsonString = [Resource get:url];
    availability = [[NSMutableDictionary alloc] init];
    
    if (jsonString) {
        NSDictionary *dict = [jsonString objectFromJSONString];
        NSArray *times = [dict valueForKey:@"food_times"];
        availability = [[NSMutableArray alloc] initWithCapacity:7];
        for (int i = 0; i < 7; ++i) {
            [availability insertObject:[[NSMutableArray alloc]init] atIndex:i];
        }
        
        //Add availabilities
        for (NSDictionary * t in times) {
            NSString * dayOfWeek = [t objectForKey:@"dow"];
            int dayIndex = [dayOfWeek intValue];
            NSString * start = [t objectForKey:@"start"];
            
            NSString * end = [t objectForKey:@"end" ];
            
            
            NSMutableDictionary * interval = [[NSMutableDictionary alloc] initWithObjectsAndKeys:start, @"start", end, @"end", nil ];
            
            
            [[availability objectAtIndex:dayIndex] addObject:interval];
        }
    }
    
}

-(NSString*)getNameFromPhoneNumber:(NSString*)number{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    NSArray *contacts = (NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSMutableDictionary *peopleDict = [[NSMutableDictionary alloc] init];
    
    if (contacts == nil) {
        NSLog(@"No contacts");
    }else {
        for (int i = 0; i < [contacts count]; ++i) {
            
            ABRecordRef person = (ABRecordRef)[contacts objectAtIndex:i];
            ABMutableMultiValueRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
            
            ABMutableMultiValueRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
            
            ABMutableMultiValueRef phoneNumbers = ABRecordCopyValue( person, kABPersonPhoneProperty);
            NSString *phoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
            
            //NSString *phoneNumber = [(NSString *)phoneNumberRef UTF8String];
            
            NSLog(@"Name : %@ %@", firstName, lastName);
            //NSLog(@"Number: %@", phoneNumber);
            
            
            
            NSScanner *scanner = [NSScanner scannerWithString:phoneNumber];  
            //define the allowed characters, here only numbers from one to three, equal and plus  
            
            //Filter out ('s and spaces
            NSMutableString *filteredNumber = [[NSMutableString alloc] initWithCapacity:phoneNumber.length];
            NSCharacterSet *allowedChars = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"]; 
            
            while ([scanner isAtEnd] == NO) {  
                NSString *buffer;  
                if ([scanner scanCharactersFromSet:allowedChars intoString:&buffer]) {  
                    [filteredNumber appendString:buffer];       
                } else {  
                    [scanner setScanLocation:([scanner scanLocation] + 1)];  
                }  
            }
            
            //Check if it's a match
            if([filteredNumber isEqualToString:number]) {
                NSString *first = firstName;
                NSString *last = lastName;
                return [NSString stringWithFormat:@"%@ %@", first, last];
            }            
        }
    }
    return number;
}

-(void) updateFriends {
    NSString *url = [NSString stringWithFormat:@"%@/users/%@.json",siteURL, userId];
    
    NSString *jsonString = [Resource get:url];
    if (jsonString) {
        NSDictionary *dict = [jsonString objectFromJSONString];
        friends = [[NSMutableArray alloc] init];
        
        NSArray *friendsResult = [dict valueForKey:@"friends"];
        
        for (NSDictionary *friend in friendsResult) {
            NSLog(@"%@", [friend valueForKey:@"phone_number"]);
            User *f = [[User alloc ]initWithDictionary:friend];
            [friends addObject:f];
        }
    }
    
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
    
    
    NSMutableArray *food_times = [[NSMutableArray alloc] init ];
    NSInteger *i = 0;
    for (NSArray *times in self.availability) {
        for (NSDictionary *food_time in times) {
            
            
            NSString *start = [[food_time objectForKey:@"start"] retain];
            NSString *end = [[food_time objectForKey:@"end"] retain];
            NSDictionary *finalDict = [[[NSDictionary alloc] initWithObjectsAndKeys:start, @"start", end, @"end", 0, @"dow", nil] retain];
            
            [start release];
            [end release];
            
            [food_times addObject:finalDict];
            [finalDict release];
            
        }
        
        i++;
    }
    
    NSDictionary *avail_attrs = [[NSDictionary alloc] initWithObjectsAndKeys:food_times , @"food_times_attributes", nil]; 
    
    [attributes setValue:avail_attrs forKey:@"avail_attributes"];
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObject:attributes forKey:@"user"];
    
    return [params JSONString];
}

-(NSString*)createFriendship:(NSString*)number {
    [User checkUserExistence:number];
    NSString *url = [NSString stringWithFormat:@"%@/friendships.json", siteURL];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:@"9" forKey:@"user_id"];
    [attributes setValue:@"12" forKey:@"friend_id"];
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObject:attributes forKey:@"friendship"];
    
    [Resource post:[attributes JSONString] to:url];
}

+(NSString*)checkUserExistence:(NSString*)number {
    NSLog(@"checking user existence");
    NSString *url = [NSString stringWithFormat:@"%@/users/bynum/%@.json",siteURL, number];
    [Resource get:url];
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
