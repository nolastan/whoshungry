//
//  friendDetail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import <MessageUI/MessageUI.h>

@interface friendDetail : UIViewController{
    IBOutlet UITableView *table;
    NSString *name;
    NSArray *times;
    NSArray *days;
    User *currentUser;
    User *friend;
}

- (id) initWithUserObject:(User *)user friend:friendUser;
- (IBAction)unfriend:(id)sender;
- (IBAction)messageFriend:(id)sender;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *times;
@property (nonatomic, retain) NSArray *days;


@end
