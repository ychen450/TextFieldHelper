//
//  ViewController.h
//  TextFieldHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import <UIKit/UIKit.h>
#import "UIView+Textfield.h"

@interface ViewController : UIViewController <UITextFieldDelegate> {
    BOOL PassValidation;
    
}

@property (nonatomic,strong) IBOutlet UITextField *username;
@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UILabel *validationResult;

@end
