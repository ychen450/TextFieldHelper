//
//  ValiDemoViewController.h
//  TextFieldHelper
//
//  Created by Chen, Yang-Lin on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Textfield.h"
#import "Constants.h"

@interface ValiDemoViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ValiDemo_username;
@property (weak, nonatomic) IBOutlet UITextField *ValiDemo_email;
@property (weak, nonatomic) IBOutlet UITextField *ValiDemo_zipcode;
@property (weak, nonatomic) IBOutlet UITextField *ValiDemo_password;
@property (weak, nonatomic) IBOutlet UITextField *ValiDemo_repassword;

@property (weak, nonatomic) IBOutlet UILabel *ValiDemo_label;



@end
