//
//  FinderInCityViewController.m
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "FinderInCityViewController.h"

@implementation FinderInCityViewController

@synthesize tableView=_tableView;
@synthesize _findFriendsVCList;



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
    [_findFriendsVCList release];
    [_tableView release];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
    [self setViewControllerTitle:@"同城查找"];
    
    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"查找同城好友",@"查找同城班级",@"查找同城校友",nil];
    self._findFriendsVCList=array;
    [array release];
  
    imageNames = [[NSArray alloc] initWithObjects:@"lbs_nearbypeople_popuphint_location_icon.png",@"settings_accounts_icon.png",@"settings_accounts_icon.png",@"settings_browsemode_icon.png",@"settings_about_icon.png",@"settings_signout_icon.png", nil]; 
        [self leftBackBtnWithAction:@selector(actionBack)];
    // selectd 0 178 238
    // self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"group_picker_cell_separator.png"]];
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //UITableViewCellSeparatorStyle
    // Do any additional setup after loading the view from its nib.
   // currentCheckInteger = [GlobalInfo sharedGlobalInfo].styleType ;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self._findFriendsVCList count];

} 
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
	NSUInteger row = [indexPath row];
	
        static NSString *kDisplayCell_ID = @"DisplayCellID";
        cell = [tableView dequeueReusableCellWithIdentifier:kDisplayCell_ID];
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDisplayCell_ID] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
        cell.textLabel.text = [_findFriendsVCList objectAtIndex:row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self.tableView  deselectRowAtIndexPath:indexPath animated:YES];
   
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end
