//
//  FindFriendsRootViewController.m
//  TouTouWeibo
//
//  Created by oscar on 12-5-8.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "FindFriendsRootViewController.h"
#import "ShakeFrinedsViewController.h"
#import "FinderInCityViewController.h"
#import "FindFriendByTypeViewController.h"
#import "SelectCityViewController.h"
#import "SayHelloViewController.h"

@implementation FindFriendsRootViewController

@synthesize tableView=_tableView;
@synthesize _findFriendsVCList1;
@synthesize _findFriendsVCList2;
 


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
    [_findFriendsVCList1 release];
    [_findFriendsVCList2 release];
    [_tableView release];
}
-(void) sayHelloListViewController
{
    SayHelloViewController * sayController = [[SayHelloViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sayController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    [SayHelloViewController release];
}
-(void)setViewControllerCustomTitle{
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    titleView.backgroundColor=[UIColor clearColor];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=NAV_TITLE_COLOR;
    titleLabel.text=@"找朋友";
    titleLabel.font=[UIFont systemFontOfSize:NAV_TITLE_SIZE];
    [titleView addSubview:titleLabel];
    [titleLabel release];
    
    headButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 5,40, 35)];
    [headButton addTarget:self action:@selector(sayHelloListViewController) forControlEvents:UIControlEventTouchUpInside];
    headButton.backgroundColor=[UIColor redColor];
    //        [headButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [headButton setTitle:@"12" forState:UIControlStateNormal];
    //        headButton.hidden=YES;
    [titleView addSubview:headButton];
    self.navigationItem.titleView = titleView;
    [titleView release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
    [self setViewControllerCustomTitle];
    [self leftBackBtnWithAction:@selector(actionBack)];
    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"摇一摇",@"同城查找",nil];
    self._findFriendsVCList1=array;
    NSMutableArray *array1=[[NSMutableArray alloc] initWithObjects:@"按名称查找",@"按班级查找",@"按城市查找",nil];
    self._findFriendsVCList2=array1;
    [array release];
    [array1 release];
    imageNames = [[NSArray alloc] initWithObjects:@"lbs_nearbypeople_popuphint_location_icon.png",@"settings_accounts_icon.png",@"settings_accounts_icon.png",@"settings_browsemode_icon.png",@"settings_about_icon.png",@"settings_signout_icon.png", nil]; 
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
    switch (section) 
	{
		case 0: 
			return [self._findFriendsVCList1 count];   break;
		case 1: 
			return [self._findFriendsVCList2 count];   break;
		default: 
			return 0 ;  break;
	}
} 
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    NSUInteger section=[indexPath section];
	NSUInteger row = [indexPath row];
	if (section==0) 
	{
			static NSString *kDisplayCell_ID = @"DisplayCellID";
			cell = [tableView dequeueReusableCellWithIdentifier:kDisplayCell_ID];
			if (cell == nil) 
			{
			    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDisplayCell_ID] autorelease];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
			}
            cell.imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
            cell.textLabel.text = [_findFriendsVCList1 objectAtIndex:row];
    }else if (section==1) 
	{
        static NSString *kDisplayCell_ID1 = @"DisplayCellID1";
        cell = [tableView dequeueReusableCellWithIdentifier:kDisplayCell_ID1];
        if (cell == nil) 
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDisplayCell_ID1] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.imageView.image = [UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
        cell.textLabel.text = [_findFriendsVCList2 objectAtIndex:row];
         //return cell;
    } 
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
 return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section=[indexPath section];
    [self.tableView  deselectRowAtIndexPath:indexPath animated:YES];
    if (section==0) {
        if (indexPath.row ==0) {
            ShakeFrinedsViewController *shakeFrinedsVC =  [[ShakeFrinedsViewController alloc ] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shakeFrinedsVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            [shakeFrinedsVC release];
        
        }else if(indexPath.row ==1)
        {
            FinderInCityViewController *findFrinedsInCityVC = [[FinderInCityViewController alloc ] init ];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:findFrinedsInCityVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
             [findFrinedsInCityVC release];
        }

    }
    else if(section==1){
            FindFriendByTypeViewController *find=[[FindFriendByTypeViewController alloc]init];
        SelectCityViewController *selcectVC
        =[[SelectCityViewController alloc]init];
            if (indexPath.row==0) {
                
                find.findType=@"name";
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:find animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                [find release];
            }
            else if(indexPath.row==1) {
                find.findType=@"class";
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:find animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                [find release];
                
            }
            else {
                selcectVC.findType=@"city";
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:selcectVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                [selcectVC release];
            }
            
           
            
        } 
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end

