//
//  TweetCommentsDataSource.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-11-28.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "TweetCommentsDataSource.h"
#import "CommonUtils.h"

@implementation TweetCommentsDataSource
@synthesize statusId,tweetCommentsDataSourceDelegate;

- (id)initWithTableView:(PullRefreshTableView *)_tableView {
	if (self = [super initWithTableView:_tableView]) {
	//	weiboClient = nil;
		comments = [[NSMutableArray alloc]init];
		commentDocs = [[NSMutableDictionary alloc]init];
		loadCell = [[LoadMoreCell alloc]initWithStyle:UITableViewStylePlain reuseIdentifier:@"LoadCell"];
		[loadCell.spinner startAnimating];
		downloadCount = 10;		
		currentPage = 1;
	}
	return self;
}

- (void)dealloc {
	[tableView release];
	tableView = nil;
	[loadCell release];
//	weiboClient.delegate = nil;
//	[weiboClient release];
//	weiboClient = nil;
	[comments release];
	[commentDocs release];
	[super dealloc];
}

- (void)setStatusId:(long long)_statusId {
	if (statusId != _statusId) {
		statusId = _statusId;
		[self reset];
	}
}

- (void)loadRecentComments {
    
    
    
    
    if ( statusId <= 0) { 
		return;
	}
	
	insertPosition = 0;
    
    
    
    NSURL *tempurl = [[[ NSURL alloc ] initWithString : REPLY_URL  ] autorelease ];
     request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
    [request setPostValue:[NSString stringWithFormat:@"%lld",statusId] forKey:@"postsId"];
    [request setPostValue:[NSString stringWithFormat:@"%d",currentPage] forKey:@"pageNo"];
    //  [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo]  forKey:@"pageNo"];
    
    NSLog(@"statusId--->%lld",statusId);
    [request setUseCookiePersistence : YES ];
    [request setDelegate:self];
    [request startSynchronous ];
//	weiboClient = [[WeiboClient alloc] initWithTarget:self 
//											   action:@selector(commentsDidReceive:obj:)];
//	[weiboClient getComments:statusId startingAtPage:0 count:downloadCount];
}

- (void)reloadTableViewDataSource{
    
      
	[self loadRecentComments];
}

- (void)loadComments {
     
    
    
	[loadCell.spinner startAnimating];
	[self reset];
	[self loadRecentComments];
}

- (void)reset {
	currentPage = 0;
//	[weiboClient cancel];
//	[weiboClient release];
//	weiboClient = nil;
      
	isRestored = NO;
	[comments removeAllObjects];
	[commentDocs removeAllObjects];
	[tableView reloadData];
}

- (void)loadMoreCommentsAtPosition:(int)insertPos page:(int)page {
//	if (weiboClient) { 
//		[weiboClient cancel];
//		[weiboClient release];
//		weiboClient = nil;
//	}
    
    
    
    
//	NetworkStatus connectionStatus = [[Reachability2 sharedReachability] internetConnectionStatus];
//	downloadCount = (connectionStatus == ReachableViaWiFiNetwork) ? 100 : 50;
//
//	insertPosition = insertPos;
//	[loadCell.spinner startAnimating];
    
    
    
    
    
    
    
    
//	weiboClient = [[WeiboClient alloc] initWithTarget:self 
//											   action:@selector(commentsDidReceive:obj:)];
//	[weiboClient getComments:statusId startingAtPage:page count:downloadCount];

//    
//    NSURL *tempurl = [[[ NSURL alloc ] initWithString : REPLY_URL  ] autorelease ];
//    request = [[[ ASIFormDataRequest alloc ] initWithURL : tempurl ] autorelease ];
//    [request setPostValue:[NSString stringWithFormat:@"%lld",statusId] forKey:@"postId"];
//    [request setPostValue:[NSString stringWithFormat:@"%d",page] forKey:@"pageNo"];
//    //  [request setPostValue:[NSString stringWithFormat:@"%d",currentPageNo]  forKey:@"pageNo"];
//    
//    NSLog(@"statusId--->%lld",statusId);
//    [request setUseCookiePersistence:YES ];
//    [request setDelegate:self];
//    [request startAsynchronous ];
    
    
}

- (void)stopLoading {
    //[request release];
    //request = nil;
//	[weiboClient release];
//	weiboClient = nil;
	[self doneLoadingTableViewData];
	[loadCell.spinner stopAnimating];	
}


- (void)requestFinished:(ASIHTTPRequest *)_request
{
//    if (sender.hasError) {
//		NSLog(@"commentsDidReceive error!!!, errorMessage:%@, errordetail:%@"
//			  , sender.errorMessage, sender.errorDetail);
//        if (sender.statusCode == 401) {
//            ZhiWeiboAppDelegate *appDelegate = [ZhiWeiboAppDelegate getAppDelegate];
//            [appDelegate openAuthenticateView];
//        }
//        [sender alert];
//    }
    
    NSString *html = [[[NSString alloc]initWithData:[_request responseData] encoding:NSUTF8StringEncoding]autorelease];
    // NSRange range=[html rangeOfString : @"login failed ！ " options : NSCaseInsensitiveSearch ];
    
    NSLog(@"htmml...............>%@",html);
    NSData *jsonData = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    dictionary =[dictionary objectForKey:@"replyInfo"];
    
    int sumPage = [[dictionary objectForKey:@"sumPage"] intValue];
  
    
    dictionary =[dictionary objectForKey:@"reply"];

    
    
    NSLog(@"sumPage ---->%d",sumPage);
    
    NSLog(@"requestFinished ---->%@",dictionary);
    
    if (dictionary == nil || ![dictionary isKindOfClass:[NSArray class]]) {
		[self stopLoading];
        //[request release];
        return;
    }
//	
	if (insertPosition > 0 && comments.count == 0) {
		[self stopLoading];
        //[request release];
		return;
	}
	
	currentPage++; // 页码加1;
	NSArray *ary = (NSArray*)dictionary;    
//	
	BOOL needScroll = comments.count > 0 && insertPosition == 0;
    int unread = 0;
	Reply *firstComment = comments.count > 0 ? [comments objectAtIndex:0] : nil;
	Reply *lastComment = comments.count > 0 ? [comments objectAtIndex:comments.count - 1] : nil;
	for (int i = [ary count] - 1; i >= 0; --i) {
		NSDictionary *dic = (NSDictionary*)[ary objectAtIndex:i];
		if (![dic isKindOfClass:[NSDictionary class]]) {
			continue;
		}
		Reply* sts = [Reply ReplyWithNSDictionary:[ary objectAtIndex:i]];
		if (insertPosition == 0) {
			if ((firstComment 
				 && sts.postsId <= firstComment.postsId)) {
				continue;
			}
		}
		else {
			if (lastComment && sts.postsId >= lastComment.postsId) {
				continue;
			}
		}
		
		[comments insertObject:sts atIndex:insertPosition];
		++unread;
	}
    
	if ([ary count] == 0) {
		isRestored = YES;
	}
	
	int count = unread;
	if ([tableView numberOfRowsInSection:0] == 0 && isRestored == NO)
		count += 1;
	
	CGPoint offset = tableView.contentOffset;
	if (count > 0) {
		int numInsert = count;
		int scrollHeight = 0;
		for (int i = 0; i < numInsert; ++i) {
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:insertPosition + i inSection:0];
			if (insertPosition == 0) {
				scrollHeight += [self tableView:tableView heightForRowAtIndexPath:indexPath];
			}
		}        
		offset.y += scrollHeight;
	}
    if (currentPage>sumPage || currentPage==sumPage) {
        isHaveData = NO;
        
        [loadCell setHidden:YES];
    }else{
        [loadCell setHidden:NO];
        
    }
	[tableView reloadData];
	if (needScroll) {
		tableView.contentOffset = offset;
	}
	[tableView flashScrollIndicators];
	[self stopLoading];
   
    //[request release];

    
}
//
//- (void)commentsDidReceive:(WeiboClient*)sender obj:(NSObject*)obj
//{
//    if (sender.hasError) {
//		NSLog(@"commentsDidReceive error!!!, errorMessage:%@, errordetail:%@"
//			  , sender.errorMessage, sender.errorDetail);
//        if (sender.statusCode == 401) {
//            ZhiWeiboAppDelegate *appDelegate = [ZhiWeiboAppDelegate getAppDelegate];
//            [appDelegate openAuthenticateView];
//        }
//        [sender alert];
//    }
//	
//    if (obj == nil || ![obj isKindOfClass:[NSArray class]]) {
//		[self stopLoading];
//        return;
//    }
//	
//	if (insertPosition > 0 && comments.count == 0) {
//		[self stopLoading];
//		return;
//	}
//	
//	currentPage++; // 页码加1;
//	NSArray *ary = (NSArray*)obj;    
//	
//	BOOL needScroll = comments.count > 0 && insertPosition == 0;
//    int unread = 0;
//	Comment *firstComment = comments.count > 0 ? [comments objectAtIndex:0] : nil;
//	Comment *lastComment = comments.count > 0 ? [comments objectAtIndex:comments.count - 1] : nil;
//	for (int i = [ary count] - 1; i >= 0; --i) {
//		NSDictionary *dic = (NSDictionary*)[ary objectAtIndex:i];
//		if (![dic isKindOfClass:[NSDictionary class]]) {
//			continue;
//		}
//		Comment* sts = [Comment commentWithJsonDictionary:[ary objectAtIndex:i]];
//		if (insertPosition == 0) {
//			if ((firstComment 
//				 && sts.commentId <= firstComment.commentId)) {
//				continue;
//			}
//		}
//		else {
//			if (lastComment && sts.commentId >= lastComment.commentId) {
//				continue;
//			}
//		}
//		
//		[comments insertObject:sts atIndex:insertPosition];
//		++unread;
//	}
//
//	if ([ary count] == 0) {
//		isRestored = YES;
//	}
//	
//	int count = unread;
//	if ([tableView numberOfRowsInSection:0] == 0 && isRestored == NO)
//		count += 1;
//	
//	CGPoint offset = tableView.contentOffset;
//	if (count > 0) {
//		int numInsert = count;
//		int scrollHeight = 0;
//		for (int i = 0; i < numInsert; ++i) {
//			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:insertPosition + i inSection:0];
//			if (insertPosition == 0) {
//				scrollHeight += [self tableView:tableView heightForRowAtIndexPath:indexPath];
//			}
//		}        
//		offset.y += scrollHeight;
//	}
//	[tableView reloadData];
//	if (needScroll) {
//		tableView.contentOffset = offset;
//	}
//	[tableView flashScrollIndicators];
//	[self stopLoading];
//}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return isRestored == YES ? [comments count] : [comments count] + 1;
}

- (CommentCellViewDoc *)documentWithComment:(Reply *)comment_ width:(CGFloat)_width {
	NSString *cacheKey = [NSString stringWithFormat:@"comment-CI:%lld-W:%f", comment_.postsId , _width];
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
	if (indexPath.row < comments.count) {
		Reply *sts = (Reply *)[comments objectAtIndex:indexPath.row];
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
    
    return loadCell;
}

- (CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < comments.count) {
		Reply *sts = (Reply *)[comments objectAtIndex:indexPath.row];
		CommentCellViewDoc *commentDoc = [self documentWithComment:sts width:tableView.frame.size.width];
		CGFloat height = commentDoc.height + 4; // margin-bottom: 10
		if (height < 60) {
			height = 60;
		}
		return height;
	}
	return 48;
}


#pragma mark -
#pragma mark Table view delegate


- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < comments.count) {
		id obj = [comments objectAtIndex:indexPath.row];
		if (obj) {
			if ([obj isKindOfClass:[Reply class]]) {
				Reply *cmt = (Reply *)obj;
				if (cmt) {
					if (tweetCommentsDataSourceDelegate) {
						[tweetCommentsDataSourceDelegate commentSelected:cmt];
					}
				}
			}
		}
	}
	else {    
		[loadCell.spinner startAnimating];
		if (comments.count == 0) {
			[self loadComments];
		}
		else {
			[self loadMoreCommentsAtPosition:comments.count page:currentPage + 1];
		}		
		[_tableView deselectRowAtIndexPath:indexPath animated:NO];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	//NSLog(@"scrollViewDidScroll with content offset: (%f, %f).", tableView.contentOffset.x, tableView.contentOffset.y);
	if (comments.count == 0 
		|| isRestored == YES||isHaveData==YES 
		 ) { //没有数据，或者已经全部加载完毕，或者正在加载
		return;
	}
	NSArray *indexPathes = [tableView indexPathsForVisibleRows];
	if (indexPathes.count > 0) {
		int rowCounts = [tableView numberOfRowsInSection:0];
		NSIndexPath *lastIndexPath = [indexPathes objectAtIndex:indexPathes.count - 1];
		if (rowCounts - lastIndexPath.row < 3) {
			[loadCell.spinner startAnimating];
			Reply *lastComment = [comments objectAtIndex:comments.count - 1];
			if (lastComment && [lastComment isKindOfClass:[Reply class]]) {
				[self loadMoreCommentsAtPosition:comments.count page:currentPage + 1];
			}
		}
	}
}



@end
