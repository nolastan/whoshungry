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
@synthesize allNames, allTimes, compatNames, compatTimes, filterText, dayPicker, days;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
-(id)initWithUserObject:(User *)user{
    self = [super init];
    if (self) {
        days = [[NSMutableArray alloc] initWithCapacity:7];
        [days addObject:@"Sunday"];
        [days addObject:@"Monday"];
        [days addObject:@"Tuesday"];
        [days addObject:@"Wednesday"];
        [days addObject:@"Thursday"];
        [days addObject:@"Friday"];
        [days addObject:@"Saturday"];
        compatibleOnly = NO;
        myUser = user;
        self.title = @"Availabilities";
        UIBarButtonItem *groupButton = [[UIBarButtonItem alloc]
                                        initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(editMode)];
        self.navigationItem.rightBarButtonItem = groupButton;
        [groupButton release];
        
        self.allNames = [[NSMutableArray alloc] init];
        self.allTimes = [[NSMutableArray alloc] init];
        self.compatNames = [[NSMutableArray alloc] init];
        self.compatTimes = [[NSMutableArray alloc] init];
        
        // Go through all the friends and add them to the table
        for(User* friend in [myUser friends]) {
            NSLog(@"PHONE NUMBER:%@",[friend phoneNumber]);
            [allNames addObject:[friend name]]; // Add the friend's name (or phone number)
            [allTimes addObject:[friend availability]]; // Copy the friend's availabilities (memory mangagement? XD)
            
            bool found = false;
            for(int i=0;i<7;i++) {
                NSMutableArray *myUserAvail = [myUser getAvailabilitiesForDay:i];
                NSMutableArray *friendAvail = [friend getAvailabilitiesForDay:i];
                [compatNames addObject:[[NSMutableArray alloc] init]];
                for(FoodTime* friendTime in friendAvail) {
                    for(FoodTime* myUserTime in myUserAvail) {
                        if([myUserTime isCompatible:friendTime]) {
                            NSLog(@"TIME FOR %@ ON %d IS COMPAT", [friend phoneNumber], i);
                            if(!found) {
                                [[compatNames objectAtIndex:i] addObject:[friend name]];
                                NSLog(@"i:%d index:%d ",i,[[compatNames objectAtIndex:i] indexOfObject:[friend name]]);

                                NSMutableArray *theDays = [[NSMutableArray alloc] initWithCapacity:7];
                                for (int i = 0; i < 7; ++i) {
                                    [theDays insertObject:[[NSMutableArray alloc]init] atIndex:i];
                                }
                                [compatTimes addObject:theDays];
                            }
                            NSLog(@"i:%d friendTime:%d %d %d",i,[friendTime dow],[[compatNames objectAtIndex:i] indexOfObject:[friend name]]);
                            [[[compatTimes objectAtIndex:[[compatNames objectAtIndex:i] indexOfObject:[friend name]]] objectAtIndex:[friendTime dow]] addObject:friendTime];
                            found = true;
                            break;
                            
                        }
                    }
                    found = false;
                }
                
            }
            
        }
        
        
        self.filterText = @"Monday";
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveDayOfWeek:) 
                                                     name:@"changeDay"
                                                   object:nil];
        
        
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
        if(compatibleOnly) {
            int thisDay = [days indexOfObject:filterText];
            NSLog(@"COMPAT:%d",[compatNames count]);
            return [[compatNames objectAtIndex:thisDay] count];
        } else {
            NSLog(@"ALL:%d",[allNames count]);
            return [allNames count];
        }
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
        toggleCell *cell = nil;//(toggleCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
            [[cell toggle] setOn:compatibleOnly];
            //compatibleOnly = YES;
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
            int thisDay = [days indexOfObject:filterText];
            NSMutableArray *timeArr = [[NSMutableArray alloc] init];
            if(compatibleOnly) {
                timeArr = [[compatTimes objectAtIndex:[indexPath row]] objectAtIndex:thisDay];
            } else {
                timeArr = [[allTimes objectAtIndex:[indexPath row]] objectAtIndex:thisDay];
            }
            cell.daysLabel.text = @"";
            for(FoodTime *foodTime in timeArr) {
                cell.daysLabel.text = [NSString stringWithFormat:@"%@ %@",cell.daysLabel.text, [foodTime timeRange]];
            }
            if(compatibleOnly) {
                cell.timeLabel.text = [[compatNames objectAtIndex:thisDay] objectAtIndex: [indexPath row]];
            } else {
                cell.timeLabel.text = [allNames objectAtIndex: [indexPath row]];
            }
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
        User* selectedUser;
        NSString *friendName;
        if(compatibleOnly) {
            friendName = [compatNames objectAtIndex:[indexPath row]];
            
        } else {
            friendName = [allNames objectAtIndex:[indexPath row]];
        }
        
        for(User *friend in [myUser friends]) {
            if([friend name] == @"") {
                if([friend phoneNumber] == friendName) {
                    selectedUser = friend;
                    break;
                }
            } else {
                if([friend name] == friendName) {
                    selectedUser = friend;
                    break;
                }
            }
        }
        int selectedDay = [days indexOfObject:filterText];
        UIViewController *friendAvailController = [[friendAvail alloc] initWithUsers:myUser otherUser:selectedUser compatibleOnly:compatibleOnly day:selectedDay ];
        [self.navigationController pushViewController:friendAvailController animated:YES];
        [dayPicker setHidden:YES];
    }
}
- (void) editMode{
    NSLog(@"entering edit mode");
}

- (IBAction)toggleCompatible:(id)sender{
    NSLog(@"Toggle compatibility");
    compatibleOnly = !compatibleOnly;
    [table reloadData];
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
        filterText = day;
        [table reloadData];
    }
}
@end
