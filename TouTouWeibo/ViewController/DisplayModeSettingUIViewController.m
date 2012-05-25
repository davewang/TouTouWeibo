//
//  DisplayModeSettingUIViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-27.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "DisplayModeSettingUIViewController.h"
 
#import "CheckBoxView.h"
#define SOUND_ENABLE_TAG  1111   
@implementation DisplayModeSettingUIViewController
@synthesize tableView=_tableView;
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
    [self setViewControllerTitle:@"浏览模式"];
    data = [[NSArray alloc] initWithObjects:@"预览图模式",@"经典模式",@"文字模式",nil];
   
    // selectd 0 178 238
//    self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"group_picker_cell_separator.png"]];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    
    [self leftBackBtnWithAction:@selector(actionBack)];
    //UITableViewCellSeparatorStyle
    // Do any additional setup after loading the view from its nib.
    
    indicatorTick = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userinfo_relationship_indicator_tick"]];
    
    currentCheckInteger = [GlobalInfo sharedGlobalInfo].styleType ;
    
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
    
    return [data count];
} 
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell * cell = [_tableView
                              dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if(cell == nil) {
        
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:SimpleTableIdentifier] autorelease];
        //cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        //24 116 205
        
        
    }
   // cell.imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (indexPath.row == currentCheckInteger) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    
    }
        
   
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if (indexPath.row ==currentCheckInteger) {
      
        [self.tableView  deselectRowAtIndexPath:indexPath animated:YES];
    }else{
        [self.tableView  deselectRowAtIndexPath:indexPath animated:YES];
        currentCheckInteger = indexPath.row;
        [self.tableView reloadData];
        [GlobalInfo sharedGlobalInfo].styleType = currentCheckInteger;
    } 
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end
