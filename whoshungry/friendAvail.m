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
        // Custom initialization
//        Why is this not working!?!?!
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
    self.comment = @"This is the comment";
    self.time = @"12-2 Today";
    self.name = @"Stan Rosenthal";
    commentText.text = @"F!";
    timeLabel.text = [NSString stringWithFormat:@"Available %@", self.time];
    self.title = name;

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
