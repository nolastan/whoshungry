//
//  availCell.h
//  whoshungry
//
//  Created by Stanford Rosenthal on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface availCell : UITableViewCell
{
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *daysLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *daysLabel;

@end
