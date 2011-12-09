//
//  friendsAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayPickerView.h"

@interface friendsAvail : UIViewController
{
    IBOutlet DayPickerView *dayPicker;
    IBOutlet UITableView *table;
    IBOutlet UIPickerView *filterPicker;
    NSArray *names;
    NSArray *times;
    NSString *filterText;
    BOOL *compatibleOnly;
}
-(IBAction)toggleCompatible:(id)sender;
-(IBAction)saveFilter:(id)sender;

//@property (nonatomic, retain) NSString *compatibleOnly;
@property (nonatomic, retain) NSArray *times;
@property (nonatomic, retain) NSArray *names;
@property (nonatomic, retain) NSString *filterText;
@property (nonatomic, retain) IBOutlet DayPickerView *dayPicker;


@end
