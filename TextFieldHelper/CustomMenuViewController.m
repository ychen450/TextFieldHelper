//
//  CustomMenuViewController.m
//  TextFieldHelper
//
//  Created by Chen, Yan-Ling on 5/31/12.
//  Copyright (c) 2012 Chen, Yan-Ling. 
//
//  Released under the MIT License.

#import "CustomMenuViewController.h"

@interface CustomMenuViewController ()

@end

@implementation CustomMenuViewController
@synthesize CustMenu_num;
@synthesize ValiSegment;
@synthesize CustMenu_scroll;

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
    
    CustMenu_scroll.contentSize = CGSizeMake(320, 700);
    
    NSMutableArray * textfieldArray = [[NSMutableArray alloc] init ];
    
    CustMenu_num.delegate = self;
    NSMutableDictionary *numberDict = [[NSMutableDictionary alloc] init];
    [numberDict setObject:CustMenu_num forKey:@"textfield"];
    [textfieldArray addObject:numberDict];
    
    [self.view setTextField:[NSArray arrayWithArray: textfieldArray]];
    
    // TODO...
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
    [self setCustMenu_num:nil];
    [self setValiSegment:nil];
    [self setCustMenu_scroll:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)SetDetailBtn:(id)sender {
    
    CGRect labelFrame = CGRectMake( 30, 250, 100, 30 );
    UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
    [label setText: @"NOT IMPLEMENTED YET"];
    [label setTextColor: [UIColor orangeColor]];
    [CustMenu_scroll addSubview:label];
}
@end
