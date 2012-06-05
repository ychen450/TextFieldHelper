//
//  ViewController.h
//  TextFieldHelper
//
//  Created by Chen, Yang-Lin on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Textfield.h"

@interface ViewController : UIViewController <UITextFieldDelegate> {
    BOOL PassValidation;
    
}

@property (nonatomic,strong) IBOutlet UITextField *username;
@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic, retain) IBOutlet UILabel *validationResult;

@end
