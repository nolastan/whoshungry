//
//  Home.m
//  lunchable
//
//  Created by Stanford Rosenthal on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "home.h"
#import "myAvail.h"
#import "friends.h"
#import "friendsAvail.h"

@implementation home
@synthesize menuItems;
@synthesize tableContents;

@synthesize myUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.hidesBackButton = YES;
        self.title = @"Home";
        // Custom initialization
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.menuItems = [[NSArray alloc] initWithObjects:@"Set My Availability", @"Friends List", @"View Friends' Availability", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.menuItems = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItems count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";  
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];  
	if (cell == nil) {  
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];  
    }  
	
    // Set up the text for your cell  
    NSString *cellValue = [menuItems objectAtIndex:indexPath.row];  
    cell.textLabel.text = cellValue;  
	
	return cell; 
}

// Actions 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *myAvailController = [[myAvail alloc] initWithUserObject:myUser ];
    friends *friendsListController = [[friends alloc] initWithUserObject:myUser ];
    UIViewController *viewFriendsAvailController = [[friendsAvail alloc] init ];
	if (indexPath.row == 0){
        [self.navigationController pushViewController:myAvailController animated:YES];          
    }
	if (indexPath.row == 1){
        [self.navigationController pushViewController:friendsListController animated:YES];   
    }
	if (indexPath.row == 2){
        [self.navigationController pushViewController:viewFriendsAvailController animated:YES];   
    }
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void) dealloc
{
    [menuItems release];
    [super dealloc];
}

@end
