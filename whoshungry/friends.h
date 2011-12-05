//
//  friends.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface friends : UITableViewController  {
    NSMutableArray *users;
    User *currentUser;
}

@property (nonatomic, retain) NSArray * users;
@property (nonatomic, retain) User * currentUser;


- (id)initWithUser:(User *)user; 

@end