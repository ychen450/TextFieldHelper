//
//  ValiDemoViewController.m
//  TextFieldHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "ValiDemoViewController.h"

@interface ValiDemoViewController ()

@end

@implementation ValiDemoViewController
@synthesize ValiDemo_username;
@synthesize ValiDemo_email;
@synthesize ValiDemo_zipcode;
@synthesize ValiDemo_password;
@synthesize ValiDemo_repassword;
@synthesize ValiDemo_label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSMutableArray * textfieldArray = [[NSMutableArray alloc] init ];
    
    ValiDemo_username.delegate = self;
    NSMutableDictionary *usernameDict = [[NSMutableDictionary alloc] init];
    [usernameDict setObject:ValiDemo_username forKey:@"textfield"];
    [usernameDict setObject:[NSNumber numberWithInt:6] forKey:@"minlength"];
    [usernameDict setObject:USERNAME_ERROR_SHORT forKey:@"minerror"];
    [usernameDict setObject:[NSNumber numberWithInt:60] forKey:@"maxlength"];
    [usernameDict setObject:USERNAME_ERROR_LONG forKey:@"maxerror"];
    [usernameDict setObject:[NSArray arrayWithObject:ValiDemo_label] forKey:@"validationlabel"];
    [textfieldArray addObject:usernameDict];
    
    ValiDemo_email.delegate = self;
    NSMutableDictionary *emailDict = [[NSMutableDictionary alloc] init];
    [emailDict setObject:ValiDemo_email forKey:@"textfield"];
    [emailDict setObject:[NSNumber numberWithInt:3] forKey:@"minlength"];
    [emailDict setObject:PASSWORD_ERROR_SHORT forKey:@"minerror"];
    [emailDict setObject:[NSString stringWithString:@"EMAIL"] forKey:@"validationoption"];
    [emailDict setObject:[NSArray arrayWithObject:ValiDemo_label] forKey:@"validationlabel"];
    [textfieldArray addObject:emailDict];
    
    ValiDemo_zipcode.delegate = self;
    NSMutableDictionary *zipDict = [[NSMutableDictionary alloc] init];
    [zipDict setObject:ValiDemo_zipcode forKey:@"textfield"];
    [zipDict setObject:[NSNumber numberWithInt:5] forKey:@"minlength"];
    [zipDict setObject:GENERIC_ERROR_SHORT forKey:@"minerror"];
    [zipDict setObject:[NSNumber numberWithInt:10] forKey:@"maxlength"];
    [zipDict setObject:GENERIC_ERROR_LONG forKey:@"maxerror"];
    [zipDict setObject:[NSString stringWithString:@"NUMBER"] forKey:@"validationoption"];
    [zipDict setObject:[NSArray arrayWithObject:ValiDemo_label] forKey:@"validationlabel"];
    [textfieldArray addObject:zipDict];
    
    ValiDemo_password.delegate = self;
    NSMutableDictionary *passwordDict = [[NSMutableDictionary alloc] init];
    [passwordDict setObject:ValiDemo_password forKey:@"textfield"];
    [passwordDict setObject:[NSNumber numberWithInt:6] forKey:@"minlength"];
    [passwordDict setObject:PASSWORD_ERROR_SHORT forKey:@"minerror"];
    [passwordDict setObject:[NSNumber numberWithInt:20] forKey:@"maxlength"];
    [passwordDict setObject:PASSWORD_ERROR_LONG forKey:@"maxerror"];
    [passwordDict setObject:[NSArray arrayWithObject:ValiDemo_label] forKey:@"validationlabel"];
    [textfieldArray addObject:passwordDict];
    
    ValiDemo_repassword.delegate = self;
    NSMutableDictionary *repasswordDict = [[NSMutableDictionary alloc] init];
    [repasswordDict setObject:ValiDemo_repassword forKey:@"textfield"];
    [repasswordDict setObject:[NSNumber numberWithInt:6] forKey:@"minlength"];
    [repasswordDict setObject:PASSWORD_ERROR_SHORT forKey:@"minerror"];
    [repasswordDict setObject:[NSNumber numberWithInt:20] forKey:@"maxlength"];
    [repasswordDict setObject:PASSWORD_ERROR_LONG forKey:@"maxerror"];
    [repasswordDict setObject:[NSString stringWithString:@"REPASSWORD"] forKey:@"validationoption"];
    [repasswordDict setObject:[NSArray arrayWithObject:ValiDemo_label] forKey:@"validationlabel"];
    [textfieldArray addObject:repasswordDict];
    
    
    [self.view setTextField:[NSArray arrayWithArray: textfieldArray]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(validateInputCallback:) 
                                                 name:@"UITextFieldTextDidChangeNotification" 
                                               object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  {    
    [self.view textfieldReturn:textField];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view textfieldMakeVisible:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view textfieldEndEdit:textField];  
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {   
    [self.view textfieldTouchToReturn];
}

- (void)validateInputCallback:(id)sender {
    if ([self.view validateInput]) {
        //Button.enabled = true;
    } else {
        //Button.enabled = false;
    }
}

- (void)viewDidUnload
{
    [self setValiDemo_username:nil];
    [self setValiDemo_email:nil];
    [self setValiDemo_zipcode:nil];
    [self setValiDemo_password:nil];
    [self setValiDemo_repassword:nil];
    [self setValiDemo_label:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
