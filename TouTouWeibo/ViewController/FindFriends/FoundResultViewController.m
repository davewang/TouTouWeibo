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
#import "CommonFriendBean.h"
#import "ContactBean.h"
@implementation FoundResultViewController
@synthesize  _findFriendsList;
@synthesize tableView=_tableView;
@synthesize findType;
@synthesize findValues;
@synthesize friendList;
@synthesize proviceName;
@synthesize cityName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    
    return self;
}

-(void)egoRefreshInit{
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
}
-(void)loadMoreFooterInit{
    
	if (_loadMoreTableFooterView == nil) {
        
    	LoadMoreTableFooterView *view = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
		view.delegate = self;
        self.tableView.tableFooterView = view;
		//[self.tableView addSubview:view];
		_loadMoreTableFooterView = view;
        [self.tableView.tableFooterView setHidden:YES];
		[view release];
        //[_loadMoreTableFooterView setHidden:YES];
		
	}
    
}
-(void) showWait:(BOOL)visible
{
    _reloading=NO;
    if(!visible)
    {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    }
    else
    {
        [self.tableView setContentOffset:CGPointMake(0, -75) animated:YES];
        [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:) withObject:self.tableView afterDelay:0.4];
    }
}

-(void)locatedMode
{
    MapModeViewController *map=[[MapModeViewController alloc]init];
    map.friendType=findType;
    if ([findType isEqualToString:@"city"]) {
        map.searchText=proviceName;
    }
    else{
        map.searchText=findValues;
    }
    [self.navigationController pushViewController:map animated:YES];
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
    }else if ([findType isEqualToString:@"city"]) {
        [self setViewControllerTitle:@"按城市查找"];
    }else if ([findType isEqualToString:@"0"]) {
        [self setViewControllerTitle:@"同城好友"];
    }else if ([findType isEqualToString:@"1"]) {
        [self setViewControllerTitle:@"同城班级"];
    }else if ([findType isEqualToString:@"2"]) {
        [self setViewControllerTitle:@"同城校友"];
    }
    
    UIButton *locatedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    locatedBtn.frame=CGRectMake(0, 0, 40, 30);
    locatedBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [locatedBtn setImage:[UIImage imageNamed:@"located_1.png"]  forState:UIControlStateNormal];
    [locatedBtn addTarget:self action:@selector(locatedMode) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButton=[[UIBarButtonItem alloc] initWithCustomView:locatedBtn];
    self.navigationItem.rightBarButtonItem=rightButton;

    [self leftBackBtnWithAction:@selector(actionBack)];
    [self egoRefreshInit];
    // Do any additional setup after loading the view from its nib.
    if(self.tableView.tableFooterView == nil) {
        [self loadMoreFooterInit];
    }   
    currentPageNo = 1;
    data = [[NSMutableArray alloc] initWithCapacity:2];
    [self showWait:YES];
//    [self performSelector:@selector(showWait:) withObject:YES afterDelay:0.3];
//    
//    imageNames = [[NSArray alloc] initWithObjects:@"lbs_nearbypeople_popuphint_location_icon.png",@"settings_accounts_icon.png",@"settings_accounts_icon.png",@"settings_browsemode_icon.png",@"settings_about_icon.png",@"settings_signout_icon.png", nil]; 
    
    // selectd 0 178 238
    // self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"group_picker_cell_separator.png"]];
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //UITableViewCellSeparatorStyle
    // Do any additional setup after loading the view from its nib.
    
    // currentCheckInteger = [GlobalInfo sharedGlobalInfo].styleType ;
    //    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"查找同城好友",@"查找同城班级",@"查找同城校友",nil];
    //    //self._findFriendsList=array;
    //    [array release];
}

-(void)loadCurrentViewData{
    NSLog(@"currentPageNo = %d",currentPageNo);
    if ([findType isEqualToString:@"name"]) {
        friendList=[CommonUtils loadFriendObjectWithFriendType:findValues cityId:@"" pageNo:[NSString stringWithFormat:@"%d",currentPageNo] pageSize:@"10" friendType:@"0"];
       // [CommonUtils ShowWaitingView:NO];
        
        if ( friendList.pageInfo.pageNo >=friendList.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
         [data addObjectsFromArray:friendList.commonFriendList];
      //  data=friendList.commonFriendList;
    }
    else if([findType isEqualToString:@"class"])
    {
        self.friendList=[CommonUtils loadFriendObjectWithFriendType:findValues cityId:@"" pageNo:[NSString stringWithFormat:@"%d",currentPageNo] pageSize:@"10" friendType:@"1"];
        //[CommonUtils ShowWaitingView:NO];
        if ( friendList.pageInfo.pageNo >=friendList.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
       // data=friendList.commonFriendList;
         [data addObjectsFromArray:friendList.commonFriendList];
    }
    else if([findType isEqualToString:@"city"])
    {
        self.friendList=[CommonUtils loadFriendObjectWithFriendType:proviceName cityId:cityName pageNo:[NSString stringWithFormat:@"%d",currentPageNo] pageSize:@"10" friendType:@"2"];
        if ( friendList.pageInfo.pageNo >=friendList.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
        [data addObjectsFromArray:friendList.commonFriendList];

    }
    else{
        self.friendList=[CommonUtils loadFriendObjectWithCity:proviceName cityId:cityName pageNo:[NSString stringWithFormat:@"%d",currentPageNo] pageSize:@"10" friendType:findType];
        if ( friendList.pageInfo.pageNo >=friendList.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
        [data addObjectsFromArray:friendList.commonFriendList];
    }
    if ([[friendList.err description] isEqualToString:@"1"]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:friendList.msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    [_tableView reloadData];
    //    self.friendList=[CommonUtils loadFriendObjectWithFriendType: cityName:<#(NSString *)#> pageNo:<#(NSString *)#> pageSize:<#(NSString *)#> friendType:currentType];
    
    //    [CommonUtils ShowWaitingView:NO];
    //    [detailTableView reloadData];
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
    return 75;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [data count];
    
} 
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = nil;
//	NSUInteger row = [indexPath row];
//	
//    static NSString *kDisplayCell_ID = @"DisplayCellID";
//    cell = [tableView dequeueReusableCellWithIdentifier:kDisplayCell_ID];
//    if (cell == nil) 
//    {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDisplayCell_ID] autorelease];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//    }
//    
//    UIView *cView=nil;
//	int i=0;
//	for (UIView * fuck in [cell subviews]) {
//		if (i==0) {
//			cView=fuck;
//			for (UIView *fuck2 in [cView subviews]) {
//				[fuck2 removeFromSuperview];
//			}
//			i=1;
//		}
//		break;
//	}
//    
//    UIImageView *profile=[[UIImageView alloc]initWithFrame:CGRectMake(6,6,50,34)];
//	UILabel *name=[[UILabel alloc] initWithFrame:CGRectMake(70,2,50,18)];
//	UILabel *className=[[UILabel alloc] initWithFrame:CGRectMake(70,24,190,18)];
//    UIImageView *sexFlag=[[UIImageView alloc]initWithFrame:CGRectMake(124,8,14,14)];
//    
//    CommonFriendBean *friendData=[data objectAtIndex:indexPath.row];
//    profile.image=[UIImage imageNamed:@"lbs_nearbypeople_popuphint_location_icon.png"];
//    sexFlag.image=[UIImage imageNamed:@"profile_genderM.png"];
//    name.font=[UIFont systemFontOfSize:15];
//    name.text=friendData.userName;
//    className.font=[UIFont systemFontOfSize:11];
//	name.backgroundColor=[UIColor clearColor];
//	className.backgroundColor=[UIColor clearColor];
////	className.text=friendData.class;
////    profile.image=[UIImage imageNamed:[imageNames objectAtIndex:indexPath.row]];
////    name.font=[UIFont systemFontOfSize:15];
////    name.text=[_findFriendsList objectAtIndex:row];
////	className.font=[UIFont systemFontOfSize:11];
////	name.backgroundColor=[UIColor clearColor];
////	className.backgroundColor=[UIColor clearColor];
//	className.text=@"PE班级";
//
//	
//	[cView addSubview:name];
//	[cView addSubview:profile];
//	[cView addSubview:className];
//	[cView addSubview:sexFlag];
//    
//    [profile release];
//	[name release];
//	[className release];
//	[sexFlag release];
//	
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";  
    ContactCell * cell = (ContactCell*)[_tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];  
    if (cell == nil)  
    {  
        // Create a cell to display an ingredient.  
        // cell = [[[ContactCell alloc] initWithStyle:UITableViewCellStyleSubtitle   
        // reuseIdentifier:showUserInfoCellIdentifier]   
        //   autorelease];  
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactCell" owner:self options:nil] objectAtIndex:0];
    }  
    ContactBean *bean = [ContactBean ContactBeanWithCommonFriendBean:  [data objectAtIndex:indexPath.row]];
    cell.name.text = bean.name;
    cell.className.text = bean.banji;
    cell.mobileNumber.text = bean.telphone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setHeadUrl:bean.image];
    [cell setSex:bean.sex];
    //cell.name.text
    // Configure the cell.  
    //    cell.textLabel.text=@"签名";  
    //    cell.detailTextLabel.text = [NSString stringWithCString:userInfo.user_signature.c_str()  encoding:NSUTF8StringEncoding];  
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [detail release];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}


#pragma mark -
#pragma mark Data Source More Loading / More loading Methods
- (void)loadMoreTableViewDataSource{
    _moreLoading = YES; 
}
- (void)doneMoreLoadingTableViewData{
    currentPageNo ++;
    [self.tableView reloadData];
    [self loadCurrentViewData];
    _moreLoading = NO;
	[_loadMoreTableFooterView loadMoreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
} 

- (void)doneLoadingTableViewData{
    //  model should call this when its done loading
    if (data.count>0) {
        [data removeAllObjects];
    }
    
    
    currentPageNo = 1;
    [self.tableView reloadData];
    [self loadCurrentViewData];
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    
    
  
    
	
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_loadMoreTableFooterView loadMoreScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // NSLog(@"scrollViewDidEndDragging end!");
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreTableFooterView loadMoreshScrollViewDidEndDragging:scrollView];
	
}



#pragma mark -
#pragma mark LoadMoreTableFooterViewDelegate Methods
-(void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreTableFooterView *)view
{
    
    //[self loadMoveTableViewDataSource];
    [self loadMoreTableViewDataSource];
    [self performSelector:@selector(doneMoreLoadingTableViewData)  withObject:nil afterDelay:0.1];
}

-(BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view
{
    return _moreLoading;
}





#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}
@end
