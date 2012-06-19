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
@synthesize scrollview;
@synthesize testlabel;
@synthesize test1;
@synthesize test2;
@synthesize test3;

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
    
    // scrollview setup
    scrollview.contentSize = CGSizeMake(320, 700);
    scrollview.delegate = self;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView:)];
    [scrollview addGestureRecognizer:singleTap];
    
    
    NSMutableArray * textfieldArray = [[NSMutableArray alloc] init ];
    
    CustMenu_num.delegate = self;
    NSMutableDictionary *numberDict = [[NSMutableDictionary alloc] init];
    [numberDict setObject:CustMenu_num forKey:@"textfield"];
    [textfieldArray addObject:numberDict];
    test1.delegate = self;
    NSMutableDictionary *test1Dict = [[NSMutableDictionary alloc] init];
    [test1Dict setObject:test1 forKey:@"textfield"];
    [textfieldArray addObject:test1Dict];
    test2.delegate = self;
    NSMutableDictionary *test2Dict = [[NSMutableDictionary alloc] init];
    [test2Dict setObject:test2 forKey:@"textfield"];
    [textfieldArray addObject:test2Dict];
    test3.delegate = self;
    NSMutableDictionary *test3Dict = [[NSMutableDictionary alloc] init];
    [test3Dict setObject:test3 forKey:@"textfield"];
    [textfieldArray addObject:test3Dict];
    
    
    [self.view setTextField:[NSArray arrayWithArray: textfieldArray]];
    
    // TODO...
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  {    
    [self.view textfieldReturn:textField];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"did begin editing");
    [self.view textfieldMakeVisible:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view textfieldEndEdit:textField];  
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {   
    [self.view textfieldTouchToReturn];
}

- (void)tapScrollView:(UITapGestureRecognizer *)gesture {
    [scrollview textfieldTouchToReturn];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect frame = self.testlabel.frame;
    self.testlabel.frame = CGRectMake( frame.origin.x, 100+scrollview.contentOffset.y, frame.size.width, frame.size.height);
}


- (void)viewDidUnload
{
    [self setCustMenu_num:nil];
    [self setValiSegment:nil];
    [self setTest1:nil];
    [self setTest2:nil];
    [self setTest3:nil];
    [self setTestlabel:nil];
    [self setScrollview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)SetDetailBtn:(id)sender {
    
//    CGRect labelFrame = CGRectMake( 30, 250, 100, 30 );
//    UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
//    [label setText: @"NOT IMPLEMENTED YET"];
//    [label setTextColor: [UIColor orangeColor]];
//    [CustMenu_scroll addSubview:label];
}
@end
