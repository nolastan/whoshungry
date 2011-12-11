//
//  friendDetail.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "friendDetail.h"
#import "availCell.h"
#import "friendAvail.h"

@implementation friendDetail
@synthesize times, days, name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Availability";
        self.days = [[NSArray alloc] initWithObjects:@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", nil];
   }
    return self;
}

- (id) initWithUserObject:(User *)user friend:friendUser {
    self = [super init];
    if (self) {
        friend = friendUser;
        currentUser = user;
        self.title = friend.name;
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
        [addButton release];
        
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
    return [[[friend availability] objectAtIndex:section] count];
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
    FoodTime *cellInfo = [[[friend availability] objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    NSLog(@"%@", cellInfo);
    NSString *start = [cellInfo startTime];
    NSString *end = [cellInfo endTime];
    
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%@-%@", start, end];
    cell.daysLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    
    
    return cell;
}

// Actions 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int selectedDay = [indexPath section];
    UIViewController *friendAvailController = [[friendAvail alloc] initWithUsers:currentUser otherUser:friend compatibleOnly:false day:selectedDay ];
    [self.navigationController pushViewController:friendAvailController animated:YES];
}

- (IBAction)unfriend:(id)sender
{
    [currentUser removeFriend:friend];
    [self.navigationController popViewControllerAnimated:YES];       
    
}

-(IBAction)messageFriend:(id)sender
{
	MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = @"Lunch?";
		controller.recipients = [NSArray arrayWithObject:friend.phoneNumber];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
	}    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
			NSLog(@"Error sending iMessage");
			break;
		case MessageComposeResultSent:
 			NSLog(@"iMessage sent");           
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
}


@end
