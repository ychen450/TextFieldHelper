//
//  UIView+Textfield.m
//  TextFieldHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView+Textfield.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

CGFloat animatedDistance;
NSArray* textFieldArray;
NSArray* typeArray;
UILabel* resultlabel;
int endEditNum;

@implementation UIView (Textfield)

- (void) setTextField:(NSArray*)tfarray {
    textFieldArray = [NSArray arrayWithArray:tfarray];
    
    UITextField *tf;
    for (int i=0; i<[tfarray count]; i++) {
        tf = [[tfarray objectAtIndex:i] objectForKey:@"textfield"];
        tf.tag = i;
        if (i==([tfarray count]-1)) {
            tf.returnKeyType = UIReturnKeyGo;
        } else {
            tf.returnKeyType = UIReturnKeyNext;
        }
    } 
    endEditNum = 0;
}

- (void) textfieldMakeVisible:(UITextField*)textField {
    CGRect textFieldRect = [self.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect = [self.window convertRect:self.bounds fromView:self];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - 0.2 * viewRect.size.height;
    CGFloat denominator = 0.6 * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0) {
        heightFraction = 0.0;
    } else if (heightFraction > 1.0) {
        heightFraction = 1.0;
    }
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown) {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    } else {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    CGRect viewFrame = self.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];    
    [self setFrame:viewFrame];
    [UIView commitAnimations];
}

- (void) textfieldEndEdit:(UITextField*)textField;{
    
    CGRect viewFrame = self.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self setFrame:viewFrame];    
    [UIView commitAnimations];
    
    endEditNum = textField.tag+1;
    if ([[textFieldArray objectAtIndex:textField.tag] objectForKey:@"minlength"]||[[textFieldArray objectAtIndex:textField.tag] objectForKey:@"maxlength"]) {
        [self validateInput];
    }
}

- (void) textfieldReturn:(UITextField*)textField {
    
    if (textField.tag == [textFieldArray count]-1) {
        [textField resignFirstResponder];
    } else {
        UITextField *tf = [[textFieldArray objectAtIndex:textField.tag+1] objectForKey:@"textfield"];
        [tf becomeFirstResponder];
    }
}

- (void) textfieldTouchToReturn {
    
    NSArray *subviews = [self subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        } 
    }
}

- (BOOL) validateInput
{
    int fail = 0;
    for (int i=0; i<endEditNum; i++) {
        UITextField *tf;
        tf = [[textFieldArray objectAtIndex:i] objectForKey:@"textfield"];
        
        int minLength = 0;
        int maxLength = 100;
        NSString *option;
        if ([[textFieldArray objectAtIndex:i] objectForKey:@"minlength"]) {
            minLength = [[[textFieldArray objectAtIndex:i] objectForKey:@"minlength"] intValue];
        }
        if ([[textFieldArray objectAtIndex:i] objectForKey:@"maxlength"]) {
            maxLength = [[[textFieldArray objectAtIndex:i] objectForKey:@"maxlength"] intValue];
        }
        if ([[textFieldArray objectAtIndex:i] objectForKey:@"validationlabel"]) {
            resultlabel = [[[textFieldArray objectAtIndex:i] objectForKey:@"validationlabel"] objectAtIndex:0];
        }
        if ([[textFieldArray objectAtIndex:i] objectForKey:@"validationoption"]) {
            option = [[textFieldArray objectAtIndex:i] objectForKey:@"validationoption"];
            NSLog(@"option: %@",option);
        }
    
        if (endEditNum > tf.tag) {
            if ([tf.text length] < minLength) {
                tf.layer.masksToBounds = YES;
                tf.layer.borderColor = [[UIColor redColor] CGColor];
                tf.layer.borderWidth = 1.0f;
                resultlabel.text = [[[textFieldArray objectAtIndex:i] objectForKey:@"minerror"] stringByAppendingFormat:
                                    @"%d", minLength];
                fail++;
            } else if ([tf.text length] > maxLength) {
                tf.layer.masksToBounds = YES;
                tf.layer.borderColor = [[UIColor redColor] CGColor];
                tf.layer.borderWidth = 1.0f;
                resultlabel.text = [[[textFieldArray objectAtIndex:i] objectForKey:@"maxerror"] stringByAppendingFormat:
                                    @"%d", maxLength];
                fail++;
            } else if ([self validateOption:option string:tf.text other:i]) {
                tf.layer.masksToBounds = YES;
                tf.layer.borderColor = [[UIColor redColor] CGColor];
                tf.layer.borderWidth = 1.0f;
                resultlabel.text = [GENERIC_ERROR stringByAppendingFormat:@"%@", option];
                fail++;
            } else {
                tf.layer.borderColor=[[UIColor clearColor]CGColor];
                resultlabel.text = @"";
            }
        }
    }
    if (fail>0) {
        return FALSE;
    } else {
        return TRUE;
    }
}

- (BOOL) validateOption:(NSString*)op string:(NSString*)string other:(int)i{
    
    if ([op isEqualToString:@"EMAIL"]) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        BOOL isValid = [emailTest evaluateWithObject:string];
        return !isValid;
    } else if ([op isEqualToString:@"NUMBER"]) {
        
        NSLog(@"innumber");
        NSString *numRegex = @"[0-9]{5,10}";
        NSPredicate *numTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
        BOOL isValid = [numTest evaluateWithObject:string];
        return !isValid;
    } else if ([op isEqualToString:@"REPASSWORD"]) {
        
        NSLog(@"in re password");
        UITextField *ptf = [[textFieldArray objectAtIndex:(i-1)] objectForKey:@"textfield"];
        
        NSLog(@"%@  %@",ptf.text, string);
        return ![string isEqualToString:ptf.text]; 
    } 
    return FALSE;
}



@end
