//
//  DayPickerView.h
//  whoshungry
//
//  Created by Brian Fink on 12/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayPickerView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    IBOutlet UIPickerView *dayPicker;
    NSMutableArray *days;
    UIViewController *parentView;
}
-(DayPickerView*)initBasic;
-(DayPickerView*)initWithParentView:(UIViewController*)parentView;
-(void)setHidden:(bool)op;

@end
