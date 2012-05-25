//
//  DianmingUIViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-13.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "DianmingUIViewController.h"

@implementation DianmingUIViewController
@synthesize tableView;
@synthesize dianMingdelegate;
@synthesize dianmingType;
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
-(void)actionBack{

    [self.navigationController dismissModalViewControllerAnimated:YES];
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
-(void)submit:(id)sender
{
     
        if (dianmingType == DianMingTypeUserName) {  
            NSMutableString *str = [[[NSMutableString alloc] initWithCapacity:2] autorelease];
            for (NSString *index in dianmingCheckedIndexs) {
                Friend *user = [friends objectAtIndex:[index intValue] ];
                [str appendFormat:@"#@%@ ",user.friendName];
            }
            NSLog(@"dianming str---->%@",str);
            [dianMingdelegate addUserScreenName:str];
        }else{
            NSMutableString *str = [[[NSMutableString alloc] initWithCapacity:2] autorelease];
            for (NSString *index in dianmingCheckedIndexs) {
                Group *user = [friends objectAtIndex:[index intValue] ];
                [str appendFormat:@"%@,",user.groupId];
            }
            NSLog(@"groupId str---->%@",str);
            [dianMingdelegate addGroupIds:str];
            
        
        }
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
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
    dianmingBuffer  = [[NSMutableString alloc] init];
    if (dianmingType == DianMingTypeUserName) {
         [self setViewControllerTitle:@"点名"];
    }else{
         [self setViewControllerTitle:@"全站"];
        
    }
   
    [self leftBackBtnWithBackgroupImageName:@"navigationbar_button_background.png"  withTitle:@"取消" andAction:@selector(actionBack)];
     
    [self rightBackBtnWithBackgroupImageName:@"navigationbar_button_background.png" withTitle:@"确定" andAction:@selector(submit:)] ;
     [self showWait:YES];
    currentPageNo = 1;
    
    friends = [[NSMutableArray alloc] initWithCapacity:2];
      dianmingCheckedIndexs = [[NSMutableArray alloc] initWithCapacity:2];
   // dianmingUnCheckedIndexs = [[NSMutableArray alloc] initWithCapacity:2];
}



#pragma tableview delegate



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;//  return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert; //
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
  
        return friends.count;
  
 }

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"UserSearchCell";
    
    UITableViewCell *cell = (UITableViewCell*)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (dianmingType==DianMingTypeUserName ) {
   
    Friend  *user = [friends objectAtIndex:indexPath.row ];
	
	cell.textLabel.text = user.friendName;
    cell.accessoryType = UITableViewCellAccessoryNone;
    NSArray *tempArray = [NSArray arrayWithArray:dianmingCheckedIndexs];
    for (NSString *strIndex in tempArray){
        cell.accessoryType = UITableViewCellAccessoryNone;
        if ([strIndex intValue] == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
    }
        
    }else{
        
        Group  *user = [friends objectAtIndex:indexPath.row ];
        
        cell.textLabel.text = user.groupName;
        cell.accessoryType = UITableViewCellAccessoryNone;
        NSArray *tempArray = [NSArray arrayWithArray:dianmingCheckedIndexs];
        for (NSString *strIndex in tempArray){
            cell.accessoryType = UITableViewCellAccessoryNone;
            if ([strIndex intValue] == indexPath.row) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
            }
        }
        
    
    }
    
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    BOOL isCheck = NO;
    @synchronized (self){
     
    for ( NSString *strIndex in dianmingCheckedIndexs) {
        if ([strIndex intValue] == indexPath.row) {
            isCheck = YES;
            [dianmingCheckedIndexs removeObject:strIndex];
            break;
        }
    } 
    }
    if (!isCheck) {
        [dianmingCheckedIndexs addObject:[NSString stringWithFormat:@"%d",indexPath.row]];
    } 
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView reloadData]; 
    
    
	
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
    return  NO;
}




-(void)loadCurrentViewData{
    if (dianmingType == DianMingTypeUserName) {
        
        FriendList *fiendList = [CommonUtils loadFriendList:currentPageNo];
        
        
        if ( fiendList.pageInfo.pageNo >=fiendList.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
        [friends addObjectsFromArray:fiendList.friendInfo];
        
    }else{
    
        GroupList  *fiendList = [CommonUtils loadGroupList:currentPageNo];
        
        
        if ( fiendList.pageInfo.pageNo >=fiendList.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
        if (currentPageNo==1&&[friends count]==0) {
            Group *group = [[Group alloc] init];
            group.groupId = @"all";
            group.groupName = @"全站好友新鲜事";
            [dianmingCheckedIndexs addObject:@"0"];
            [friends addObject:group ];
            [group release];
        }
        [friends addObjectsFromArray:fiendList.groupInfo];
        
    }
     
  
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
    if (friends.count>0) {
        [friends removeAllObjects];
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
    
    
 //   [loadingView startAnimating];
    
   // self.navigationItem.rightBarButtonItem = loadingViewItem;
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

@end
