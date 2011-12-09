//
//  DayPickerView.m
//  whoshungry
//
//  Created by Brian Fink on 12/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DayPickerView.h"

@implementation DayPickerView

-(DayPickerView*)initBasic{
    [self init];
    dayPicker.hidden = NO;
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
    days = [[NSMutableArray alloc] initWithCapacity:7];
    [days addObject:@"Sunday"];
    [days addObject:@"Monday"];
    [days addObject:@"Tuesday"];
    [days addObject:@"Wednesday"];
    [days addObject:@"Thursday"];
    [days addObject:@"Friday"];
    [days addObject:@"Saturday"];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setHidden:(bool)op{
    dayPicker.hidden = op;
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

//PickerViewController.m
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

//PickerViewController.m
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [days count];
}
//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [days objectAtIndex:row];
}
//PickerViewController.m
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"Selected Color: %@. Index of selected color: %i", [days objectAtIndex:row], row);
}

@end
