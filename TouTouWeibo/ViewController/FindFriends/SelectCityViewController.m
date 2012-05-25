//
//  SelectCityViewController.m
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "SelectCityViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "VlionActionSheet.h"


@implementation SelectCityViewController

@synthesize cityListPicker;
@synthesize cityLabel;
@synthesize districtLabel;

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
-(void)dealloc
{
    [cityListPicker release];
    [cityLabel release];
    [districtLabel release];
}

-(void)labelTap
{
    VlionActionSheet* sheet = [[VlionActionSheet alloc] initWithHeight:284.0f WithSheetTitle:@" "];
//	UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0,50, 320, 50)];
//	label.text = @"在这你想干啥就干啥";
//	label.backgroundColor = [UIColor clearColor];
//	label.textAlignment = UITextAlignmentCenter;
//	[sheet.view addSubview:label];
	[sheet showInView:self.view];
	[sheet release]; 
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setNeedsDisplay1];
    [self setViewControllerTitle:@"按城市查找"];
    cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,10, 260, 50)];
    cityLabel.text=@"深圳";
    cityLabel.font=[UIFont boldSystemFontOfSize:24];
    cityLabel.textAlignment=UITextAlignmentCenter;
    [[cityLabel layer] setCornerRadius:8.0f];
    [[cityLabel layer] setMasksToBounds:YES];
    [[cityLabel layer] setBorderWidth:3.0f];
    cityLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)] autorelease];
    [cityLabel addGestureRecognizer:tapGesture];
    [self.view addSubview:cityLabel];
    
    
    districtLabel = [[UILabel alloc] initWithFrame:CGRectMake(30,70, 260, 50)];
    districtLabel.text=@"福田区";
    districtLabel.textAlignment=UITextAlignmentCenter;
    districtLabel.font=[UIFont boldSystemFontOfSize:24];
    [[districtLabel layer] setCornerRadius:8.0f];
    [[districtLabel layer] setMasksToBounds:YES];
    [[districtLabel layer] setBorderWidth:3.0f];
    districtLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 =
    [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)] autorelease];
    [districtLabel addGestureRecognizer:tapGesture1];
    [self.view addSubview:districtLabel];
    [self leftBackBtnWithAction:@selector(actionBack)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}


@end
