//
//  BaseTableViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-16.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController
@synthesize tableView;
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
    [self.navigationController.navigationBar setNeedsDisplay1];
    [self egoRefreshInit];
    // Do any additional setup after loading the view from its nib.
    if(self.tableView.tableFooterView == nil) {
        [self loadMoreFooterInit];
    }     
    //[self leftBackBtnWithAction:@selector(actionBack)];
    
    //[self setViewControllerTitle:@"粉丝"];
    [self showWait:YES];
    currentPageNo = 1;
    
    data = [[NSMutableArray alloc] initWithCapacity:2];
    comments = [[NSMutableArray alloc]init];
    commentDocs = [[NSMutableDictionary alloc]init];
    
}



#pragma tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return data.count;
    
}
- (CommentCellViewDoc *)documentWithComment:(Reply *)comment_ width:(CGFloat)_width {
	NSString *cacheKey = [NSString stringWithFormat:@"commentAbout-CI222:%lld-W:%f", comment_.postsId , _width];
	CommentCellViewDoc *doc = [commentDocs objectForKey:cacheKey];
	if (!doc) {
		doc = [[CommentCellViewDoc alloc] init];
		doc.docWidth = _width;
		doc.comment = comment_;
		[commentDocs setObject:doc forKey:cacheKey];
		[doc release];
	}
	[doc refreshTimestamp];
	return doc;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Reply *sts = [Reply  ReplyWithFanBean:[data objectAtIndex:indexPath.row] ];
    
    CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
    
    static NSString *CellIdentifier = @"CommentCell";
    TweetCell *cell = (TweetCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.doc = commentDoc;
    return cell;
}
- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{  
    Reply *sts =[Reply  ReplyWithFanBean:[data objectAtIndex:indexPath.row] ];
    CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
    CGFloat height = commentDoc.height + 4; // margin-bottom: 10
    if (height < 60) {
        height = 60;
    }
    return height;
    
    
}


- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
	
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



#pragma loaddata
-(void)loadCurrentViewData
{
    FanList *fanList = [CommonUtils loadFanList:currentPageNo andUserId:userId];
    
    
    if ( fanList.pageInfo.pageNo >=fanList.pageInfo.sumPage ) {
        [self.tableView.tableFooterView setHidden:YES];
    }else{
        [self.tableView.tableFooterView setHidden:NO];
    }
    [data addObjectsFromArray:fanList.fanList];
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
