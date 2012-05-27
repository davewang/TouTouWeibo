//
//  FriendsAboutWithMeViewController.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "FriendsAboutWithMeViewController.h"
#import "ASIFormDataRequest.h"
#import "CJSONDeserializer.h"
#import "WeiBoListModel.h"
#import "TweetCell.h"
#import "StatusCellViewDoc.h"
#import "CommonUtils.h"
#import "Reply.h"
#import "TweetViewController.h"
#define  NAV_ARROW_IMAGE_TAG 1111
@implementation FriendsAboutWithMeViewController
@synthesize tableView; 
@synthesize userId;
@synthesize conversationController;
//
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
		[self.tableView addSubview:view ];
        
        
//        [self.tableView2 addSubview:[view copy]];
//        [self.tableView3 addSubview:[view copy]];
//        
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
        
//        self.tableView2.tableFooterView = [view copy];
//        self.tableView3.tableFooterView = [view copy];
//	
        //[self.tableView addSubview:view];
		_loadMoreTableFooterView = view;
		[view release];
        [self.tableView.tableFooterView setHidden:YES];
//        
//        [self.tableView2.tableFooterView setHidden:YES];
//        [self.tableView3.tableFooterView setHidden:YES];
//		
	}
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (currentType) {
        case 0:
        {
            return [data count];
        }
        case 1:
        {
             return [replys count];
        }
        case 2:
        {
            return [directs count];
        }
            
    }  
    return [data count];
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (currentType==0) 
     {
         WeiBoModel *weiBo = [data objectAtIndex:indexPath.row];
         StatusCellViewDoc *stsDoc = [StatusCellViewDoc documentWithStatus:weiBo width:_tableView.frame.size.width];
     
         static NSString *CellIdentifier = @"StatusCell";
         TweetCell *cell = (TweetCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
         if (cell == nil) {
             cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:CellIdentifier] autorelease];
               cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(float)100/255 green:(float)149/255 blue:(float)237/255 alpha:1];
         }
         cell.doc = stsDoc;
         return cell;
     }else if( currentType==2)
     {
  
         Reply *sts = [Reply ReplyWithWeiboModel:[directs objectAtIndex:indexPath.row]];
         CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
         static NSString *CellIdentifier = @"CommentCell";
         TweetCell *cell = (TweetCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
         if (cell == nil) {
             cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:CellIdentifier] autorelease];
              cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(float)100/255 green:(float)149/255 blue:(float)237/255 alpha:1];
         }
         cell.doc = commentDoc;
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
          return cell;
     
     }else{
      Reply *sts = (Reply *)[replys objectAtIndex:indexPath.row];
      CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
      static NSString *CellIdentifier = @"CommentCell";
      TweetCell *cell = (TweetCell *)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      if (cell == nil) {
        cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                 reuseIdentifier:CellIdentifier] autorelease];
           cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(float)100/255 green:(float)149/255 blue:(float)237/255 alpha:1];
      }
         cell.accessoryType = UITableViewCellAccessoryNone;
         
      cell.doc = commentDoc;
      return cell;
     }
}


- (void)conversationSelected:(Conversation *)conversation {
     conversationController.conversation = conversation;
    [self.navigationController pushViewController:conversationController animated:YES];
   
    
}
-(void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (currentType == 2) {
         //Reply *sts = [Reply ReplyWithWeiboModel:[directs objectAtIndex:indexPath.row]];
         
        [self conversationSelected:[[Conversation alloc] initWithWeiboBean:[directs objectAtIndex:indexPath.row] ]];
    }else if(currentType == 0)
    {
        WeiBoModel *weiBoModel = [data objectAtIndex:indexPath.row];
        
        TweetViewController *tweetView = [[TweetViewController alloc] init] ;
        tweetView.mId = weiBoModel.mId;
        [self.navigationController pushViewController:tweetView animated:YES];
        [tweetView release]; 
    }
    
}
- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (currentType==0 ) { 
        WeiBoModel *weiBo = [data objectAtIndex:indexPath.row];
        StatusCellViewDoc *stsDoc = [StatusCellViewDoc documentWithStatus:weiBo
                                                                    width:_tableView.frame.size.width]; 
        //stsDoc.docWidth = tableView.frame.size.width;
        CGFloat height = stsDoc.height + 8; // margin-bottom: 4
        if (height < 44) {
            height = 44;
        }
        return height;
    }else if(currentType ==2)
    {
        //WeiBoModel *weiBo = [directs objectAtIndex:indexPath.row];
        Reply *sts = [Reply ReplyWithWeiboModel:[directs objectAtIndex:indexPath.row]];
        CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
		CGFloat height = commentDoc.height + 4; // margin-bottom: 10
		if (height < 60) {
			height = 60;
		}
		return height;
    
//        StatusCellViewDoc *stsDoc = [StatusCellViewDoc documentWithStatus:weiBo
//                                                                    width:_tableView.frame.size.width]; 
//        
//        CGFloat height = stsDoc.height + 8;  
//        if (height < 44) {
//            height = 44;
//        }
//        return height;
        
    }else
    {
    	Reply *sts = (Reply *)[replys objectAtIndex:indexPath.row];
		CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
		CGFloat height = commentDoc.height + 4; // margin-bottom: 10
       
		if (height < 60) {
			height = 60;
		}
		return height;
    }
 
}

 
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    UIImageView* tabBarArrow = (UIImageView*)[self.navigationItem.titleView viewWithTag:NAV_ARROW_IMAGE_TAG];
    
    // A single tab item's width is the entire width of the tab bar divided by number of items
    CGFloat tabItemWidth = self.navigationItem.titleView.frame.size.width / 3 ;
    // A half width is tabItemWidth divided by 2 minus half the width of the arrow
    CGFloat halfTabItemWidth = (tabItemWidth / 2.0) - (tabBarArrow.frame.size.width / 2.0);
    
    // The horizontal location is the index times the width plus a half width
    return (tabIndex * tabItemWidth) + halfTabItemWidth;
}
-(void)animationArrow:(NSUInteger)selectedIndex{

    UIImageView* navBarArrow = (UIImageView*)[self.navigationItem.titleView viewWithTag:NAV_ARROW_IMAGE_TAG];
    
     [UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:0.2];
     CGRect frame = navBarArrow.frame;
            frame.origin.x = [self horizontalLocationFor:selectedIndex];
            navBarArrow.frame = frame; 
               
     [UIView commitAnimations];
    

}


-(void)chatAboutMe:(id)sender{
    [self animationArrow:0];
    NSLog(@"----->chatAboutMe");
    if (currentType!=0){
         
//        if (data.count>0) {
//            [data removeAllObjects];
//        }
        currentPageNo = 1;
        currentType = 0; 
        [self.tableView reloadData];
        if (!aboutmeFirstLoad) {
            [self showWait:YES]; 
            aboutmeFirstLoad = YES;
        }
      
        
        self.navigationItem.rightBarButtonItem=nil;
    }
    
    
    
    
}

-(void)replyAboutMe:(id)sender{
      NSLog(@"----->replyAboutMe");
     [self animationArrow:1];
    if (currentType!=1){
//        
//        if (data.count>0) {
//            [data removeAllObjects];
//        }
        currentPageNo = 1;
        currentType = 1; 
        [self.tableView reloadData];
        if (!replyFirstLoad) {
            [self showWait:YES]; 
            replyFirstLoad = YES;
        }
        self.navigationItem.rightBarButtonItem=nil;
      
         
        
    }
    
}

-(void)messageToMe:(id)sender{
      [self animationArrow:2];
    if (currentType!=2){
 
        currentPageNo = 1;
        currentType = 2; 
        [self.tableView reloadData];
        if (!directFirstLoad) {
            [self showWait:YES]; 
            directFirstLoad = YES;
        }
        self.navigationItem.rightBarButtonItem = rightDirMsgItme;
         
        
        
    }


}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad];
 //   self.title = @"评论";
    data = [[NSMutableArray  alloc] initWithCapacity:2];
    
    replys = [[NSMutableArray  alloc] initWithCapacity:2];
    
    directs  = [[NSMutableArray  alloc] initWithCapacity:2];
    currentType = 0;
    currentPageNo = 1;
   
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 132, 44)];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [btn1 setImage:[UIImage imageNamed:@"navigationbar_mentions.png"] forState:UIControlStateNormal];
    //[btn1 setTitle:@"@我" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(chatAboutMe:) forControlEvents:UIControlEventTouchUpInside];
    // btn1.backgroundColor = [UIColor brownColor];
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(44, 0, 44, 44)];
    [btn2 addTarget:self action:@selector(replyAboutMe:) forControlEvents:UIControlEventTouchUpInside];
    //[btn2 setTitle:@"@评论" forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"navigationbar_comments.png"] forState:UIControlStateNormal];
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(88, 0, 44, 44)];
    [btn3 addTarget:self action:@selector(messageToMe:) forControlEvents:UIControlEventTouchUpInside];
    //[btn2 setTitle:@"@评论" forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"navigationbar_messages.png"] forState:UIControlStateNormal];
    
     
    UIImageView* tabBarArrow = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_floating_bar"]] autorelease];
    tabBarArrow.frame = CGRectMake(44/2-tabBarArrow.image.size.width/2, 40, tabBarArrow.image.size.width, tabBarArrow.image.size.height);
    tabBarArrow.tag = NAV_ARROW_IMAGE_TAG;
    
    
    [vi addSubview:tabBarArrow];
    //NAV_ARROW_IMAGE_TAG
    
    //navigationbar_messages 
    //btn2.backgroundColor = [UIColor cyanColor];
    [vi addSubview:btn1];
    [vi addSubview:btn2];
    [vi addSubview:btn3];
    [btn1 release];
    [btn2 release];
    [btn3 release];
    //vi.backgroundColor = [UIColor blueColor];
    self.navigationItem.titleView = vi;  
     
    [vi release];
    
    [self egoRefreshInit];
    // Do any additional setup after loading the view from its nib.
    if(self.tableView.tableFooterView == nil) {
        [self loadMoreFooterInit];
    }
     
    comments = [[NSMutableArray alloc]init];
    commentDocs = [[NSMutableDictionary alloc]init];
    [self showWait:YES];
  //  [self rightBtnWithImageName:<#(NSString *)#> imageHighlightedName:<#(NSString *)#> andAction:<#(SEL)#>]
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 48, 48);
    [rightBtn setImage:[UIImage imageNamed:@"navigationbar_message.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"navigationbar_message_highlighted.png"]  forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(composeButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    rightDirMsgItme=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
}


- (void)composeButtonTouch:(id)sender {
	//[self.navigationController presentModalViewController:composeView animated:YES];
	//[composeView composeNewTweet];
     [AppDelegate getAppDelegate].newDirectMessageViewController.newDirectMessageViewControllerDelegate =self;
	 [[AppDelegate getAppDelegate] newDM];
   
}
-(int) hasConversationIndex:(long long)_userId{
 
    for (int i=0; i<[directs count]; i++) {
        WeiBoModel *weibo = [directs objectAtIndex:i];
        if ([weibo.userId longLongValue] == _userId) {
            return i;
        }
    } 
    return -1;
}
- (void)newDirectMessageTo:(long long)_userId andAttention:(Attention*)user {
	int _index = [self hasConversationIndex:_userId];
    if (_index!=-1) {
        
        [self tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:0]];
        
    }else{
	Conversation *con = [[Conversation alloc] init];
    con.user = [[User alloc] initWithAttention:user];
	con.conversationId = _userId +  [[GlobalInfo sharedGlobalInfo].userId longLongValue];
	[self conversationSelected:con];
    [con release];
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
    [newStatusNSNotificationView setAlpha:(float)1.0];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [newStatusNSNotificationView setAlpha:(float)0.0];
    [UIView commitAnimations];
}
-(void)loadCurrentViewData{
   // loadAllReplyListForMeWithPage
   
    if (currentType==0) {
        WeiBoListModel *weiblist = [CommonUtils loadWeiBoListModelAboutMe:currentPageNo];
      
        if ( weiblist.pageInfo.pageNo >=weiblist.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
        [data addObjectsFromArray:weiblist.weiboList];
       
        [self.tableView reloadData];
          
        
    }else if ( currentType ==1) {
        ReplyList *list  = [CommonUtils loadAllReplyListForMeWithPage:currentPageNo];
       
        if ( list.pageInfo.pageNo >=list.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
            
        }
        //[data addObjectsFromArray:list.replyInfo];
        [replys addObjectsFromArray:list.replyInfo];
       
        [self.tableView reloadData];
        
    }else{
        WeiBoListModel *weiblist = [CommonUtils loadPrivateWeiBoListModelAboutMe:currentPageNo];
        
        if ( weiblist.pageInfo.pageNo >=weiblist.pageInfo.sumPage ) {
            [self.tableView.tableFooterView setHidden:YES];
        }else{
            [self.tableView.tableFooterView setHidden:NO];
        }
       // [data addObjectsFromArray:weiblist.weiboList];
        [directs addObjectsFromArray:weiblist.weiboList];
     
        [self.tableView reloadData];
    }
     
   
    
}
- (void)doneLoadingTableViewData{
    //  model should call this when its done loading
    switch (currentType) {
        case 0:
        {
            if (data.count>0)
                [data removeAllObjects];
            break;
        } 
        case 1:
        {
            
            if (replys.count>0) 
                [replys removeAllObjects];
            break;
        } 
        case 2:
        {
            
            if (directs.count>0) 
                [directs removeAllObjects];
            break;
        } 
        default:
            break;
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
    return NO;
}

@end
 
