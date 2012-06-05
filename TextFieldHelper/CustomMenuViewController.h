//
//  CustomMenuViewController.h
//  TextFieldHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import <UIKit/UIKit.h>
#import "UIView+Textfield.h"

@interface CustomMenuViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *CustMenu_num;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ValiSegment;
@property (weak, nonatomic) IBOutlet UIScrollView *CustMenu_scroll;

- (IBAction)SetDetailBtn:(id)sender;

@end
