//
//  Home.h
//  lunchable
//
//  Created by Stanford Rosenthal on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface home : UIViewController <UITabBarDelegate, UITableViewDataSource>
{
    NSArray *menuItems;
}
@property (nonatomic, retain) NSArray *menuItems;

@end
