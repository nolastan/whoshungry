//
//  editAvail.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface editAvail : UIViewController
{
    IBOutlet UITableView *table;
    NSString *days;
    NSString *start;
    NSString *end;
    NSString *notes;

}

@property (nonatomic, retain) NSString *days;
@property (nonatomic, retain) NSString *start;
@property (nonatomic, retain) NSString *end;
@property (nonatomic, retain) NSString *notes;

@end
