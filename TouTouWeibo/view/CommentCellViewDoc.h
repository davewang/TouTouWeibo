//
//  CommentCellViewDoc.h
//  ZhiWeibo
//
//  Created by junmin liu on 10-11-28.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetDocument.h"
#import "Reply.h"
@interface CommentCellViewDoc : TweetDocument {
	Reply *comment;
	CGFloat docWidth;
	CGFloat profileImageCellWidth;
	
	TweetLayout *profileImageLayout;
	TweetImageLinkNode *profileImageNode;
	
	TweetLayout *timestampLayout;
	TweetTextNode *timestampNode;
	
	TweetLayout *authorLayout;
	TweetTextNode *authorNode;
	
	TweetLayout *commentLayout;	
}

@property (nonatomic, retain) Reply *comment;
@property (nonatomic, assign) CGFloat docWidth;

- (id)initWithComment:(Reply*)_comment width:(CGFloat)_width;
- (void)refreshTimestamp;
+ (CommentCellViewDoc *)documentWithComment:(Reply *)comment_ width:(CGFloat)_width;
- (void)initDoc;
- (void)initContentWithComment;

@end
