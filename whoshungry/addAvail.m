//
//  addAvail.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "addAvail.h"
#import "availCell.h"
#import "DayPickerView.h"
#import "FoodTime.h"

@implementation addAvail
@synthesize startTime, endTime, days, day, notes, timePicker, endTimePicker, dayOfWeek, dayPicker, commentBox, commentBar, startDate, endDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editMode)];
        [toolbar setItems:[NSArray arrayWithObject:saveButton] animated:YES];
        [saveButton release];
        
        days = [[NSMutableArray alloc] initWithCapacity:7];
        [days addObject:@"Sunday"];
        [days addObject:@"Monday"];
        [days addObject:@"Tuesday"];
        [days addObject:@"Wednesday"];
        [days addObject:@"Thursday"];
        [days addObject:@"Friday"];
        [days addObject:@"Saturday"];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDayOfWeek:) 
                                                     name:@"changeDay"
                                                   object:nil];   
    }

    return self;
}

- (id) initWithUserObject:(User *)user {
    self = [super init];
    if (self) {
        myUser = user;
    }
    return self;
}

-(IBAction)cancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];   
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dayPicker = [[DayPickerView alloc] initBasic];
    [dayPicker view].frame= CGRectMake(0, 250, 320, 250);
    [[self view] addSubview:[dayPicker view]];
    [dayPicker setHidden:YES];
    // Do any additional setup after loading the view from its nib.
    self.endTimePicker.hidden = YES;
    self.commentBox.hidden = YES;
    self.commentBar.hidden = YES;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 3;
    }
    if(section == 1){
        return 1;
    }
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"availCell";
    
    availCell *cell = (availCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle]
                                    loadNibNamed:@"availCell" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects){
            if([currentObject isKindOfClass:[UITableViewCell class]]){
                cell = (availCell *) currentObject;
                break;
            }
        }
    }
    
    NSLog(@"loading cells");
	
    if([indexPath section] == 0){
        if(indexPath.row == 0){
            cell.timeLabel.text = @"Start Time";
            cell.daysLabel.text = self.startTime;
            [cell becomeFirstResponder];
        }
        if(indexPath.row == 1){
            cell.timeLabel.text = @"End Time";
            cell.daysLabel.text = self.endTime;
        }
        if(indexPath.row == 2){
            cell.timeLabel.text = @"Days";
            cell.daysLabel.text = day;
        }
    }
    if([indexPath section] == 1){
        cell.timeLabel.text = @"Notes";
        cell.daysLabel.text = notes;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	return cell; 
}

// Actions 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if([indexPath section] == 0){
        if([indexPath row] == 0){
            [dayPicker setHidden:YES];
            self.timePicker.hidden = NO;
            self.endTimePicker.hidden = YES;
            self.commentBox.hidden = YES;                       
            self.commentBar.hidden = YES;
        }
        if([indexPath row] == 1){
            [dayPicker setHidden:YES];
            self.endTimePicker.hidden = NO;
            self.timePicker.hidden = YES;
            self.commentBox.hidden = YES;
            self.commentBar.hidden = YES;
        }
        if([indexPath row] == 2){
            self.endTimePicker.hidden = YES;
            self.timePicker.hidden = YES;
            self.commentBox.hidden = YES;
            [dayPicker setHidden:NO];
            self.commentBar.hidden = YES;
        }
    }
    if([indexPath section] == 1){
        self.commentBox.hidden = NO;
        [commentBox becomeFirstResponder];
        self.commentBar.hidden = NO;
    }
	
}


//Save Button
- (IBAction)save:(id)sender
{
    
    FoodTime * newTime = [[FoodTime alloc] initWithDates:startDate endTime:endDate day:[days indexOfObject:self.day] note:self.notes];
    [myUser addFoodTime:newTime];
    [myUser updateRemote];
    [self dismissModalViewControllerAnimated:YES];   
}


-(NSString*)getStartTime{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    [outputFormatter autorelease];
    return [outputFormatter stringFromDate:self.timePicker.date];   
}
-(NSString*)getEndTime{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    [outputFormatter autorelease];
    return [outputFormatter stringFromDate:self.endTimePicker.date]; 
}

- (IBAction)saveStartTime:(id)sender{
    NSLog(@"save start time");
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.startTime = [outputFormatter stringFromDate:self.timePicker.date];
    self.startDate = [self.timePicker.date copy];
    [table reloadData];
    [outputFormatter release];
}
- (IBAction)saveEndTime:(id)sender{
    NSLog(@"save end time");
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.endTime = [outputFormatter stringFromDate:self.endTimePicker.date];
    self.endDate = [self.endTimePicker.date copy];


    [table reloadData];
    [outputFormatter release]; 
}


- (IBAction)saveDay:(NSNotification *) notification{
    if ([[notification name] isEqualToString:@"dayOfWeek"])
        NSLog (@"Successfully received the test notification!");
}
- (IBAction)saveComment:(id)sender{
    self.commentBar.hidden = YES;
    self.commentBox.hidden = YES;
    self.notes = self.commentBox.text;
    [commentBox resignFirstResponder];
}
- (void) receiveDayOfWeek:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"changeDay"]){
        int row = [[[notification userInfo] valueForKey:@"pass"] intValue];
        self.day = [self.days objectAtIndex:row];
        [table reloadData];
    }
}
@end
