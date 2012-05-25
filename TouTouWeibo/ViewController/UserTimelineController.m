//
//  UserTimelineController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-4.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "UserTimelineController.h"
#import "FriendsTimelineViewController.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "WeiBoListModel.h"
#import "TweetCell.h"
#import "StatusCellViewDoc.h"
#import "CommonUtils.h"
#import "TweetViewController.h"
@implementation UserTimelineController
@synthesize tableView;
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
    
    WeiBoModel *weiBo = [data objectAtIndex:indexPath.row];
    StatusCellViewDoc *stsDoc = [StatusCellViewDoc documentWithStatus:weiBo width:_tableView.frame.size.width];
    //stsDoc.docWidth = tableView.frame.size.width;
    //static
    static NSString *CellIdentifier = @"StatusCell";
    TweetCell *cell = (TweetCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                 reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.doc = stsDoc;
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiBoModel *weiBo = [data objectAtIndex:indexPath.row];
    StatusCellViewDoc *stsDoc = [StatusCellViewDoc documentWithStatus:weiBo
                                                                width:_tableView.frame.size.width]; 
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
    [request setPostValue:@"6"  forKey:@"type"];
    [request setPostValue:@"1"  forKey:@"pageNo"]; 
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    
    // NSString * html=[request responseString] ;
    // NSLog(@" str =>%@  ",   string);
    //[html stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    //  NSLog(@" html ->%@",html);
    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
    
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
       
    if (range. location == NSNotFound ) { // 如果 成功
        //  NSLog(@"html->%@",html
        //  );
        
        WeiBoListModel *list = [WeiBoListModel WeiBoListModelWithNSDictionary:dictionary];
        
        data = [list.weiboList retain];
         
    } else { // 如果 失败 
        
        //NSLog(@"list success");
    }
    
}
-(void)backHome{

    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad];
    // self.title = @"首页";
    [self setViewControllerTitle:@"微博"];
    data = [[NSMutableArray  alloc] initWithCapacity:2];
    currentPageNo = 1;
    
    [self leftBackBtnWithAction:@selector(actionBack)];
    [self rightBackHomeBtnWithAction:@selector(backHome)];
    
    [self loadCurrentViewData];
    // [self listWeibo];
    
    [self egoRefreshInit];
    // Do any additional setup after loading the view from its nib.
    if(self.tableView.tableFooterView == nil) {
         [self loadMoreFooterInit];
    }
    
//    newStatusNSNotificationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,320 , 44)];
//    
//    newStatusNSNotificationView.image = [CommonUtils stretchableImageFromName:@"timeline_new_status_background" ];
//    // [newStatusNSNotificationView :[UIColor colorWithPatternImage:[CommonUtils stretchableImageFromName:@"timeline_new_status_background" ]]];
//    [newStatusNSNotificationView setAlpha:(float)0.0];
//    newStatuslabelMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    newStatuslabelMessage.textAlignment =  UITextAlignmentCenter;
//    newStatuslabelMessage.text = @"10条新微博";
//    newStatuslabelMessage.textColor =[UIColor whiteColor];
//    [newStatusNSNotificationView addSubview:newStatuslabelMessage ];
//    [self.view addSubview:newStatusNSNotificationView];
    //[newStatusNSNotificationView setHidden:YES];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeiBoModel *weiBoModel = [data objectAtIndex:indexPath.row];
    
    TweetViewController *tweetView = [[TweetViewController alloc] init] ;
	tweetView.status = weiBoModel;
  	[self.navigationController pushViewController:tweetView animated:YES];
    [tweetView release];   
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
//-(void)doOutLayout
//{
//    NSLog(@"doOutLayout -->");
//    [newStatusNSNotificationView setAlpha:(float)1.0];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:1.0];
//    [newStatusNSNotificationView setAlpha:(float)0.0];
//    [UIView commitAnimations];
//}
-(void)loadCurrentViewData{
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : WEIBOLIST_URL  ] autorelease ];
    ASIFormDataRequest *request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:@"6"  forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo]  forKey:@"pageNo"];
    [request setUseCookiePersistence : YES ];
    [request startSynchronous ];
    NSString *html = [[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding]autorelease];
    NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    if (range.location == NSNotFound ) {
        // 如果 成功
        WeiBoListModel *list = [WeiBoListModel WeiBoListModelWithNSDictionary:dictionary];
        //NSLog(@"jsondata ->%@",jsonData);
        [data addObjectsFromArray:list.weiboList];
        
    } else { 
        // 如果 失败 
        
    }
    
    if (error) {
        NSLog(@"error>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        [self.parentViewController.navigationController popViewControllerAnimated:YES];
    }
    
    [self.tableView reloadData];
//    if (currentPageNo==1) {
//        [self doOutLayout];
//    }
    
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
