//
//  friendsAvail.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "friendsAvail.h"
#import "availCell.h"
#import "toggleCell.h"
#import "friendAvail.h"
#import "DayPickerView.h"

@implementation friendsAvail
@synthesize names, times, filterText, dayPicker, days;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Friends' Availability";
        UIBarButtonItem *groupButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(editMode)];
        self.navigationItem.rightBarButtonItem = groupButton;
        [groupButton release];
        
//    TODO: LOAD ITEMS FROM SERVER
        self.names = [NSArray arrayWithObjects:@"Paul Carleton", @"Brian Fink", @"Stan Rosenthal", nil];
        self.times = [NSArray arrayWithObjects:@"12-12:30", @"12:30-1", @"1-2, 4-6", nil];
        self.filterText = @"Monday";
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDayOfWeek:) 
                                                     name:@"changeDay"
                                                   object:nil];
        
        days = [[NSMutableArray alloc] initWithCapacity:7];
        [days addObject:@"Sunday"];
        [days addObject:@"Monday"];
        [days addObject:@"Tuesday"];
        [days addObject:@"Wednesday"];
        [days addObject:@"Thursday"];
        [days addObject:@"Friday"];
        [days addObject:@"Saturday"];

    }
    return self;
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
    
    dayPicker = (DayPickerView *) [[DayPickerView alloc] initBasic];
    [dayPicker view].frame= CGRectMake(0, 200, 320, 250);
    [[self view] addSubview:[dayPicker view]];
    [dayPicker setHidden:YES];

    // Do any additional setup after loading the view from its nib.
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

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
    {
        return 1;
    }
    if(section == 1)
    {
        return 3;
    }
    if(section == 2)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
	return nil;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"availCell";

    if([indexPath section] == 2){
        toggleCell *cell = (toggleCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle]
                                        loadNibNamed:@"toggleCell" owner:nil options:nil];
            
            for(id currentObject in topLevelObjects){
                if([currentObject isKindOfClass:[UITableViewCell class]]){
                    cell = (toggleCell *) currentObject;
                    break;
                }
            }
        }
        
        if (indexPath.row == 0){    
            cell.toggleLabel.text = @"Show only compatible times";
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.toggle addTarget:self action:@selector(toggleCompatible:) forControlEvents:UIControlEventValueChanged];

        }        
        return cell;
    }else{
    
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
        if([indexPath section] == 0)
        {
            if (indexPath.row == 0){    
                cell.timeLabel.text = @"When";
                cell.daysLabel.text = self.filterText;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        if([indexPath section] == 1)
        {
            cell.timeLabel.text = [names objectAtIndex: [indexPath row]];
            cell.daysLabel.text = [times objectAtIndex: [indexPath row]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    
}

// Actions 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if([indexPath section] == 0)
    {
        NSLog(@"change day");
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveFilter:)];
        self.navigationItem.rightBarButtonItem = doneButton; 
        [doneButton release];
        [dayPicker setHidden:false];
    }
    if([indexPath section] == 1)
    {
        UIViewController *friendAvailController = [[friendAvail alloc] init ];
        [self.navigationController pushViewController:friendAvailController animated:YES];
        [dayPicker setHidden:YES];
    }
}
- (void) editMode{
    NSLog(@"entering edit mode");
//    [table cellForRowAtIndexPath:0].accessoryType = UITableViewCellAccessoryCheckmark;
}

- (IBAction)toggleCompatible:(id)sender{
    NSLog(@"Toggle compatibility");
}
-(IBAction)saveFilter:(id)sender{
    NSLog(@"Save Filter");
    UIBarButtonItem *groupButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(editMode)];
    self.navigationItem.rightBarButtonItem = groupButton;
    [groupButton release];
    [dayPicker setHidden:true];
}

- (void) receiveDayOfWeek:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"changeDay"]){
        int row = [[[notification userInfo] valueForKey:@"pass"] intValue];
        NSString *day = [self.days objectAtIndex:row];
        NSLog(@"Day %i: %@", row, day);
        filterText = day;
        [table reloadData];
    }
}
@end
