//
//  User.h
//  whoshungry
//
//  Created by Paul Carleton on 11/18/11.
//  Copyright 2011 Washington University in St. Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    NSString *phoneNumber;
    NSMutableDictionary *availability;
    NSString *userId;
    NSMutableArray *friends;
    NSString *name;
}

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSMutableDictionary *availability;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, retain) NSMutableArray *friends;
@property (nonatomic, copy) NSString *name;

- (id) initWithDictionary:(NSDictionary *)dict;

- (id) initWithPhoneNumber:(NSString *)dict;
-(NSString*)getNameFromPhoneNumber:(NSString*)number;
-(NSString*)createFriendship:(NSString*)number;
+ (NSArray *) findAllRemote;
+(NSString*)checkUserExistence:(NSString*)number;

- (void)createRemote;
- (void)updateRemote;
- (void)saveRemote;
- (void)destroyRemote;


@end
