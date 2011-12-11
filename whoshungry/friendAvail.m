//
//  friendAvail.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "friendAvail.h"

@implementation friendAvail
@synthesize name, time, comment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

-(id)initWithUsers:(User*)owner otherUser:(User*)otherUser compatibleOnly:(bool)compatOnly day:(int)chosenDay{
    self = [self init];
    if(self) {
        days = [[NSMutableArray alloc] initWithCapacity:7];
        [days addObject:@"Sunday"];
        [days addObject:@"Monday"];
        [days addObject:@"Tuesday"];
        [days addObject:@"Wednesday"];
        [days addObject:@"Thursday"];
        [days addObject:@"Friday"];
        [days addObject:@"Saturday"];

        
        day = chosenDay;
        compatibleOnly = compatOnly;
        myUser = owner;
        friendUser = otherUser;
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
    NSMutableArray *myUserAvails = [myUser getAvailabilitiesForDay:day];
    NSMutableArray *friendAvails = [friendUser getAvailabilitiesForDay:day];
    self.time = @"";
    self.comment = @"";
    
    if(compatibleOnly) {
        NSMutableArray *compats = [[NSMutableArray alloc] init];
        bool found = false;
        for(FoodTime *friendTime in friendAvails) {
            for(FoodTime *userTime in myUserAvails) {
                if([userTime isCompatible:friendTime]) {
                    [compats addObject:friendTime];
                    break;
                }
            }
        }
        for(FoodTime *avail in compats) {
            NSLog(@"avail");
            self.time = [NSString stringWithFormat:@"%@ %@,",self.time,[avail timeRange]];
            self.comment = [NSString stringWithFormat:@"%@ %@: %@\n\n",self.comment,[avail timeRange],[avail comment]];
        }
    } else {
        for(FoodTime *avail in friendAvails) {
            NSLog(@"avail");
            self.time = [NSString stringWithFormat:@"%@ %@,",self.time,[avail timeRange]];
            self.comment = [NSString stringWithFormat:@"%@ %@: %@\n\n",self.comment,[avail timeRange],[avail comment]];
        }
    }
    
    self.name = @"Stan Rosenthal";
    commentText.text = self.comment;
    timeLabel.text = [NSString stringWithFormat:@"Available %@", self.time];
    self.title = [days objectAtIndex:day];

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

- (IBAction)sendMessage:(id)sender{
	MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = @"Lunch?";
		controller.recipients = [NSArray arrayWithObjects:@"12345678", @"87654321", nil];
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
