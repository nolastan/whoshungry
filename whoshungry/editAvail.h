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
    User * myUser;
    FoodTime * foodTime;

}

@property (nonatomic, retain) User * myUser;
@property (nonatomic, retain) FoodTime * foodTime;


- (id) initWithUserAndAvail:(User *)user time:(FoodTime *)ft;

- (IBAction)deleteItem;
@end
