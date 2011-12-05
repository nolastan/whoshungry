//
//  Home.h
//  lunchable
//
//  Created by Stanford Rosenthal on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"


@interface home : UIViewController <UITabBarDelegate, UITableViewDataSource>{
    User *myUser;
    
    NSArray *menuItems;

}
@property (nonatomic,retain) NSDictionary *tableContents;
//@property (nonatomic,retain) NSArray *listOfItems;
@property (nonatomic, retain) User *myUser;
    

@property (nonatomic, retain) NSArray *menuItems;
@end
