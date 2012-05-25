//
//  NewDirectMessageViewController.h
//  ZhiWeibo
//
//  Created by Zhang Jason on 1/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h" 
#import "BaseUIViewController.h"
@class Attention;
@protocol NewDirectMessageViewControllerDelegate

- (void)newDirectMessageTo:(long long)_userId andAttention:(Attention*)user;

@end


@interface NewDirectMessageViewController : BaseUIViewController<UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UISearchBar *searchBar;
	IBOutlet UISearchDisplayController *displayController;
    IBOutlet UITableView *table1;
	//WeiboClient *weiboClient;
	NSMutableArray *searchResult;
    NSMutableArray *friends;
	
	IBOutlet UIView* maskView;
	
	id<NewDirectMessageViewControllerDelegate> newDirectMessageViewControllerDelegate;
}
@property(nonatomic)  id<NewDirectMessageViewControllerDelegate> newDirectMessageViewControllerDelegate;

@end
