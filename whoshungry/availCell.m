//
//  availCell.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "availCell.h"

@implementation availCell
@synthesize timeLabel, daysLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
