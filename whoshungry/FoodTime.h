//
//  FoodTime.h
//  whoshungry
//
//  Created by Paul Carleton on 12/9/11.
//  Copyright 2011 Washington University in St. Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodTime : NSObject {
    int dow, start, end;
    NSString * comment;
}

@property (nonatomic) int dow, start, end;
@property (nonatomic, retain) NSString * comment;

-(BOOL) isCompatible:(FoodTime *)other;
-(BOOL) inRange:(int)check;

- (id) initWithDict:(NSDictionary *)dict;
- (id) initWithDates:(NSDate *)s endTime:(NSDate *)e day:(int)d note:(NSString *)n;
-(NSString *) endTime;
-(NSString *) startTime;
-(NSString *) timeRange;

-(NSDictionary *) asDict;

+ (int) minutesSinceMidnight:(NSDate *)date;
@end
