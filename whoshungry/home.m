//
//  home.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "home.h"

@implementation SimpleTableView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
    }
    return self;
}


- (void) viewDidLoad {
    names = [[NSMutableArray alloc] initWithObjects:@"Ron", @"Robert", @"Jeremy", @"Todd", @"Caitlin",nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; 
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [names count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [names objectAtIndex:indexPath.row];
	
    return cell;
}


@end
