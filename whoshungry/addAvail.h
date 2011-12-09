//
//  addAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addAvail : UIViewController{
    IBOutlet UIDatePicker *timePicker;
    IBOutlet UITableView *table;
    NSString *startTime;
    NSString *endTime;
    NSString *days;
    NSString *notes;
}
-(IBAction)cancel:(id)sender;

@property (nonatomic, retain) NSArray *times;
@property (nonatomic, retain) NSString *startTime;
@property (nonatomic, retain) NSString *endTime;
@property (nonatomic, retain) NSString *days;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) IBOutlet UIDatePicker *timePicker;

@end
