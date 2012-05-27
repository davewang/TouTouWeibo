//
//  ContactsUIViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-16.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ContactsUIViewController.h"
#import "ContactCell.h"
#import "FriendsDetailViewController.h"
@implementation ContactsUIViewController

@synthesize tableView;
@synthesize cityId;
@synthesize userId;
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
       // [searchBar addSubview:view];

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
       // [searchBar  setContentOffset:CGPointMake(0, -75) animated:YES];
        [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:) withObject:self.tableView afterDelay:0.4];
    }
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//-(void)locatedMode
//{
//
//}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
	switch (buttonIndex) {
		case 0:
			//[self shareToAll];
            currentOrderType = @"1";
			break;
		case 1:
            currentOrderType = @"2";
			//[self deleteWeibo];
			break;
        case 2:
            currentOrderType = @"3";
			//[self deleteWeibo];
			break;
		default:
			break;
	}
    [self showWait:YES];
}
-(void)orderBy
{ 
    //UIActionSheet *sheet = 
   UIActionSheet *actionButtonActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                 cancelButtonTitle:@"取消" destructiveButtonTitle:nil
                                                 otherButtonTitles:@"按添加时间",@"按名称",@"按地区", nil];
    [actionButtonActionSheet showInView:self.view];
   
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setNeedsDisplay1];
    [self egoRefreshInit];
    // Do any additional setup after loading the view from its nib.
    if(self.tableView.tableFooterView == nil) {
        [self loadMoreFooterInit];
    }     
  // [self leftBackBtnWithAction:@selector(actionBack)];
     
     
    [self  setViewControllerTitle:@"通讯录"];
    [self showWait:YES];
    
    if (!cityId) {
        [self leftBackBtnWithAction:@selector(actionBack)];
    
    UIButton *locatedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    locatedBtn.frame=CGRectMake(0, 0, 40, 30);
    locatedBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [locatedBtn setImage:[UIImage imageNamed:@"located_1.png"]  forState:UIControlStateNormal];
    [locatedBtn addTarget:self action:@selector(locatedMode) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * locatedBtnItem=[[UIBarButtonItem alloc] initWithCustomView:locatedBtn];
         
    
    UIButton *orderBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.frame=CGRectMake(0, 0, 40, 30);
    [orderBtn setTitle:@"排序" forState:UIControlStateNormal];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [orderBtn setBackgroundImage:[CommonUtils stretchableImageFromName:@"navigationbar_button_background.png"]  forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderBy) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * orderBtnItem=[[UIBarButtonItem alloc] initWithCustomView:orderBtn];
    
    self.navigationItem.rightBarButtonItems =[NSArray arrayWithObjects:  orderBtnItem,locatedBtnItem, nil];
    }else{
    
        [self leftBackBtnWithAction:@selector(actionBack)];
    }
    currentPageNo = 1;
    currentOrderType = @"1";
    data = [[NSMutableArray alloc] initWithCapacity:2];
    userId =[GlobalInfo sharedGlobalInfo].userId; 
    mode = ContactListMode;
    
}



#pragma tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.

    if (mode ==ContactListMode) {
        return data.count; 
    }else{
    return searchResult.count;
    }
    
}
 
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    ContactBean *bean = [mode==ContactListMode?data:searchResult objectAtIndex:indexPath.row];
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

-(void)locatedMode{
       
    MapModeViewController *mapview = [[MapModeViewController alloc] init];
    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:mapview animated:YES];
       // self.hidesBottomBarWhenPushed =NO;
    [mapview release];
}
- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 75;
}
  
- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   FriendsDetailViewController *friendsDetail = [[FriendsDetailViewController alloc] init];
    ContactBean *bean = [mode==ContactListMode?data:searchResult objectAtIndex:indexPath.row];

    friendsDetail.friendId = bean.uid;
    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:friendsDetail animated:YES];
    //self.hidesBottomBarWhenPushed =NO;
    [friendsDetail release];
	
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
    return NO;
}


- (NSString*)pinyinOfScreenName:(NSString *)screenName {
	NSMutableString *pinyin = [NSMutableString string];;
	for (int i = 0; i < screenName.length; i++) {
		char t = pinyinFirstLetter([screenName characterAtIndex:i]);
		[pinyin appendFormat:@"%c",t];						 
	}
	return [NSString stringWithString:pinyin];
}
-(NSMutableArray *)searchFriendByScreenName:(NSString*)_searchKey{
    
    if (_searchKey == nil || [_searchKey isEqualToString:@""]) {
		return nil;
	}
    NSMutableArray *results = [[[NSMutableArray alloc] init] autorelease];
    
    
	//NSArray *screenNames = [screenNameToUserKeyDic allKeys];
	for (ContactBean *name in data) {
		//MiniUser *user = [screenNameToUserKeyDic objectForKey:name];
        
		if ([[name.name lowercaseString] rangeOfString:[_searchKey lowercaseString]].location != NSNotFound) {
			//[results addObject:[[[User alloc] initWithMiniUser:user] autorelease]];
            [results addObject: name];
		}
		else if([[[self pinyinOfScreenName:name.name]lowercaseString] rangeOfString:[_searchKey lowercaseString]].location != NSNotFound) {
			//[results addObject:[[[User alloc] initWithMiniUser:user] autorelease]];
            [results addObject: name];
		}
        
	}
	return results;
    
}
- (void)search {
	if ([searchBar.text isEqualToString:@""]) {
        //     [displayController setActive:NO animated:NO];
        //searchResult = [friends retain];
		//return;
        mode = ContactListMode;
        [searchBar resignFirstResponder];
        [self.tableView reloadData];
        return; 
	}else{
         mode = ContactSearchMode;
        [searchResult release];
        // [[FriendCache searchUserByScreenName:searchBar.text] retain];
        searchResult = [[self searchFriendByScreenName:searchBar.text] retain];
        [self.tableView reloadData];
    }
}  
 
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
     [self search];
}
 
/*搜索按钮*/
-(void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar{
	[self search];
}

/*键盘搜索按钮*/
- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar{
	[_searchBar resignFirstResponder];
   // _searchBar.showsCancelButton = YES;
	[self search];
}


#pragma loaddata
-(void)loadCurrentViewData
{
    //FanList *fanList = [CommonUtils loadFanList:currentPageNo andUserId:userId];
    
    NSLog(@"city id = %@",cityId);
    ContactListBean *list = [CommonUtils loadContactListBean:currentPageNo andUserId:userId andCityId:cityId andSortType:currentOrderType];
    if ( list.pageInfo.pageNo >=list.pageInfo.sumPage ) {
        [self.tableView.tableFooterView setHidden:YES];
    }else{
        [self.tableView.tableFooterView setHidden:NO];
    }
    [data addObjectsFromArray:list.contactList];
    [self.tableView reloadData];
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
