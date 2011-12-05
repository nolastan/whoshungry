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
}

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSMutableDictionary *availability;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, retain) NSMutableArray *friends;

- (id) initWithDictionary:(NSDictionary *)dict;

- (id) initWithPhoneNumber:(NSString *)dict;
+ (NSArray *) findAllRemote;

- (void)createRemote;
- (void)updateRemote;
- (void)saveRemote;
- (void)destroyRemote;


@end
