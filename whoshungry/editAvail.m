//
//  editAvail.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "editAvail.h"
#import "availCell.h"

@implementation editAvail
@synthesize start, end, days, notes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // TODO: dynamic values
        start = @"12pm";
        end = @"2:30pm";
        days = @"Mon Wed Fri";
        notes = @"Holmes' Lounge";
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
    if(section == 0)
    {
        return 3;
    }
    if(section == 1)
    {
        return 1;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
	return nil;
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
    if([indexPath section] == 0)
    {
        if (indexPath.row == 0){    
            cell.timeLabel.text = @"Start Time";
            cell.daysLabel.text = start;
        }
        if (indexPath.row == 1){    
            cell.timeLabel.text = @"End Time";
            cell.daysLabel.text = start;
        }
        if (indexPath.row == 2){    
            cell.timeLabel.text = @"Days";
            cell.daysLabel.text = days;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if([indexPath section] == 1)
    {
        if (indexPath.row == 0){    
        cell.timeLabel.text = @"Notes";
        cell.daysLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }

    
    return cell;
}

// Actions 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *editAvailController = [[editAvail alloc] init ];
    [self.navigationController pushViewController:editAvailController animated:YES];       
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}


@end
