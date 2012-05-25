//
//  MGTabBarController.m
//  UPPPlugin
//
//  Created by 祝本治 on 11-11-30.
//  Copyright (c) 2011年 中科金财电子商务有限公司. All rights reserved.
//

#import "MGTabBarController.h"
//#import "MGKeyboardObserver.h"

@implementation MGTabBarController
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
       
    }
    return self;

}

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

- (void)dealloc
{
    //[keyboardObserver_ release]; 
    [super dealloc];
}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSArray *subView = [[self view]subviews];
    
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

- (void)setTabBarHeight:(int)height
{
    [[self tabBar] setFrame:CGRectMake(0, 480-height, 320, height)];
    UIView *transView = (UIView *)[[[self view] subviews] objectAtIndex:0];
    [transView setFrame:CGRectMake(0, 0, 320, 480-height)];
}
@end
