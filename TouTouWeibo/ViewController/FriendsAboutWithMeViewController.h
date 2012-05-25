//
//  FriendsAboutWithMeViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-3-3.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CostomNavgationBar.h" 
#import "LoadMoreTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "Page.h"
#import "ReplyList.h"
#import "MessageReply.h"
#import "NewDirectMessageViewController.h"
#import "ConversationController.h"
@interface FriendsAboutWithMeViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,
LoadMoreTableFooterViewDelegate,ConversationControllerDelegate,EGORefreshTableHeaderDelegate,NewDirectMessageViewControllerDelegate>
{
    NSMutableArray *directs;
    NSMutableArray *replys;
    NSMutableArray *data;
    UITableView *tableView; 
    BOOL replyFirstLoad;
    BOOL aboutmeFirstLoad;
    BOOL directFirstLoad;
    
    LoadMoreTableFooterView *_loadMoreTableFooterView;
    int currentType;//0 weibo  1 reply 2 directmessage
    BOOL _moreLoading;
    
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
	BOOL _reloading;
    NSString *userId;
    UIImageView *newStatusNSNotificationView;
    UILabel *newStatuslabelMessage;
    int  currentPageNo;
    NSMutableArray *comments;
	NSMutableDictionary *commentDocs;
    UIBarButtonItem * rightDirMsgItme;
    
    	ConversationController *conversationController;
   
    
}

@property(retain,nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet ConversationController *conversationController;


@property(retain,nonatomic) NSString *userId;
-(void)loadCurrentViewData;

-(void) showWait:(BOOL)visible;
@end

 