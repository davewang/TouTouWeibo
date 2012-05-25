//
//  FoundResultViewController.m
//  TouTouWeibo
//
//  Created by oscar on 12-5-10.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "FoundResultViewController.h"
#import "FriendsDetailViewController.h"
#import "FriendObject.h"


@implementation FoundResultViewController
@synthesize  _findFriendsList;
@synthesize tableView=_tableView;
@synthesize findType;



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
    [_findFriendsList release];
    [_tableView release];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
    if ([findType isEqualToString:@"name"]) {
        [self setViewControllerTitle:@"按名称查找"];
    }else if ([findType isEqualToString:@"class"]) {
        [self setViewControllerTitle:@"按班级查找"];
    }     
//    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"查找同城好友",@"查找同城班级",@"查找同城校友",nil];
//    //self._findFriendsList=array;
//    [array release];
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self._findFriendsList count];
    
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
    
    UIView *cView=nil;
	int i=0;
	for (UIView * fuck in [cell subviews]) {
		if (i==0) {
			cView=fuck;
			for (UIView *fuck2 in [cView subviews]) {
				[fuck2 removeFromSuperview];
			}
			i=1;
		}
		break;
	}
    
    UIImageView *profile=[[UIImageView alloc]initWithFrame:CGRectMake(6,6,50,34)];
	UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(70,2,50,18)];
	UILabel *className=[[UILabel alloc] initWithFrame:CGRectMake(70,24,190,18)];
    UIImageView *sexFlag=[[UIImageView alloc]initWithFrame:CGRectMake(124,8,14,14)];
    
    profile.image=[UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
    
    name.font=[UIFont systemFontOfSize:15];
    name.text=[_findFriendsList objectAtIndex:row];
	className.font=[UIFont systemFontOfSize:11];
	name.backgroundColor=[UIColor clearColor];
	className.backgroundColor=[UIColor clearColor];
	className.text=@"PE班级";

	
	[cView addSubview:name];
	[cView addSubview:profile];
	[cView addSubview:className];
	[cView addSubview:sexFlag];
    
    [profile release];
	[name release];
	[className release];
	[sexFlag release];
	
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   FriendsDetailViewController *detail=[[FriendsDetailViewController alloc]init];
    
    //FriendObject*frien=[friends objectAtIndex:indexPath.row];
    //取出 friends中的对象传递给detail列表用来显示 下面代码可以替换   
    FriendObject *frien=[[FriendObject alloc] init];
    frien.userName=@"景李军";
    frien.userSex=@"男";
    frien.userCity=@"宝鸡";
    frien.workName=@"软件开发";
    frien.className=@"计算机";
    frien.qqNo=@"123456";
    frien.msnNo=@"123238@msn.com";
    frien.introduction=@"222222";
    frien.companyName=@"腾讯股份公司";
    frien.companyAddress=@"南山区科技园路1号";
    frien.companyTel=@"0755－82386764";
    
    detail.friendObject=frien;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end
