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
    NSString *availability;
    NSString *userId;
}

@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *availability;
@property (nonatomic, copy) NSString *userId;

- (id) initWithDictionary:(NSDictionary *)dict;

+ (NSArray *) findAllRemote;

- (void)createRemote;
- (void)updateRemote;
- (void)saveRemote;
- (void)destroyRemote;


@end
