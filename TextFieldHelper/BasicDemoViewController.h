//
//  BasicDemoViewController.h
//  TextFieldHelper
//
//  Created by Chen, Yang-Lin on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Textfield.h"

@interface BasicDemoViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *BasicDemo_username;
@property (weak, nonatomic) IBOutlet UITextField *BasicDemo_password;


@end
