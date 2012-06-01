//
//  AccountManagerViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-31.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "AccountManagerViewController.h"

@implementation AccountManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)actionBack{
 
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setNeedsDisplay1];
    // Do any additional setup after loading the view from its nib.
    [self setViewControllerTitle:@"帐户管理"];
    [self leftBackBtnWithBackgroupImageName:@"navigationbar_button_background.png"  withTitle:@"取消" andAction:@selector(actionBack)];
    
    [self rightBackBtnWithBackgroupImageName:@"navigationbar_button_background.png"  withTitle:@"保存" andAction:@selector(submitButtonPressed:)];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
