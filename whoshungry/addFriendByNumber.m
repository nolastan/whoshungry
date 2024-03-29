//
//  addFriendByNumber.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "addFriendByNumber.h"
#import "User.h"

@implementation addFriendByNumber

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithUserObject:(User *)user
{
    self = [super init];
    if (self) {
        currentUser = user;
    }
    return self;
    
}

-(IBAction)push{
    NSString *number = [numberField text];
    
    if ([currentUser createFriendship:number]) {
        [currentUser updateFriends];
        [self dismissModalViewControllerAnimated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"That phone number doesn't correspond to a known user." delegate:nil cancelButtonTitle:@"Try again" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    
    
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
-(IBAction)cancel:(id)sender{
    [self dismissModalViewControllerAnimated:YES];   
}
@end
