//
//  myAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myAvail : UIViewController <UITabBarDelegate, UITableViewDataSource>
{
    NSArray *items;
    NSArray *days;
}
@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) NSArray *days;

@end
