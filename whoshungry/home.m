//
//  home.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "home.h"
#import "myAvail.h"
#import "friendsAvail.h"
#import "friends.h"

@implementation home

@synthesize myUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Home";
    }
    return self;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";  
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];  
	if (cell == nil) {  
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];  
    }  
	
    // Set up the text for your cell  
    NSString *cellValue = [listOfItems objectAtIndex:indexPath.row];  
    cell.textLabel.text = cellValue;  
	
	return cell;  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [listOfItems count];
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//initializing
	listOfItems = [[NSMutableArray alloc] init];
	
	//adding objects to the array
	[listOfItems addObject: @"Set My Availability"];
	[listOfItems addObject: @"Friends List"];
	[listOfItems addObject: @"View Friends' Availability"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *myAvailController = [[myAvail alloc] init ];
    UIViewController *friendsListController = [[friends alloc] initWithUser:myUser ];
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
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (void)dealloc {
	[listOfItems release];
    [super dealloc];
}


@end
