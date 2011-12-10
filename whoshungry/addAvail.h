//
//  addAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "DayPickerView.h"

@interface addAvail : UIViewController{
    IBOutlet UIDatePicker *timePicker;
    IBOutlet UIDatePicker *endTimePicker;
    IBOutlet DayPickerView *dayPicker;
    IBOutlet UITableView *table;
    IBOutlet UIBarButtonItem *save;
    IBOutlet UINavigationBar *toolbar;
    IBOutlet UITextView *commentBox;
    IBOutlet UIToolbar *commentBar;
    NSString *startTime;
    NSString *endTime;
    NSMutableArray *days;
    NSString *day;
    NSString *notes;
    NSString *dayOfWeek;
    User *myUser;
    NSDate * startDate;
    NSDate * endDate;
}
-(NSString*)getStartTime;
-(NSString*)getEndTime;
-(IBAction)cancel:(id)sender;
-(IBAction)save:(id)sender;
-(IBAction)saveStartTime:(id)sender;
-(IBAction)saveEndTime:(id)sender;
-(IBAction)saveDay:(id)sender;
- (id) initWithUserObject:(User *)user;
-(IBAction)saveComment:(id)sender;


@property (nonatomic, retain) NSString *dayOfWeek;
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *endTime;
@property (nonatomic, retain) NSString *day;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSArray *days;
@property (nonatomic, retain) IBOutlet UIDatePicker *timePicker;
@property (nonatomic, retain) IBOutlet UIDatePicker *endTimePicker;
@property (nonatomic, retain) IBOutlet DayPickerView *dayPicker;
@property (nonatomic, retain) IBOutlet UITextView *commentBox;
@property (nonatomic, retain) IBOutlet UIToolbar *commentBar;
@property (nonatomic, retain) NSDate* startDate;
@property (nonatomic, retain) NSDate* endDate;
@end
