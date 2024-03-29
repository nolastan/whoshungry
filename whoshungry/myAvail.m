//
//  myAvail.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "myAvail.h"
#import "addAvail.h"
#import "editAvail.h"
#import "availCell.h"
#import "FoodTime.h"

@implementation myAvail
@synthesize items;
@synthesize days, myUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"My Availability";
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
        self.navigationItem.rightBarButtonItem = addButton;
        [addButton release];
    }
    return self;
}


- (id) initWithUserObject:(User *)user {
    self = [super init];
    if (self) {
        myUser = user;
        
        self.title = @"My Availability";
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
        self.navigationItem.rightBarButtonItem = addButton;
        [addButton release];
    }
    return self;
}

- (void)addAction
{
    UIViewController *h = [[addAvail alloc] initWithUserObject:myUser];
    [self.navigationController presentModalViewController:h animated:YES];    
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
    //self.items = [[NSArray alloc] initWithObjects:@"12-2:30pm", @"11:30-1", @"", @"", @"", @"", @"",nil];
    self.days = [[NSArray alloc] initWithObjects:@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", nil];
    self.items = [myUser availability];
    
    NSLog(@"%@", myUser);
    
    NSLog(@"Avails: %@", items);
    

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
    return [[[myUser availability] objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        default:
        case 0: return @"Sunday";
        case 1: return @"Monday";
        case 2: return @"Tuesday";
        case 3: return @"Wednesday";
        case 4: return @"Thursday";
        case 5: return @"Friday";
        case 6: return @"Saturday";
        
    }
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
    
    // Configure the cell.
    //cell.timeLabel.text = [self.items objectAtIndex: [indexPath row]];
    FoodTime *cellInfo = [[[myUser availability] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    NSLog(@"%@", cellInfo);
    NSString *start = [cellInfo startTime];
    NSString *end = [cellInfo endTime];

    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@-%@", start, end];
    cell.daysLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// Actions 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *editAvailController = [[editAvail alloc] initWithUserObject:myUser];
    [self.navigationController pushViewController:editAvailController animated:YES];       
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void) dealloc
{
    [items release];
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [table reloadData];
}
@end
