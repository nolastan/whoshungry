//
//  friendAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "User.h"
@interface friendAvail : UIViewController
{
    NSString *name;
    NSString *time;
    NSString *comment;
    NSMutableArray *days;
    IBOutlet UILabel *timeLabel;
    IBOutlet UITextView *commentText;
    IBOutlet UIButton *sendMessageButton;
    User* myUser;
    User* friendUser;
    bool compatibleOnly;
    int day;
}

-(id)initWithUsers:(User*)owner otherUser:(User*)otherUser compatibleOnly:(bool)compatOnly day:(int)chosenDay;
- (IBAction)sendMessage:(id)sender;

//@property (nonatomic, retain) NSString *compatibleOnly;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comment;


@end
