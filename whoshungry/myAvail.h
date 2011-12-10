//
//  myAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface myAvail : UIViewController <UITabBarDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *table;
    NSArray *items;
    NSArray *days;
    User *myUser;
}
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, retain) NSArray *days;
@property (nonatomic , retain) User *myUser;


- (id) initWithUserObject:(User *)user;
@end
