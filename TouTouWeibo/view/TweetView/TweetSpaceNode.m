//
//  TweetSpaceNode.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-4-21.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "TweetSpaceNode.h"
#import "TweetLayout.h"

@implementation TweetSpaceNode
@synthesize text;
@synthesize textColor;
@synthesize highlightedTextColor;
@synthesize font;


- (id)initWithText:(NSString *)_text layout:(TweetLayout*)_layout {
	if (self = [super initWithLayout:_layout]) {
		text = [_text copy];
		self.font = _layout.font;
	}
	return self;
}

+(TweetSpaceNode *)withText:(NSString *)_text layout:(TweetLayout*)_layout {
	return [[[TweetSpaceNode alloc] initWithText:_text layout:_layout] autorelease];
}

- (NSString *)html {
	return [NSString stringWithFormat:@"<br>", text];;
}

- (void)dealloc {
	[text release];
	[textColor release];
	[highlightedTextColor release];
	[font release];
	[super dealloc];
}


@end
