//
//  UIView+Textfield.m
//  TextFieldHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "UIView+Textfield.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

CGFloat animatedDistance;
NSArray* textFieldArray;
NSArray* typeArray;
NSMutableArray* requiredArray;
NSMutableArray* dideditArray;
UILabel* resultlabel;

@implementation UIView (Textfield)

// save the UITextField objects into the local array "textFieldArray"
// assign the return key type, the last one is "Go, the others are "Next"
- (void) setTextField:(NSArray*)tfarray {
    textFieldArray = [NSArray arrayWithArray:tfarray];
    requiredArray = [[NSMutableArray alloc] initWithCapacity:[tfarray count]];
    dideditArray = [[NSMutableArray alloc] initWithCapacity:[tfarray count]];
    UITextField *tf;
    for (int i=0; i<[tfarray count]; i++) {
        tf = [[tfarray objectAtIndex:i] objectForKey:@"textfield"];
        tf.tag = i;
        if (i==([tfarray count]-1)) {
            tf.returnKeyType = UIReturnKeyGo;
        } else {
            tf.returnKeyType = UIReturnKeyNext;
        }
        if ([[tfarray objectAtIndex:i] objectForKey:@"requirement"]) {
            NSNumber *req = [[tfarray objectAtIndex:i] objectForKey:@"requirement"];
            [requiredArray addObject:req];
        } else {
            [requiredArray addObject:[NSNumber numberWithBool:YES]];
        }
        [dideditArray addObject:[NSNumber numberWithBool:NO]];
    } 
}

// implement animation to make sure the text field user editing is visible and clear 
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

// called when the user end editing the text field
// do animation back to the previous state
// do validation if needed
- (void) textfieldEndEdit:(UITextField*)textField;{
    
    CGRect viewFrame = self.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self setFrame:viewFrame];    
    [UIView commitAnimations];
    
    [dideditArray replaceObjectAtIndex:textField.tag withObject:[NSNumber numberWithBool:YES]];
    
    if ([[textFieldArray objectAtIndex:textField.tag] objectForKey:@"minlength"]||[[textFieldArray objectAtIndex:textField.tag] objectForKey:@"maxlength"]) {
        [self validateInput];
    }
}

// called when the return key of text field clicked
// leave the text field end edit, automaically go editing the next one
- (void) textfieldReturn:(UITextField*)textField {
    
    if (textField.tag == [textFieldArray count]-1) {
        [textField resignFirstResponder];
    } else {
        UITextField *tf = [[textFieldArray objectAtIndex:textField.tag+1] objectForKey:@"textfield"];
        [tf becomeFirstResponder];
    }
}

// dismiss the keyboard and end edit when the user touch outside the keyboard and text field
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

// do text field input validation
// check minimun and maximun length or specialized option
// if validation fails, show error message on label and give the text field a red border 
- (BOOL) validateInput
{
    int fail=0, i=0, endEditNum=0;
    for (int ii=0; ii<[textFieldArray count]; ii++) {
        if ([[dideditArray objectAtIndex:ii] boolValue]) {
            endEditNum = ii;
        }
    }
    while (i<[textFieldArray count]) {
        if (i==endEditNum+1) {
            break;
        }
        UITextField *tf;
        tf = [[textFieldArray objectAtIndex:i] objectForKey:@"textfield"];
        
        int minLength = 0;      // default value for minimum length is 0 if none is set
        int maxLength = 100;    // default value for maxinum length is 100 if none is set
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
        if (([[dideditArray objectAtIndex:i] boolValue]&&[[requiredArray objectAtIndex:i] boolValue])||
            ([[dideditArray objectAtIndex:i] boolValue]&&![[requiredArray objectAtIndex:i] boolValue])) {
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
        i++;
    }
    if (fail>0) {
        return FALSE;
    } else {
        return TRUE;
    }
}

// do specialized validation: Email format check, number input only, and checking re enter password the same or not 
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
