//
//  SayHelloViewController.m
//  TouTouWeibo
//
//  Created by 张 林 on 12-5-24.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "SayHelloViewController.h"
#import "CommonUtils.h"
@implementation SayHelloViewController
@synthesize _tableView,countArray;
-(void)dealloc
{
    [_tableView release];
    [countArray release];
    [super dealloc];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad];
    [self setViewControllerTitle:@"找朋友"];
    
    ShakeListBean * shakeList = [CommonUtils loadShakeListBeanUserId:[GlobalInfo sharedGlobalInfo].userId];
    self.countArray=shakeList.shakeList;
    
    [self leftBackBtnWithAction:@selector(actionBack)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [countArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";  
    ContactCell * cell = (ContactCell*)[tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];  
    if (cell == nil)  
    {  
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactCell" owner:self options:nil] objectAtIndex:0];
    }  
    ShakeBean *bean = [countArray objectAtIndex:indexPath.row];
    cell.name.text = bean.userName;
    cell.className.text = bean.area;
//    cell.mobileNumber.text = bean.;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setHeadUrl:bean.userPhoto];
//    [cell setSex:bean.sex];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
