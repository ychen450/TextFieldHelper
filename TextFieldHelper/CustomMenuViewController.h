//
//  CustomMenuViewController.h
//  TextFieldHelper
//
//  Created by Chen, Yang-Lin on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Textfield.h"

@interface CustomMenuViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *CustMenu_num;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ValiSegment;
@property (weak, nonatomic) IBOutlet UIScrollView *CustMenu_scroll;

- (IBAction)SetDetailBtn:(id)sender;

@end
