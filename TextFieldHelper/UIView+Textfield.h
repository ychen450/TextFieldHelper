//
//  UIView+Textfield.h
//  TextFieldHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface UIView (Textfield)

// Usage: Set up in ViewDidLoad,
//      _userNameField.delegate = self;
//      _passwordField.delegate = self;
//
//      NSMutableDictionary *usernameDict = [[NSMutableDictionary alloc] init];
//      [usernameDict setObject:_userNameField forKey:@"textfield"];
//      [usernameDict setObject:[NSNumber numberWithInt:6] forKey:@"minlength"];    (optional)
//      [usernameDict setObject:USERNAME_ERROR_SHORT forKey:@"minerror"];           (optional)
//      [usernameDict setObject:[NSNumber numberWithInt:60] forKey:@"maxlength"];   (optional)
//      [usernameDict setObject:USERNAME_ERROR_LONG forKey:@"maxerror"];            (optional)
//      [usernameDict setObject:[NSArray arrayWithObject:validationResult] forKey:@"validationlabel"];  (optional)
//      [usernameDict setObject:[NSString stringWithString:@"EMAIL"] forKey:@"validationoption"];       (optional)
//      [usernameDict setObject:[NSNumber numberWithBool:NO] forKey:@"requirement"];                    (optional)
//
//      NSMutableDictionary *passwordDict = [[NSMutableDictionary alloc] init];
//      [passwordDict setObject:_passwordField forKey:@"textfield"];
//      [passwordDict setObject:[NSNumber numberWithInt:10] forKey:@"minlength"];
//      [passwordDict setObject:PASSWORD_ERROR_SHORT forKey:@"minerror"];
//      [passwordDict setObject:[NSNumber numberWithInt:20] forKey:@"maxlength"];
//      [passwordDict setObject:PASSWORD_ERROR_LONG forKey:@"maxerror"];
//      [passwordDict setObject:[NSArray arrayWithObject:validationResult] forKey:@"validationlabel"];
//
//      NSArray *textfieldArray = [NSArray arrayWithObjects:usernameDict, passwordDict, nil];
//      [self.view setTextField:textfieldArray];
//
//  If need validation,
//      [[NSNotificationCenter defaultCenter] addObserver:self 
//                                         selector:@selector(validateInputCallback:) 
//                                             name:@"UITextFieldTextDidChangeNotification" 
//                                           object:nil];


- (void) setTextField:(NSArray*)tfarray;

- (void) textfieldMakeVisible:(UITextField*)textField;
- (void) textfieldEndEdit:(UITextField*)textField;
- (void) textfieldReturn:(UITextField*)textField;
- (void) textfieldTouchToReturn;

- (BOOL) validateInput;
- (BOOL) validateOption:(NSString*)op string:(NSString*)string other:(int)i;

/* Usage:
 - (BOOL)textFieldShouldReturn:(UITextField *)textField 
 {    
 [self.view textfieldReturn:textField];
 return NO;
 }
 
 - (void)textFieldDidBeginEditing:(UITextField *)textField
 {
 [self.view textfieldMakeVisible:textField];
 }
 
 - (void)textFieldDidEndEditing:(UITextField *)textField
 {
 [self.view textfieldEndEdit:textField];
 }
 
 - (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {   
 [self.view textfieldTouchToReturn];
 }
 
 - (void)validateInputCallback:(id)sender
 {
 if ([self.view validateInput]) {
 _enrollButton.enabled = true;
 } else {
 _enrollButton.enabled = false;
 }
 }
 }
 */

@end
