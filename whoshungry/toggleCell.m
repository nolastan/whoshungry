//
//  toggleCell.m
//  whoshungry
//
//  Created by Stanford Rosenthal on 12/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "toggleCell.h"

@implementation toggleCell
@synthesize toggle, toggleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        This doesn't work
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
