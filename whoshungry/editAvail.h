//
//  editAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface editAvail : UIViewController
{
    IBOutlet UITableView *table;
    NSDictionary * info;
    User * myUser;
    int day;
    int row;

}

@property (nonatomic, retain) NSDictionary * info;
@property (nonatomic, retain) User * myUser;
@property (nonatomic) int day, row;


- (id) initWithUserAndAvail:(User *)user dow:(int)day index:(int)row;

- (IBAction)deleteItem;
@end
