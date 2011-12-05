//
//  home.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface home : UITableViewController{
    NSMutableArray *listOfItems;
	NSDictionary *tableContents;
    User *myUser;
}
@property (nonatomic,retain) NSDictionary *tableContents;
@property (nonatomic,retain) NSArray *listOfItems;
@property (nonatomic, retain) User *myUser;
@end