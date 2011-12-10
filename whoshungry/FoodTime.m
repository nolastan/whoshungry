//
//  FoodTime.m
//  whoshungry
//
//  Created by Paul Carleton on 12/9/11.
//  Copyright 2011 Washington University in St. Louis. All rights reserved.
//

#import "FoodTime.h"

@implementation FoodTime

@synthesize dow, start, end, comment;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        dow = [[dict objectForKey:@"dow"] intValue];
        start = [[dict objectForKey:@"start"] intValue];
        end = [[dict objectForKey:@"end"] intValue];
        
        if ([dict objectForKey:@"comment"] == [NSNull null]) {
            comment = @"No Comments";
        } else {
            comment = [[dict objectForKey:@"comment"] copy];
        }
    }
    return self;
}

- (id) initWithDates:(NSDate *)s endTime:(NSDate *)e day:(int)d note:(NSString *)n {
    self = [super init];
    if (self) {
        dow = d;
        start = [FoodTime minutesSinceMidnight:s];
        end = [FoodTime minutesSinceMidnight:s];
        if ([n length] == 0) {
            comment = @"No Comments";
        } else {
            comment = n;
        }
    }
    return self;
}

+ (int) minutesSinceMidnight:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags =  NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:date];
    
    return 60 * [components hour] + [components minute];    
}

-(NSDictionary *) asDict {
    NSDictionary * result = [[NSDictionary alloc]initWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%d",start], @"start", 
                             [NSString stringWithFormat:@"%d",end], @"end", 
                             [NSString stringWithFormat:@"%d",dow], @"dow", 
                             comment, @"comment", nil];
    
    return result;
}

-(NSString *) intToTime:(int)time {
    NSString * minutes = [NSString stringWithFormat:@"%02d", (time % 60)];
    int hours = time / 60;
    if (hours > 12) {
        return [NSString stringWithFormat:@"%d:%@pm", hours -12, minutes];
    } else if (hours == 12) {
       return [NSString stringWithFormat:@"%d:%@pm", hours, minutes];     
    }else {
        return [NSString stringWithFormat:@"%d:%@am", hours, minutes];

    }
}

-(NSString *) startTime {
    return [self intToTime:start];
}

-(NSString *) endTime {
    return [self intToTime:end];
}


-(BOOL) inRange:(int)check {
    return (check >= start) && (check <= end);
}

-(BOOL) isCompatible:(FoodTime *)other {
    return [self inRange:[other start]] || [self inRange:[other end]] || [other inRange:[self start]];
}

@end
