//
//  addAvail.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "addAvail.h"
#import "availCell.h"

@implementation addAvail
@synthesize startTime, endTime, days, notes, timePicker, endTimePicker, daysOfWeek, dayPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.daysOfWeek = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil];
        
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
    // Do any additional setup after loading the view from its nib.
    self.timePicker.hidden=YES;
    self.dayPicker.hidden=YES;
    

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
    return 4;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
	
    if([indexPath section] == 0){
        cell.timeLabel.text = @"Start Time";
        cell.daysLabel.text = startTime;
    }
    if([indexPath section] == 1){
        cell.timeLabel.text = @"End Time";
        cell.daysLabel.text = endTime;
    }
    if([indexPath section] == 2){
        cell.timeLabel.text = @"Days";
        cell.daysLabel.text = days;
    }
    if([indexPath section] == 3){
        cell.timeLabel.text = @"Notes";
        cell.daysLabel.text = notes;
    }
	
	return cell; 
}

// Actions 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath section] == 0){
        self.dayPicker.hidden = YES;
        self.timePicker.hidden = NO;
        self.endTimePicker.hidden = YES;
    }
    if([indexPath section] == 1){
        self.dayPicker.hidden = YES;
        self.endTimePicker.hidden = NO;
        self.timePicker.hidden = YES;
    }
    if([indexPath section] == 2){
        self.dayPicker.hidden = NO;
        self.endTimePicker.hidden = YES;
        self.timePicker.hidden = YES;
    }
    if([indexPath section] == 3){
        self.timePicker.hidden = YES;
        self.endTimePicker.hidden = YES;
        self.dayPicker.hidden = YES;
    }

	
}

- (IBAction)save:(id)sender
{
    [myUser addAvailability:[dayPicker getSelectedRow], startTime:[[self getStartTime], endTime:[self getEndTime]]];
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
    NSLog(@"Save Start Time");
  
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
//  [outputFormatter stringFromDate:self.timePicker.date];
    
    [outputFormatter release];    
}
- (IBAction)saveEndTime:(id)sender{
    NSLog(@"Save End Time");
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    
    //  [outputFormatter stringFromDate:self.timePicker.date];
    
    [outputFormatter release];    
}

@end
