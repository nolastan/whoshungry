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
#import "FoodTime.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation User

static NSString *siteURL = @"http://whoshungry.heroku.com";

@synthesize phoneNumber;
@synthesize availability;
@synthesize userId;
@synthesize friends;
@synthesize name;

-(id) initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        self.phoneNumber = [dict valueForKey:@"phone_number"];
        
        //self.availability = [dict valueForKey:@"availability"];
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
        NSLog(@"URL:%@", url);
        NSLog(@"Json result: %@", jsonString);
        
        if (![jsonString isEqualToString:@"null"]) {
            NSDictionary *dict = [jsonString objectFromJSONString];
            userId = [dict valueForKey:@"id"];
            NSLog(@"Got dict from remote id is: %@", jsonString);
            friends = [[NSMutableArray alloc] init];
            
            NSArray *friendsResult = [dict valueForKey:@"friends"];
            
            for (NSDictionary *friend in friendsResult) {
                NSLog(@"Friend: %@", [friend valueForKey:@"phone_number"]);
                User *f = [[User alloc ]initWithDictionary:friend];
                [friends addObject:f];
            }
            
            [self getAvailFromRemote];
            
            NSLog(@"%@",availability);
        
        } else {
            NSLog(@"NO REMOTE USER");
            
            NSLog(@"Posting: %@", [self params]);
            [self createRemote];
            
        }
    }
    
    return  self;
}

-(void)getAvailFromRemote {
    
    NSString *url = [NSString stringWithFormat:@"%@/users/avail/%@.json",siteURL, userId];
    
    NSString *jsonString = [Resource get:url];
    availability = [[NSMutableDictionary alloc] init];
    
    if (jsonString) {
        NSArray *times = [jsonString objectFromJSONString];
        availability = [[NSMutableArray alloc] initWithCapacity:7];
        for (int i = 0; i < 7; ++i) {
            [availability insertObject:[[NSMutableArray alloc]init] atIndex:i];
        }
        
        //Add availabilities
        for (NSDictionary * t in times) {
            
            FoodTime *ft = [[[FoodTime alloc] initWithDict:t] autorelease];
            
            [[availability objectAtIndex:[ft dow]] addObject:ft];
        }
    }
    
}

-(NSString*)getNameFromPhoneNumber:(NSString*)number{
    ABAddressBookRef addressBook = ABAddressBookCreate();
    NSArray *contacts = (NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
    
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

-(void) addAvailability:(int)dayNumber startTime:(NSString*)startTime endTime:(NSString*)endTime{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:startTime forKey:@"start"];
    [dict setObject:endTime forKey:@"end"];
    [[availability objectAtIndex:dayNumber] addObject:dict];
    [self updateRemote];
}


-(void) addFoodTime:(FoodTime *)newFoodtime {
    NSLog(@"%@", newFoodtime);
    int index = [newFoodtime dow];
    [[availability objectAtIndex:index] addObject:newFoodtime];
    
    [self updateRemote];
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
    for (NSArray *times in self.availability) {
        for (FoodTime *food_time in times) {
            [food_times addObject:[food_time asDict]];
        }
    }
    
    [attributes setValue:food_times forKey:@"food_times_attributes"];
    
    NSMutableDictionary *params = 
    [NSMutableDictionary dictionaryWithObject:attributes forKey:@"user"];
    
    return [params JSONString];
}

-(BOOL)createFriendship:(NSString*)number {
    //[User checkUserExistence:number];
    NSString *url = [NSString stringWithFormat:@"%@/friendships/bynum.json", siteURL];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:userId forKey:@"user_id"];
    [attributes setValue:number forKey:@"friend_number"];
    
    NSString *result = [Resource post:[attributes JSONString] to:url];
    
    if ([result isEqualToString:@"error"]) {
        return NO;
    }
    return YES;
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
