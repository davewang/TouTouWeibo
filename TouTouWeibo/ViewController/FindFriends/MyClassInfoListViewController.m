//
//  MyClassInfoListViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-6-1.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "MyClassInfoListViewController.h"
#import "ClassInfoList.h"
#import "ClassInfo.h"
#import "ContactsUIViewController.h"

@implementation MyClassInfoListViewController

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setViewControllerTitle:@"我的班级"];
    [self leftBackBtnWithAction:@selector(actionBack)];
    ClassInfoList *classInfo=[CommonUtils loadClassInfoList:1];
    data=classInfo.classList;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [data count];
} 
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kDisplayCell_ID = @"DisplayCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDisplayCell_ID];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDisplayCell_ID] autorelease];
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    }
    ClassInfo *info=[data objectAtIndex:indexPath.row];
    cell.textLabel.text=info.className;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsUIViewController *contacts = [[ContactsUIViewController alloc ] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:contacts animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
    [contacts release];  
}



@end
