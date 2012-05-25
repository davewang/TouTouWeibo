//
//  LoadMoreTableFooterView.h
//  KlipTao
//
//  Created by Wang Dave on 11-11-13.
//  Copyright (c) 2011年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	LoadMorePulling = 3,
	LoadMoreNormal = 4,
	LoadMoreLoading = 5,	
} LoadMoreState;
@protocol  LoadMoreTableFooterViewDelegate; 
@interface LoadMoreTableFooterView : UIView
{

    id _delegate;
	LoadMoreState _state;
    
	//UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
}

@property(nonatomic,assign) id <LoadMoreTableFooterViewDelegate> delegate;

//- (void)refreshLastUpdatedDate;
- (void)loadMoreScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)loadMoreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)loadMoreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
@protocol LoadMoreTableFooterViewDelegate
- (void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreTableFooterView*)view;
- (BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView*)view;
//@optional
//- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(LoadMoreTableFooterView*)view;
@end