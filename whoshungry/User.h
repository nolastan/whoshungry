//
//  User.h
//  whoshungry
//
//  Created by Paul Carleton on 11/18/11.
//  Copyright 2011 Washington University in St. Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodTime.h"

@interface User : NSObject {
    NSString *phoneNumber;
    NSMutableArray *availability;
    NSString *userId;
    NSMutableArray *friends;
    NSString *name;
}

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSMutableArray *availability;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, retain) NSMutableArray *friends;
@property (nonatomic, copy) NSString *name;

- (id) initWithDictionary:(NSDictionary *)dict;
-(void)getAvailFromRemote;
- (id) initWithPhoneNumber:(NSString *)dict;
-(NSString*)getNameFromPhoneNumber:(NSString*)number;
-(BOOL)createFriendship:(NSString*)number;
-(NSMutableArray*) getAvailabilitiesForDay:(int)day;

-(void) addFoodTime:(FoodTime *)newFoodtime;

-(NSString*)params;
+ (NSArray *) findAllRemote;
-(void)removeFriend:(User *)frend;
- (void)createRemote;
- (BOOL)updateRemote;
- (void)saveRemote;
- (void)destroyRemote;
-(void) updateFriends;


@end
