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

@implementation addAvail
@synthesize startTime, endTime, days, notes, timePicker, endTimePicker, dayOfWeek, dayPicker, commentBox, commentBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editMode)];
        [toolbar setItems:[NSArray arrayWithObject:saveButton] animated:YES];
        [saveButton release];
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
    self.timePicker.hidden=YES;
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
            cell.daysLabel.text = days;
        }
    }
    if([indexPath section] == 1){
        cell.timeLabel.text = @"Notes";
        cell.daysLabel.text = notes;
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
        self.timePicker.hidden = YES;
        self.endTimePicker.hidden = YES;
        [dayPicker setHidden:YES];
        self.commentBox.hidden = NO;
        [commentBox becomeFirstResponder];
        self.commentBar.hidden = NO;
    }
	
}

- (IBAction)save:(id)sender
{
//    [myUser addAvailability:@"agh", startTime:[[self getStartTime], endTime:[self getEndTime]]];
    NSLog(@"Save");
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
    [outputFormatter stringFromDate:self.timePicker.date];
    
}
- (IBAction)saveStartTime:(id)sender{
    NSLog(@"save start time");
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.startTime = [outputFormatter stringFromDate:self.timePicker.date];
    [table reloadData];
    [outputFormatter release];
}
- (IBAction)saveEndTime:(id)sender{
    NSLog(@"save end time");
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.endTime = [outputFormatter stringFromDate:self.timePicker.date];
    [table reloadData];
    [outputFormatter release]; 
}

- (IBAction)saveDay:(id)sender{
    NSLog(@"Save day");
}
- (IBAction)saveComment:(id)sender{
    self.commentBar.hidden = YES;
    self.commentBox.hidden = YES;
    self.notes = self.commentBox.text;
    [commentBox resignFirstResponder];
}

@end
