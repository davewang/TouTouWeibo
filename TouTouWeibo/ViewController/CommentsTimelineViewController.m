//
//  CommentsTimelineViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-5.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "CommentsTimelineViewController.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "WeiBoListModel.h"
#import "TweetCell.h"
#import "StatusCellViewDoc.h"
#import "CommonUtils.h"
#import "Reply.h"
#import "TweetViewController.h"
@implementation CommentsTimelineViewController
@synthesize tableView;
@synthesize weiboId;
//
- (CommentCellViewDoc *)documentWithComment:(Reply *)comment_ width:(CGFloat)_width {
	NSString *cacheKey = [NSString stringWithFormat:@"comment-CI111:%lld-W:%f", comment_.postsId , _width];
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
		[view release];
        //[_loadMoreTableFooterView setHidden:YES];
		
	}
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [data count];
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     
    Reply *sts = (Reply *)[data objectAtIndex:indexPath.row];
    CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
    static NSString *CellIdentifier = @"CommentCell";
    TweetCell *cell = (TweetCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.doc = commentDoc;
    return cell;
    
}
 


- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
     
		Reply *sts = (Reply *)[data objectAtIndex:indexPath.row];
		CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
		CGFloat height = commentDoc.height + 4; // margin-bottom: 10
		if (height < 60) {
			height = 60;
		}
		return height;
	 
}

 
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
 
-(void)replyToStatus
{
    WeiBoModel *weibo = [[WeiBoModel alloc] init];
    weibo.mId = weiboId;
    [[AppDelegate getAppDelegate] replyTweet: weibo];
    [weibo release];
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad];
    //self.title = @"评论";
    [self setViewControllerTitle:@"回复列表"];
    
    data = [[NSMutableArray  alloc] initWithCapacity:2];
    currentPageNo = 1;
  
    
    [self egoRefreshInit];
    // Do any additional setup after loading the view from its nib.
    if(self.tableView.tableFooterView == nil) {
        
        
        [self loadMoreFooterInit];
    }
    [self leftBackBtnWithAction:@selector(actionBack)];
    [self rightBackBtnWithBackgroupImageName:@"navigationbar_button_background.png" withTitle:@"回复" andAction:@selector(replyToStatus)];
//    newStatusNSNotificationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320 , 44)];
//    
//    newStatusNSNotificationView.image = [CommonUtils stretchableImageFromName:@"timeline_new_status_background" ];
//    [newStatusNSNotificationView setAlpha:(float)0.0];
//    newStatuslabelMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    newStatuslabelMessage.textAlignment =  UITextAlignmentCenter;
//    newStatuslabelMessage.text = @"10条新微博";
//    newStatuslabelMessage.textColor =[UIColor blackColor];
//    [newStatusNSNotificationView addSubview:newStatuslabelMessage ];
//    [self.view addSubview:newStatusNSNotificationView];
//    //[newStatusNSNotificationView setHidden:YES];
//    
    newStatusNSNotificationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320 , 44)];
    newStatusNSNotificationView.image = [CommonUtils stretchableImageFromName:@"timeline_new_status_background" ];
    newStatusNSNotificationView.backgroundColor = [UIColor clearColor];  
    [newStatusNSNotificationView setAlpha:(float)0.0];
    newStatuslabelMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    newStatuslabelMessage.textAlignment =  UITextAlignmentCenter;
    newStatuslabelMessage.text = @"10条新微博";
    newStatuslabelMessage.textColor =[UIColor blackColor];
    newStatuslabelMessage.backgroundColor = [UIColor clearColor];
    [newStatusNSNotificationView addSubview:newStatuslabelMessage ];
    [self.view addSubview:newStatusNSNotificationView];
    
    
    comments = [[NSMutableArray alloc]init];
    commentDocs = [[NSMutableDictionary alloc]init];
      [self loadCurrentViewData];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    WeiBoModel *weiBoModel = [data objectAtIndex:indexPath.row];
//    
//    TweetViewController *tweetView = [[TweetViewController alloc] init] ;
//    
//	tweetView.status = [CommonUtils loadWeiBoModelByUId:weiBoModel.mId];//weiBoModel;
//    NSLog(@"tweetView------>%@",tweetView );
//    NSLog(@"...-----------> %@",self.navigationController);
//    // UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:tweetView ];
//	[self.navigationController pushViewController:tweetView animated:YES];
//    // [self.tabBarController.navigationController pushViewController:tweetView animated:YES];
//    //[self.navigationController presentModalViewController:nac animated:YES];
//    [tweetView release];   
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
-(void)doOutLayout
{
    NSLog(@"doOutLayout -->");
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:4.0];
//    [UIView commitAnimations];
     [UIView transitionWithView:self.view duration:100.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [newStatusNSNotificationView setAlpha:(float)1.0];
    } completion:^(BOOL finished) {
        [newStatusNSNotificationView setAlpha:(float)0.0];
    }];
}
-(void)loadCurrentViewData{
    
//    NSURL *tempurl = [[[ NSURL alloc ] initWithString : REPLY_URL  ] autorelease ];
//    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
//    [request setPostValue:weiboId forKey:@"postsId"];
//    [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo] forKey:@"pageNo"];
//     
//    [request setUseCookiePersistence : YES ];
//    [request setDelegate:self];
//    [request startSynchronous ];
//    
//    
//    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
//   
//    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error = nil;
//    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
//    ReplyList *list = [ReplyList ReplyListWithNSDictionary:dictionary];
    ReplyList *list  = [CommonUtils loadReplyListByWeiboId:weiboId withPage:currentPageNo];
    [data addObjectsFromArray:list.replyInfo];
    [self.tableView reloadData];
    if ( list.pageInfo.pageNo >=list.pageInfo.sumPage ) {
        [self.tableView.tableFooterView setHidden:YES];
    }else{
         [self.tableView.tableFooterView setHidden:NO];
    }
    
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

@end
