//
//  friendsAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayPickerView.h"
#import "User.h"

@interface friendsAvail : UIViewController
{
    IBOutlet DayPickerView *dayPicker;
    IBOutlet UITableView *table;
    IBOutlet UIPickerView *filterPicker;
    NSMutableArray *names;
    NSMutableArray *times;
    NSString *filterText;
    BOOL *compatibleOnly;
    NSMutableArray *days;
    User* myUser;
}
-(IBAction)toggleCompatible:(id)sender;
-(IBAction)saveFilter:(id)sender;
- (void) receiveDayOfWeek:(NSNotification *) notification;
-(id)initWithUserObject:(User*)user;
//@property (nonatomic, retain) NSString *compatibleOnly;
@property (nonatomic, retain) NSArray *days;
@property (nonatomic, retain) NSArray *times;
@property (nonatomic, retain) NSArray *names;
@property (nonatomic, retain) NSString *filterText;
@property (nonatomic, retain) IBOutlet DayPickerView *dayPicker;


@end
