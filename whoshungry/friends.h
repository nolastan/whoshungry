//
//  friends.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface friends : UIViewController  {
    NSMutableArray *users;
    User *currentUser;
    IBOutlet UITableView *table;
}

@property (nonatomic, retain) NSArray * users;
@property (nonatomic, retain) User * currentUser;

- (id) initWithUserObject:(User *)user;

@end