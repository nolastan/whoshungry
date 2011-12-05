//
//  addFriendByNumber.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface addFriendByNumber : UIViewController {
    IBOutlet UIButton *addButton;
    IBOutlet UITextField *numberField;
    User *currentUser;
}
-(IBAction)push;
- (id) initWithUserObject:(User *)user;


@end
