//
//  BasicDemoViewController.m
//  TextFieldHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.


#import "BasicDemoViewController.h"

@interface BasicDemoViewController ()

@end

@implementation BasicDemoViewController
@synthesize BasicDemo_username;
@synthesize BasicDemo_password;


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
    
    /* Basic setting for username and password textfield: 
        link delegate and interface textfield objects
     */
    NSMutableArray * textfieldArray = [[NSMutableArray alloc] init ];
    
    BasicDemo_username.delegate = self;
    NSMutableDictionary *usernameDict = [[NSMutableDictionary alloc] init];
    [usernameDict setObject:BasicDemo_username forKey:@"textfield"];
    [textfieldArray addObject:usernameDict];
    
    BasicDemo_password.delegate = self;
    NSMutableDictionary *passwordDict = [[NSMutableDictionary alloc] init];
    [passwordDict setObject:BasicDemo_password forKey:@"textfield"];
    [textfieldArray addObject:passwordDict];
    
    [self.view setTextField:[NSArray arrayWithArray: textfieldArray]];
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



- (void)viewDidUnload
{
    [self setBasicDemo_username:nil];
    [self setBasicDemo_password:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
