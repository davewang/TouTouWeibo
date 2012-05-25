//
//  TweetSpaceNode.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-21.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TweetNode.h"
@interface TweetSpaceNode : TweetNode {
	NSString *text;
	UIColor *textColor;
	UIColor *highlightedTextColor;
	UIFont *font;
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIColor *highlightedTextColor;
@property (nonatomic, retain) UIFont *font;

- (id)initWithText:(NSString *)_text layout:(TweetLayout*)_layout;

+(TweetSpaceNode *)withText:(NSString *)_text layout:(TweetLayout*)_layout;

@end
