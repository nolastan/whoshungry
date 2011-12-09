//
//  addAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface addAvail : UIViewController{
    IBOutlet UIDatePicker *timePicker;
    IBOutlet UIDatePicker *endTimePicker;
    IBOutlet UIPickerView *dayPicker;
    IBOutlet UITableView *table;
    IBOutlet UIBarButtonItem *save;
    NSString *startTime;
    NSString *endTime;
    NSString *days;
    NSString *notes;
    NSArray *dayOfWeek;
    User *myUser;
}
-(NSString*)getStartTime;
-(NSString*)getEndTime;
-(IBAction)cancel:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)saveStartTime:(id)sender;
-(IBAction)saveEndTime:(id)sender;
- (id) initWithUserObject:(User *)user;

@property (nonatomic, retain) NSArray *daysOfWeek;
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *endTime;
@property (nonatomic, retain) NSString *days;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) IBOutlet UIDatePicker *timePicker;
@property (nonatomic, retain) IBOutlet UIDatePicker *endTimePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *dayPicker;

@end
