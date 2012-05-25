//
//  FriendsTimelineViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "FriendsTimelineViewController.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "WeiBoListModel.h"
#import "TweetCell.h"
#import "StatusCellViewDoc.h"
#import "CommonUtils.h"
#import "TweetViewController.h"
#import "WEPopoverContentViewController.h"

#import "UIBarButtonItem+WEPopover.h"

#import "MGAutoSizeButton.h"
@implementation FriendsTimelineViewController
@synthesize tableView;

@synthesize popoverController;

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
-(void)viewWillAppear:(BOOL)animated
{

    [self.tableView reloadData];
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [data count];
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    WeiBoModel *weiBo = [data objectAtIndex:indexPath.row];
    //StatusCellViewDoc *stsDoc = [StatusCellViewDoc documentWithStatus:weiBo width:_tableView.frame.size.width];
      StatusCellViewDoc *stsDoc = [StatusCellViewDoc documentWithStatus:weiBo width:_tableView.frame.size.width andStyle:[GlobalInfo sharedGlobalInfo].styleType ];
    
    //stsDoc.docWidth = tableView.frame.size.width;
    //static
    static NSString *CellIdentifier = @"StatusCell";
    TweetCell *cell = (TweetCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        //24 116 205
        //248 248 255  100 149 237
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(float)100/255 green:(float)149/255 blue:(float)237/255 alpha:1];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
       
    }
     
    cell.doc = stsDoc;
    
  //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
WeiBoModel *weiBo = [data objectAtIndex:indexPath.row];
StatusCellViewDoc *stsDoc = [StatusCellViewDoc documentWithStatus:weiBo
                                                            width:_tableView.frame.size.width andStyle:[GlobalInfo sharedGlobalInfo].styleType]; 
//stsDoc.docWidth = tableView.frame.size.width;
CGFloat height = stsDoc.height + 8; // margin-bottom: 4
if (height < 44) {
    height = 44;
}
return height;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(IBAction)listWeibo{
    //BOOL success;
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : WEIBOLIST_URL  ] autorelease ];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:@"0"  forKey:@"type"];
    [request setPostValue:@"1"  forKey:@"pageNo"];
    //[request setValue:@"AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5" forHTTPHeaderField:@"User-Agent"];
   // NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    //[request addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"application/json; charset=%@",charset]];
    // 设置 cookie 使用策略：使用（默认）
    [ request setUseCookiePersistence : YES ];
    [ request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
   // NSString * html=[request responseString] ;
   // NSLog(@" str =>%@  ",   string);
    //[html stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
  //  NSLog(@" html ->%@",html);
    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    //    id theObject = [[CJSONDeserializer deserializer] deserialize:jsonData error:&error];
   // NSLog(@"dictionary ->%@",dictionary);
    
    
   // WeiBoListModel *list = [WeiBoListModel WeiBoListModelWithNSDictionary:dictionary];
    
   // NSLog(@"list->%@",list);
    //    NSLog(@"theObject ->%@",theObject);
    //    
    if (range. location == NSNotFound ) { // 如果 成功
      //  NSLog(@"html->%@",html
            //  );
        
        WeiBoListModel *list = [WeiBoListModel WeiBoListModelWithNSDictionary:dictionary];
        
        data = [list.weiboList retain];
        
        
        
        //NSLog(@"list->%@",list);
        //NSLog(@"list success");
    } else { // 如果 失败 
        
        //NSLog(@"list success");
    }
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad];
    //self.title = @"首页";
    data = [[NSMutableArray  alloc] initWithCapacity:2];
    currentPageNo = 1;
       
    // 0 全部  5 班级 6 我的
    currentType = @"0";
    
    [self egoRefreshInit];
    // Do any additional setup after loading the view from its nib.
    if(self.tableView.tableFooterView == nil) {
        [self loadMoreFooterInit];
    }
    
//    newStatusNSNotificationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320 , 44)];
//    newStatusNSNotificationView.image = [CommonUtils stretchableImageFromName:@"timeline_new_status_background" ];
//    newStatusNSNotificationView.backgroundColor = [UIColor clearColor];  
//    [newStatusNSNotificationView setAlpha:(float)0.0];
//    newStatuslabelMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    newStatuslabelMessage.textAlignment =  UITextAlignmentCenter;
//    newStatuslabelMessage.text = @"10条新微博";
//    newStatuslabelMessage.textColor =[UIColor blackColor];
//    newStatuslabelMessage.backgroundColor = [UIColor clearColor];
//    [newStatusNSNotificationView addSubview:newStatuslabelMessage ];
//    [self.view addSubview:newStatusNSNotificationView];
    
     
    [self leftBackBtnWithImageName:@"navigationbar_compose.png" imageHighlightedName:@"navigationbar_compose_highlighted.png" andAction:@selector(doCompose:)];
    
  
    //[CommonUtils ShowWaitingView:YES];
    //[self performSelector:@selector(loadCurrentViewData) withObject:nil afterDelay:1];
    [self rightBtnWithImageName:@"navigationbar_refresh.png" imageHighlightedName:@"navigationbar_refresh_highlighted.png" andAction:@selector(refreshWeiBoList) ];     
    button = [[MGAutoSizeButton alloc] initWithFrame: CGRectMake(0, 0,120, 40)];
    [button addTarget:self action:@selector(openPoperView:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.text = @"当前用户";
    button.titleLabel.font=[UIFont boldSystemFontOfSize:NAV_TITLE_SIZE];
    [button setRightImage:[UIImage imageNamed:@"navigationbar_arrow_down.png"]];
    self.navigationItem.titleView = button;
    [button layoutSubviews];
    
    
    
    loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingView.frame = CGRectMake(0, 0, 48, 48);
    loadingViewItem=[[UIBarButtonItem alloc] initWithCustomView:loadingView];
    
    [GlobalInfo sharedGlobalInfo].styleType = vKTweetDocumentPreviewStyle;
    
    NSLog(@"--styleType->%d" ,[GlobalInfo sharedGlobalInfo].styleType );
    
      [self showWait:YES];

}

-(void)openPoperView:(id)sender
{
    MGAutoSizeButton *btn = (MGAutoSizeButton*)sender;
    if (!self.popoverController) {
		
		WEPopoverContentViewController *contentViewController = [[WEPopoverContentViewController alloc] initWithStyle:UITableViewStylePlain];
        contentViewController.delegate = self;
		self.popoverController = [[[WEPopoverController alloc] initWithContentViewController:contentViewController] autorelease];
		self.popoverController.delegate = self;
		self.popoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
		
//		[self.popoverController presentPopoverFromBarButtonItem:sender 
//									   permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown) 
//													   animated:YES];
        
             
            [self.popoverController presentPopoverFromRect:CGRectMake(0, 0, 320, 52) inView:self.navigationController.view permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)  animated:YES];
		[contentViewController release];
        btn.rightImage = [UIImage  imageNamed:@"navigationbar_arrow_up.png"];
        [btn layoutSubviews];
	} else {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
        btn.rightImage = [UIImage  imageNamed:@"navigationbar_arrow_down.png"];
        [btn layoutSubviews];
	}
    
  
    
}
-(void)doCompose:(id)sender{

//    ComposeViewController *compose =  [[ComposeViewController alloc] init];
//    
//    [self presentModalViewController:compose animated:YES];
//    
//    [compose release];
    [[AppDelegate getAppDelegate] composeNewTweet];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiBoModel *weiBoModel = [data objectAtIndex:indexPath.row];
    
    TweetViewController *tweetView = [[TweetViewController alloc] init] ;
    tweetView.mId = weiBoModel.mId;
    [self.navigationController pushViewController:tweetView animated:YES];
    [tweetView release];   
}
-(void)selectdOneIndex:(NSInteger)index
{
    [self.popoverController dismissPopoverAnimated:YES];
    self.popoverController = nil;
 
    if (index==0) {
        if (![currentType isEqualToString:@"0"]) {
            currentPageNo = 1;
             currentType = @"0"; 
            [self showWait:YES]; 
            button.titleLabel.text =  [GlobalInfo sharedGlobalInfo].userName;
           
        }
    }else if(index==1){
        if (![currentType isEqualToString:@"6"]) {
            currentPageNo = 1;
            currentType = @"6";
             [self showWait:YES]; 
            
            button.titleLabel.text = @"我的微博";
        }
    }else if(index==2){
        if (![currentType isEqualToString:@"5"]) {
            currentPageNo = 1;
            currentType = @"5";
             [self showWait:YES]; 
            button.titleLabel.text = @"班级";
        }
    }
    button.rightImage = [UIImage  imageNamed:@"navigationbar_arrow_down.png"];
    [button layoutSubviews];
    
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
//    newStatusNSNotificationView.alpha = 1.0f;
//    [UIView beginAnimations:@"fadeIn" context:nil];
//    //[self.view.window addSubview:subview];
//    [UIView setAnimationDuration:2.0];
//    newStatusNSNotificationView.alpha = 0.0f;
//    [UIView commitAnimations];
}
-(void)loadCurrentViewData{
     
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : WEIBOLIST_URL  ] autorelease ];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:currentType forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo]  forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsonData = %@",jsonData);
    
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    if (range.location == NSNotFound ) {
        
        NSLog(@"dictionary = %@",dictionary);
        // 如果 成功
        WeiBoListModel *list = [WeiBoListModel WeiBoListModelWithNSDictionary:dictionary];
        if ( list.pageInfo.pageNo >=list.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
        [data addObjectsFromArray:list.weiboList];
        button.titleLabel.text = [[dictionary objectForKey:@"userInfo"] objectForKey:@"name"];
        [button layoutSubviews]; 
        if (!isFrist) {
        
            
            [GlobalInfo sharedGlobalInfo].userName = [[dictionary objectForKey:@"userInfo"] objectForKey:@"name"];
            [GlobalInfo sharedGlobalInfo].userId = [[dictionary objectForKey:@"userInfo"] objectForKey:@"id"];
            isFrist = YES;
        }
       
       
    } else { 
        // 如果 失败 
        
    }
    
    if (error) {
        [self.parentViewController.navigationController popViewControllerAnimated:YES];
    }
    
    [self.tableView reloadData];
    if (currentPageNo==1) {
        [self doOutLayout];
    }
    
    [CommonUtils ShowWaitingView:NO];
    
}
- (void)doneLoadingTableViewData{
    //  model should call this when its done loading
    if (data.count>0) {
        
        //   NSLog(@"removeAllObjects before data.count = %d",data.count);
        [data removeAllObjects];
        // NSLog(@"removeAllObjects after data.count = %d",data.count);
    }
    
    
    currentPageNo = 1;
    [self.tableView reloadData];
    [self loadCurrentViewData];
	 _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    [loadingView stopAnimating];
    [self rightBtnWithImageName:@"navigationbar_refresh.png" imageHighlightedName:@"navigationbar_refresh_highlighted.png" andAction:@selector(refreshWeiBoList) ]; 
    
	
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
-(void)refreshWeiBoList{
    [self showWait:YES];
}


#pragma mark -
#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
	self.popoverController = nil;
    button.rightImage = [UIImage  imageNamed:@"navigationbar_arrow_down.png"];
    [button layoutSubviews];
    
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
   
    
    [loadingView startAnimating];
    
    self.navigationItem.rightBarButtonItem = loadingViewItem;
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
    return NO;
}

@end
