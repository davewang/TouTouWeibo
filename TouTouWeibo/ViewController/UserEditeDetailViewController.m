//
//  UserEditeDetailViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-15.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "UserEditeDetailViewController.h"

@implementation UserEditeDetailViewController
@synthesize content; 
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)submit{
    if (delegate) {
        [delegate UserDidEdite:texView.text];
        [self actionBack];
    }
    
     
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self leftBackBtnWithAction:@selector(actionBack)];
    [self rightBackBtnWithBackgroupImageName:@"navigationbar_button_background" withTitle:@"保存" andAction:@selector(submit)];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [texView becomeFirstResponder];
    texView.text = content;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
