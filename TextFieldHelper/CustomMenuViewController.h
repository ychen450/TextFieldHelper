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

@interface CustomMenuViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *CustMenu_num;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ValiSegment;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UILabel *testlabel;
@property (strong, nonatomic) IBOutlet UITextField *test1;
@property (strong, nonatomic) IBOutlet UITextField *test2;
@property (strong, nonatomic) IBOutlet UITextField *test3;

- (IBAction)SetDetailBtn:(id)sender;

@end
