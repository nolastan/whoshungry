//
//  DayPickerView.h
//  whoshungry
//
//  Created by Brian Fink on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayPickerView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    IBOutlet UIPickerView *dayPicker;
    NSMutableArray *days;
    int selectedRow;
}

-(int)getSelectedRow;

@end
