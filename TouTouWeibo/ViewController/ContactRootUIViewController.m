//
//  ContactRootUIViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-26.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ContactRootUIViewController.h"
#import "ContactsUIViewController.h"
#import "FindFriendsRootViewController.h"
@implementation ContactRootUIViewController
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
-(void)actionBack{

    self.hidesBottomBarWhenPushed = NO;
    [super actionBack];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
   // [self setViewControllerTitle:@"更多"];
     [self setViewControllerTitle:@"通讯录"];
    data = [[NSArray alloc] initWithObjects:@"我的班级",@"全部好友", nil];
    data2 = [[NSArray alloc] initWithObjects:@"找朋友", nil];
    
    imageNames = [[NSArray alloc] initWithObjects:@"settings_accounts_icon.png",@"settings_accounts_icon.png", nil]; 
    imageNames2 = [[NSArray alloc] initWithObjects:@"settings_accounts_icon.png", nil]; 
    
    // selectd 0 178 238
    // self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"group_picker_cell_separator.png"]];
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //UITableViewCellSeparatorStyle
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==1) {
        return [data2 count];
    }
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
        
    }
    if (indexPath.section==0) {
        
    
    cell.imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
    cell.textLabel.text = [data objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
  
    }else if(indexPath.section==1){
        cell.imageView.image = [UIImage imageNamed:[imageNames2 objectAtIndex:indexPath.row]];
        cell.textLabel.text = [data2 objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //  cell.textLabel.textColor= NAV_TITLE_COLOR;
    //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView  deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row ==1 && indexPath.section==0) {
        ContactsUIViewController *contacts = [[ContactsUIViewController alloc ] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:contacts animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        [contacts release];      
    
    }else if(indexPath.section==1 &&indexPath.row == 0)
    {
        FindFriendsRootViewController *root = [[FindFriendsRootViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:root animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        [root release];  
        
    } 
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end
