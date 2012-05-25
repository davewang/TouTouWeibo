//
//  NewDirectMessageViewController.m
//  ZhiWeibo
//
//  Created by Zhang Jason on 1/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewDirectMessageViewController.h"
#import "UserCell.h"
#import "UserCache.h"
#import "FriendCache.h"
#import "MiniUser.h"


@implementation NewDirectMessageViewController
@synthesize newDirectMessageViewControllerDelegate;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
//-(void)viewDidLoad{
// [self loadFriends];
//}

- (void)viewWillAppear:(BOOL)animated {
	//[displayController setActive:YES animated:YES];
     
	[searchBar becomeFirstResponder];
    [self loadFriends];
	searchBar.text = @"";
   
	[super viewWillAppear:animated];
}
- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView{

    NSLog(@"------>didShowSearchResultsTableView");
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [friends release];
	[searchResult release];
    [super dealloc];
}

-(void)loadFriends{
    FriendList *_friends = [CommonUtils loadFriendList:1];
	friends = _friends.friendInfo;
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
	for (Friend *name in friends) {
		//MiniUser *user = [screenNameToUserKeyDic objectForKey:name];
        
		if ([[name.friendName lowercaseString] rangeOfString:[_searchKey lowercaseString]].location != NSNotFound) {
			//[results addObject:[[[User alloc] initWithMiniUser:user] autorelease]];
            [results addObject: name];
		}
		else if([[[self pinyinOfScreenName:name.friendName]lowercaseString] rangeOfString:[_searchKey lowercaseString]].location != NSNotFound) {
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
        return; 
	}else{
 	[searchResult release];
    // [[FriendCache searchUserByScreenName:searchBar.text] retain];
    searchResult = [[self searchFriendByScreenName:searchBar.text] retain];
    }
}



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
    if ( ![searchBar.text isEqualToString:@""] ) {
        
        NSLog(@"searchResult.count =%d",searchResult.count);
        return searchResult.count ;
    }else{
        NSLog(@"friends.count =%d",friends.count);
        return friends.count;
    }
  //  return  ![searchBar.text isEqualToString:@""]?searchResult.count :friends.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"UserSearchCell";
    
    UserCell *cell = (UserCell*)[_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UserCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
//	if (indexPath.row == 0) {
//		cell.textLabel.text = [NSString stringWithFormat:@"%@",searchBar.text];
//	}
//	else {
    Attention *user ;
    if ([searchBar.text isEqualToString:@""]) {
         user = [Attention AttentionWithFriend:[friends objectAtIndex:indexPath.row ]];
		
    }else{
		 user = [Attention AttentionWithFriend:[searchResult objectAtIndex:indexPath.row ]];		 
    }
    if(user){
        cell.user = user;
    }
//	}
    return cell;
}

- (void)tableView:(UITableView *)_tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Attention *user ;
    if ([searchBar.text isEqualToString:@""]) {
        user = [Attention AttentionWithFriend:[friends objectAtIndex:indexPath.row ]];
        [self dismissModalViewControllerAnimated:NO];
        [newDirectMessageViewControllerDelegate newDirectMessageTo:[user.attOfUserId longLongValue] andAttention:user];
    }else{
        user = [Attention AttentionWithFriend:[searchResult objectAtIndex:indexPath.row ]];	
        [self dismissModalViewControllerAnimated:NO];
        [newDirectMessageViewControllerDelegate newDirectMessageTo:[user.attOfUserId longLongValue] andAttention:user];
    }
	//	[self dismissModalViewControllerAnimated:NO];
 		//[newDirectMessageViewControllerDelegate newDirectMessageTo:[[searchResult objectAtIndex:indexPath.row - 1] userId]];
	
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
	[self search];
	return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{

    NSLog(@"searchOption = %d",searchOption);
    return YES;
}

- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)stopLoading {
	[maskView removeFromSuperview];
//	weiboClient.delegate = nil;
//	[weiboClient release];
//	weiboClient = nil;
}

//- (void)usersDidReceive:(WeiboClient*)sender obj:(NSObject*)obj
//{
//	if (obj == nil) {
//		[self stopLoading];
//        return;
//    }
////    if (sender.hasError) {
////		NSLog(@"usersDidReceive error!!!, errorMessage:%@, errordetail:%@"
////			  , sender.errorMessage, sender.errorDetail);
////        if (sender.statusCode == 401) {
////            ZhiWeiboAppDelegate *appDelegate = [ZhiWeiboAppDelegate getAppDelegate];
////            [appDelegate openAuthenticateView];
////        }
////        [sender alert];
////		[self stopLoading];
////		return;
////    }
//	
//    
//	NSDictionary *dic = (NSDictionary*)obj;
//	User* user = [User userWithJsonDictionary:dic];
//	[UserCache cache:user];
//	[self stopLoading];
//	[self dismissModalViewControllerAnimated:NO];
//	[newDirectMessageViewControllerDelegate newDirectMessageTo:user.userId];
//}

@end
