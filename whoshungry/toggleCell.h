//
//  toggleCell.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 12/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface toggleCell : UITableViewCell
{
    IBOutlet UILabel *toggleLabel;
    IBOutlet UISwitch *toggle;
}

@property (nonatomic, retain) IBOutlet UILabel *toggleLabel;
@property (nonatomic, retain) IBOutlet UISwitch *toggle;

@end
