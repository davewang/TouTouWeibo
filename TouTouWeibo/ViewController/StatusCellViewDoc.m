//
//  StatusCellViewDoc.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-8.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "StatusCellViewDoc.h"

#define kMarginLeft 8
#define kMarginRight 12
#define kMarginTop 8
#define kMarginV 6
#define kPhotoWidth 60
#define kPhotoHeight 60
#define kPhotoMargin 4
#define kProfileImageSize 24
#define kRetweetMarginH 8
#define kRetweetMarginTop 16
#define kRetweetMarginBottom 8

static NSMutableDictionary *gTweetDocument = nil;
static UIFont *defaultTimestampFont;
static UIColor *defaultTimestampTextColor;
static UIFont *defaultAuthorFont;
static UIImage *defaultLocationImage;
static UIFont *defaultRepostSourceFont;
static UIColor *defaultRepostTextColor;
static UIFont *defaultRepostCommentsFont;
static UIFont *defaultRepostCommentsLinkFont;
static UIColor *defaultRepostCommentsTextColor;
static UIColor *defaultRepostCommentsLinkTextColor;
static UIFont *defaultSourceFont;
static UIColor *defaultSourceTextColor;
static UIFont *defaultCommentsFont;
static UIFont *defaultCommentsLinkFont;
static UIColor *defaultCommentsTextColor;
static UIColor *defaultCommentsLinkTextColor;

static UIImage *defaultAuthorVerifiedImageNode = nil;

static UIImage *retweetBackgroundImage = nil;
static UIImage *defaultTweetImage = nil;


@interface StatusCellViewDoc (Private)

- (void)initDoc;

@end

@implementation StatusCellViewDoc
//@synthesize status, docWidth;
@synthesize weiBoModel, docWidth;
@synthesize styleType;

- (id)init {
	if (self = [super init]) {
		docWidth = 320;
		profileImageCellWidth = 72;
		[self initDoc];
	}
	return self;
}
- (id)initWithDocWidth:(float)_docWidth andStyleType:(TweetStyleType)_type {
	if (self = [super init]) {
		docWidth = _docWidth;
		profileImageCellWidth = 72;
        styleType = _type;
		[self initDoc];
	}
	return self;
}
+ (StatusCellViewDoc *)documentWithStatus:(WeiBoModel *)status_ width:(CGFloat)_width andStyle:(TweetStyleType)_type {
	if (!gTweetDocument) {
		gTweetDocument = [[NSMutableDictionary alloc]init];
	}
    
    NSLog(@"_type = %d",_type);
	NSString *cacheKey = [NSString stringWithFormat:@"status-SI:%@-W:%f-Style:%d", status_.uid, _width,_type];
	StatusCellViewDoc *doc = [gTweetDocument objectForKey:cacheKey];
	if (!doc) {
		doc = [[StatusCellViewDoc alloc] initWithDocWidth:_width andStyleType:_type];
		//doc.docWidth = _width;
		doc.weiBoModel = status_;
        //doc.styleType = _type;
        NSLog( @" doc.styleType = %d", doc.styleType);
        NSLog(@" _type =%d",_type);
		[gTweetDocument setObject:doc forKey:cacheKey];
		[doc release];
	}
	[doc refresh];
	return doc;
}


+ (StatusCellViewDoc *)documentWithStatus:(WeiBoModel *)status_ width:(CGFloat)_width {
	if (!gTweetDocument) {
		gTweetDocument = [[NSMutableDictionary alloc]init];
	}
	NSString *cacheKey = [NSString stringWithFormat:@"status-SI:%@-W:%f", status_.uid, _width];
	StatusCellViewDoc *doc = [gTweetDocument objectForKey:cacheKey];
	if (!doc) {
		doc = [[StatusCellViewDoc alloc] init];
		doc.docWidth = _width;
		doc.weiBoModel = status_;
		[gTweetDocument setObject:doc forKey:cacheKey];
		[doc release];
	}
	[doc refresh];
	return doc;
}
 

- (NSString *)getImageUrl {
	NSString *imageUrl = nil;
    if (weiBoModel.sharePhoto && !weiBoModel._isForm) {
        
        if (weiBoModel.sharePhoto.sharePhotoSmallPath && weiBoModel.sharePhoto.sharePhotoSmallPath.length > 0) {
            imageUrl = weiBoModel.sharePhoto.sharePhotoSmallPath;
        }
    }else
    if(weiBoModel._isForm && weiBoModel._fromSmallPath)
    {
        NSLog(@"@weiBoModel._fromSmallPath = %@", weiBoModel._fromSmallPath);
        if (weiBoModel._fromSmallPath && weiBoModel._fromSmallPath.length > 0) {
            imageUrl = weiBoModel._fromSmallPath;
        }
        
    }
	return imageUrl;
}
- (void)initSizeWithWidthandStyle{ 
    
    //NSLog(@"initSizeWithWidth>>>>>>>>111");
    
     
	if (docWidth <= 0) {
		return;
	}
	CGFloat y = kMarginTop;
   
	profileImageLayout.frame = CGRectMake(kMarginLeft, y, kProfileImageSize, kProfileImageSize);
 	authorLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize, y + 2, docWidth - kMarginLeft * 2 - kProfileImageSize - kMarginRight, 15);
    if (styleType == vKTweetDocumentWordStyle ) {
        
        
        profileImageLayout.frame = CGRectZero;
        authorLayout.frame = CGRectMake(kMarginLeft * 2 , y + 2, docWidth - kMarginLeft * 2  - kMarginRight, 15);
    }
	timestampLayout.frame = CGRectMake(0, y + 4, docWidth - kMarginRight, 12);
	
	
    
    y += kProfileImageSize + kMarginV;
    
    //y +=  (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize) + kMarginV;
 
   
	CGFloat textWidth = docWidth - (kMarginLeft * 2 +  (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize)) - kMarginRight + 4;
    //&& !weiBoModel._isForm && weiBoModel.sharePhoto
	NSString *photoUrl =nil;
    if (![weiBoModel.mId isEqualToString:@""] ) {
        if (weiBoModel.sharePhoto && !weiBoModel._isForm) {
            
            photoUrl = weiBoModel.sharePhoto.sharePhotoSmallPath;
        }
        if ( weiBoModel._isForm && weiBoModel._fromSmallPath) {
            photoUrl = weiBoModel._fromSmallPath;
        }
        
    }
    
	
    
	statusLayout.frame = CGRectMake(kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize), y - 2, textWidth, 0);
	[statusLayout setNeedsLayout];
    BOOL hasPhoto = photoUrl && photoUrl.length > 0;
    NSLog(@"dave styleType ==%d",styleType);
    if (hasPhoto && styleType!=vKTweetDocumentPreviewStyle) {
        hasPhoto = NO;
    }
	if (hasPhoto && !weiBoModel._isForm) { // 非转发，有图
        CGFloat textHeight = statusLayout.frame.size.height + kRetweetMarginH + kPhotoHeight;
        statusLayout.frame = CGRectMake(kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize), y - 2, textWidth, textHeight);
    }
    
	
	CGFloat textHeight = statusLayout.frame.size.height;
	y = statusLayout.frame.origin.y + statusLayout.frame.size.height;
    if  (![weiBoModel.mId isEqualToString:@""] && weiBoModel._isForm) {
        
        
        
		y += 0;
		CGFloat marginV = kRetweetMarginTop + kRetweetMarginBottom;
        
		retweetLayout.frame = CGRectMake((kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize)) + kRetweetMarginH, y + kRetweetMarginTop, textWidth, 0);
		[retweetLayout setNeedsLayout];
		textHeight = retweetLayout.frame.size.height + 20;
        if (hasPhoto) { 
			textHeight = retweetLayout.frame.size.height + kRetweetMarginH + kPhotoHeight;
            imageLayout.frame = CGRectMake(kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize)+ kRetweetMarginH,y + kRetweetMarginTop + retweetLayout.frame.size.height + kRetweetMarginH, kPhotoWidth, kPhotoHeight);
		}
        
		repostCommentsLayout.frame = CGRectMake(kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize) + kRetweetMarginH, y + kRetweetMarginTop + textHeight - 14, textWidth, 14);
		retweetBackgroundImageNode.height = textHeight + marginV;
		retweetBackgroundLayout.frame = CGRectMake(kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize), y, docWidth - (kMarginLeft * 2 + kProfileImageSize) - kMarginRight, textHeight + marginV);
		retweetBackgroundImageNode.width = retweetBackgroundLayout.frame.size.width;
		retweetBackgroundImageNode.imageWidth = retweetBackgroundImageNode.width;
		retweetBackgroundImageNode.imageHeight = retweetBackgroundImageNode.height;		
		[retweetBackgroundLayout setNeedsLayout];
		y += kRetweetMarginTop + textHeight + kRetweetMarginBottom;	
	}
	else {
		repostCommentsLayout.frame = CGRectZero;
		repostSourceLayout.frame = CGRectZero;
		retweetBackgroundLayout.frame = CGRectZero;
		retweetLayout.frame = CGRectZero;
		repostLayoutAuthor.frame = CGRectZero;
        if (hasPhoto) { 
			textHeight = statusLayout.frame.size.height + y + 2 + kPhotoHeight;
            imageLayout.frame = CGRectMake(kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize),y + kRetweetMarginTop + retweetLayout.frame.size.height + kRetweetMarginH, kPhotoWidth, kPhotoHeight);
		}
		y = statusLayout.frame.origin.y + textHeight;
	}
 	sourceLayout.frame = CGRectMake((kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize)), y + kMarginV, statusLayout.frame.size.width, 14);
	commentsLayout.frame = CGRectMake((kMarginLeft * 2 + (styleType == vKTweetDocumentWordStyle? 0:kProfileImageSize)), y + kMarginV, docWidth - (kMarginLeft * 2 + kProfileImageSize) - kMarginRight, 14);
	if (!hasPhoto) {
		imageLayout.frame = CGRectZero;
	}	
//    if (styleType ==  vKTweetDocumentPreviewStyle) {
//        imageLayout.frame = CGRectZero;
//    }
    //	if (status.latitude != 0 && status.longitude != 0) {
    //		locationImageNode.defaultImage = defaultLocationImage;// .imageUrl = @"bundle://mini-pin-classic.png";
    //	}
    //	else {
    //		locationImageNode.defaultImage = nil;
    //	}
    
	[self setNeedsLayout];
}

- (void)initSizeWithWidth { 
    
    //NSLog(@"initSizeWithWidth>>>>>>>>111");
	if (docWidth <= 0) {
		return;
	}
	CGFloat y = kMarginTop;
	profileImageLayout.frame = CGRectMake(kMarginLeft, y, kProfileImageSize, kProfileImageSize);
	authorLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize, y + 2, docWidth - kMarginLeft * 2 - kProfileImageSize - kMarginRight, 15);
	timestampLayout.frame = CGRectMake(0, y + 4, docWidth - kMarginRight, 12);
	
	y += kProfileImageSize + kMarginV;
	CGFloat textWidth = docWidth - (kMarginLeft * 2 + kProfileImageSize) - kMarginRight + 4;
    //&& !weiBoModel._isForm && weiBoModel.sharePhoto
	NSString *photoUrl =nil;
    if (![weiBoModel.mId isEqualToString:@""] ) {
        if (weiBoModel.sharePhoto && !weiBoModel._isForm) {
         
            photoUrl = weiBoModel.sharePhoto.sharePhotoSmallPath;
        }
        if ( weiBoModel._isForm && weiBoModel._fromSmallPath) {
            photoUrl = weiBoModel._fromSmallPath;
        }
        
    }
     
	
    
	statusLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize, y - 2, textWidth, 0);
	[statusLayout setNeedsLayout];
    
    
    
    BOOL hasPhoto = photoUrl && photoUrl.length > 0;
    // NSMutableArray *nodes;
	if (hasPhoto && !weiBoModel._isForm) { // 非转发，有图
        //dave edit
		//textWidth = docWidth - kPhotoWidth - kPhotoMargin - kMarginLeft - kMarginRight + 4;
		//imageLayout.frame = CGRectMake(docWidth - kPhotoWidth - kMarginRight, y, kPhotoWidth, kPhotoWidth);
      
        
        
       // imageLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize,y - 2 + statusLayout.frame.size.height + kRetweetMarginH, kPhotoWidth, kPhotoHeight);
        
        CGFloat textHeight = statusLayout.frame.size.height + kRetweetMarginH + kPhotoHeight;
       // statusLayout.frame = CGRectMake(kMarginLeft, y - 2, textWidth, textHeight);
        statusLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize, y - 2, textWidth, textHeight);
        
	}
    
	
	CGFloat textHeight = statusLayout.frame.size.height;
	y = statusLayout.frame.origin.y + statusLayout.frame.size.height;
    if  (![weiBoModel.mId isEqualToString:@""] && weiBoModel._isForm) {
        
        
        
		y += 0;
		CGFloat marginH = kMarginLeft + kMarginRight + kRetweetMarginH * 2;
		CGFloat marginV = kRetweetMarginTop + kRetweetMarginBottom;
 
        //dave edit
//		if (hasPhoto) 
//        {
//			textWidth = docWidth - kPhotoWidth - kPhotoMargin * 2 - marginH + 4;
//			imageLayout.frame = CGRectMake(docWidth - kPhotoWidth - kMarginRight - kRetweetMarginH, y + kRetweetMarginTop, kPhotoWidth, kPhotoHeight);
//            textWidth = docWidth - kPhotoWidth - kPhotoMargin * 2 - marginH + 4;
//            imageLayout.frame = CGRectMake(docWidth - kPhotoWidth - kMarginRight - kRetweetMarginH, y + kRetweetMarginTop, kPhotoWidth, kPhotoHeight);
             
//		}
//		else 
//        {
			//textWidth = docWidth - marginH + 4;
//		}
		retweetLayout.frame = CGRectMake((kMarginLeft * 2 + kProfileImageSize) + kRetweetMarginH, y + kRetweetMarginTop, textWidth, 0);
		[retweetLayout setNeedsLayout];
		textHeight = retweetLayout.frame.size.height + 20;
//		if (hasPhoto && textHeight < kPhotoHeight) { 
//			textHeight = kPhotoHeight;
//		}
        
        if (hasPhoto) { 
			textHeight = retweetLayout.frame.size.height + kRetweetMarginH + kPhotoHeight;
            imageLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize+ kRetweetMarginH,y + kRetweetMarginTop + retweetLayout.frame.size.height + kRetweetMarginH, kPhotoWidth, kPhotoHeight);
		}
		 
		repostCommentsLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize + kRetweetMarginH, y + kRetweetMarginTop + textHeight - 14, textWidth, 14);
		retweetBackgroundImageNode.height = textHeight + marginV;
		retweetBackgroundLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize, y, docWidth - (kMarginLeft * 2 + kProfileImageSize) - kMarginRight, textHeight + marginV);
		retweetBackgroundImageNode.width = retweetBackgroundLayout.frame.size.width;
		retweetBackgroundImageNode.imageWidth = retweetBackgroundImageNode.width;
		retweetBackgroundImageNode.imageHeight = retweetBackgroundImageNode.height;		
		[retweetBackgroundLayout setNeedsLayout];
		y += kRetweetMarginTop + textHeight + kRetweetMarginBottom;	
	}
	else {
		repostCommentsLayout.frame = CGRectZero;
		repostSourceLayout.frame = CGRectZero;
		retweetBackgroundLayout.frame = CGRectZero;
		retweetLayout.frame = CGRectZero;
		repostLayoutAuthor.frame = CGRectZero;
//		if (hasPhoto && textHeight < kPhotoHeight) {
//			textHeight = kPhotoHeight;
//		}
        if (hasPhoto) { 
			textHeight = statusLayout.frame.size.height + y + 2 + kPhotoHeight;
            imageLayout.frame = CGRectMake(kMarginLeft * 2 + kProfileImageSize,y + kRetweetMarginTop + retweetLayout.frame.size.height + kRetweetMarginH, kPhotoWidth, kPhotoHeight);
		}
		y = statusLayout.frame.origin.y + textHeight;
	}
 	sourceLayout.frame = CGRectMake((kMarginLeft * 2 + kProfileImageSize), y + kMarginV, statusLayout.frame.size.width, 14);
	commentsLayout.frame = CGRectMake((kMarginLeft * 2 + kProfileImageSize), y + kMarginV, docWidth - (kMarginLeft * 2 + kProfileImageSize) - kMarginRight, 14);
	if (!hasPhoto) {
		imageLayout.frame = CGRectZero;
	}	
//	if (status.latitude != 0 && status.longitude != 0) {
//		locationImageNode.defaultImage = defaultLocationImage;// .imageUrl = @"bundle://mini-pin-classic.png";
//	}
//	else {
//		locationImageNode.defaultImage = nil;
//	}

	[self setNeedsLayout];
}

- (void)initContentWithStatus {	
	profileImageNode.url = [NSString stringWithFormat:@"@%@", weiBoModel.userName];//status.user.nickname];
	profileImageNode.imageUrl = weiBoModel.headPhoto;//status.user.headphoto;
	authorNode.text = weiBoModel.userName;//status.user.nickname;
    NSMutableArray *nodes;
    
    
    if (![weiBoModel.mId isEqualToString:@""] && !weiBoModel._isForm)
    {
      
        if (weiBoModel.sharePhoto)
        {
           nodes = [self parseStatus:weiBoModel.mContent layout:statusLayout];
        }else
        if(weiBoModel.shareUrl)
        {
            
            nodes = [self parseStatus: [NSString stringWithFormat:@"%@  %@",weiBoModel.mContent,weiBoModel.shareUrl.shareUrlName] layout:statusLayout];
        }else{
            nodes = [self parseStatus:weiBoModel.mContent layout:statusLayout];
        
        }
        
        
    }else{
        
         nodes = [self parseStatus:weiBoModel.mContent layout:statusLayout];
    
    }
    
    
    
    
//    if ([weiBoModel.mId isEqualToString:@""]) {
//       // nodes = [self parseStatus:weiBoModel.actionDescription layout:statusLayout];
//         nodes = [self parseStatus:weiBoModel.actionDescription layout:statusLayout];
//        
//    }else if (weiBoModel._isForm && weiBoModel.shareUrl) 
//    {
//          nodes = [self parseStatus: [NSString stringWithFormat:@"%@  %@",weiBoModel.mContent,weiBoModel.shareUrl.shareUrlName] layout:statusLayout];
//     //    nodes = [self parseStatus: [NSString stringWithFormat:@"%@  %@",weiBoModel.actionDescription,weiBoModel.shareUrl.shareUrlName] layout:statusLayout];
//    }else {
//         nodes = [self parseStatus:weiBoModel.mContent layout:statusLayout];
//        // nodes = [self parseStatus:weiBoModel.actionDescription layout:statusLayout];
//    }
	//weiBoModel.userName
    [statusLayout reset];
	for (TweetNode *node in nodes) {
		[statusLayout addNode:node];
	}
    
    
    NSMutableArray *retweetLayoutNodes; 
   
    if (![weiBoModel.mId isEqualToString:@""] && weiBoModel._isForm)
    {
        
        //repostAuthorImageNode.imageUrl = weiBoModel._fromId;
        repostAuthorLinkNode.url = [NSString stringWithFormat:@"@%@", weiBoModel._fromUserId];
        repostAuthorLinkNode.text = weiBoModel._fromUserName;
       // repostSourceNode.text = [NSString stringWithFormat:@"来自 %@", status.retweetedStatus.source];
        
        //retweetLayoutNodes = [self parseStatus:status.retweetedStatus.text layout:retweetLayout];
//        [retweetLayout reset];
//        [retweetLayout addNode:repostAuthorImageNode];
//        [retweetLayout addNode:repostAuthorLinkNode];
//        
        if(weiBoModel.shareUrl)
        {
            
            retweetLayoutNodes = [self parseStatus: [NSString stringWithFormat:@"%@  %@",weiBoModel._fromDes,weiBoModel.shareUrl.shareUrlName] layout:retweetLayout];
            [retweetLayout reset];
            [retweetLayout addNode:repostAuthorLinkNode];
            [retweetLayout addNodeForText:@": "];
            for (TweetNode *node in retweetLayoutNodes) {
                [retweetLayout addNode:node];
            }
           
        }else{
            
            retweetLayoutNodes = [self parseStatus:weiBoModel._fromDes layout:retweetLayout];
            [retweetLayout reset];
           // [retweetLayout addNode:repostAuthorImageNode];
            [retweetLayout addNode:repostAuthorLinkNode];
            [retweetLayout addNodeForText:@": "];
            for (TweetNode *node in retweetLayoutNodes) {
                [retweetLayout addNode:node];
            }  
            
        
        }
    
    }
    
    
    
    
    
    
    
   

    
    NSString *imageUrl = [self getImageUrl];
    
  
	if (imageUrl && imageUrl.length > 0) {
		imageNode.imageUrl = imageUrl;
		imageNode.url = [NSString stringWithFormat:@"photo:%lld",weiBoModel.mId];
//        NSLog(@"davewang2001--->%@",NSStringFromCGRect(imageLayout.frame));
//        NSLog(@"davewang2002--->%@",[self getImageUrl]);
//        NSLog(@"davewang2003--->%@",weiBoModel.mContent );
	}
	else {
		imageLayout.frame = CGRectZero;
	}
   // NSLog(@"timestamp ->%@",weiBoModel.timestamp);
    if ([weiBoModel.mId isEqualToString:@""]) {
        timestampNode.text = @"";    
    }else
    {
	    timestampNode.text = weiBoModel.timestamp;	
	}
    sourceNode.text = [NSString stringWithFormat:@"来自 %@", weiBoModel._mFrom ];

	[self refreshComments];
}

- (void)dealloc {
	
	profileImageLayout = nil;
	profileImageNode = nil;
	
	authorLayout = nil;
	authorNode = nil;
	
	statusLayout = nil;
	
	retweetBackgroundLayout = nil;
	retweetBackgroundImageNode = nil;
	
	repostLayoutAuthor = nil;
	repostImageNode = nil;
	
	[repostAuthorImageNode release];
	repostAuthorImageNode = nil;
	[repostAuthorLinkNode release];
	repostAuthorLinkNode = nil;
	
	retweetLayout = nil;
	
	[repostCommentsLinkNode release];
	[repostRetweetsLinkNode release];
	[commentsLinkNode release];
	[retweetsLinkNode release];
	
	imageLayout = nil;
	imageNode = nil;
	
	timestampLayout = nil;
	timestampNode = nil;
	
	[weiBoModel  release];
	[super dealloc];
}

- (void)initDoc {
	CGFloat y = kMarginTop;
	//-------------profileImage
	profileImageLayout = [[TweetLayout alloc] 
						  initWithFrame:CGRectMake(kMarginLeft, y, kProfileImageSize, kProfileImageSize)
						  doc:self];
	[self addLayout:profileImageLayout];
	[profileImageLayout release];
	
	profileImageNode = [profileImageLayout addNodeForImageLink:nil imageUrl:nil
														 width:kProfileImageSize height:kProfileImageSize];
	profileImageNode.cacheName = @"profileImages";
	profileImageNode.className = @"profileImageSmall";
	
	static UIImage *defaultProfileImage;
	if (!defaultProfileImage) {
		defaultProfileImage = [[[UIImage imageNamed:@"ProfilePlaceholderOverWhite.png"] resizeImageWithNewSize:CGSizeMake(24, 24)] retain];
	}
	profileImageNode.defaultImage = defaultProfileImage;
	
	
	//--------------timestamp
	if (!defaultTimestampFont) {
		defaultTimestampFont = [[UIFont boldSystemFontOfSize:12] retain];
	}
	if (!defaultTimestampTextColor) {
		defaultTimestampTextColor = [[UIColor colorWithRed:0x9F/255.0f green:0x9F/255.0f blue:0xA2/255.0f alpha:1] retain];
	}
	if (!defaultLocationImage) {
		defaultLocationImage = [[UIImage imageNamed:@"mini-pin-classic.png"]retain];
	}
	timestampLayout = [[TweetLayout alloc]initWithFrame:CGRectMake(0, y + 4, docWidth - kMarginRight, 12)
													doc:self];
	timestampLayout.font = defaultTimestampFont;
	timestampLayout.textColor = defaultTimestampTextColor;
	timestampLayout.horizontalAlign = LayoutHorizontalAlignRight;
	[self addLayout:timestampLayout];
	[timestampLayout release];
	locationImageNode = [timestampLayout addNodeForImageUrl:nil width:10 height:13];
	locationImageNode.margin = UIEdgeInsetsMake(0, 2, 0, 2); 
	timestampNode = [timestampLayout addNodeForText:nil];
	
	//-------------author
	authorLayout = [[TweetLayout alloc] initWithFrame:CGRectMake(kMarginLeft + 2 + kProfileImageSize, y + 2, docWidth - kMarginLeft * 2 - kProfileImageSize - kMarginRight, 15) doc:self];
	[self addLayout:authorLayout];
	[authorLayout release];
	if (!defaultAuthorFont) {
		defaultAuthorFont = [[UIFont boldSystemFontOfSize:15] retain];
	}
	if (!defaultAuthorVerifiedImageNode) {
		defaultAuthorVerifiedImageNode = [[UIImage imageNamed:@"verified.png"] retain];
	}
	authorLayout.font = defaultAuthorFont;
	authorNode = [authorLayout addNodeForText:nil];
	authorVerifiedImageNode = [authorLayout addNodeForImageUrl:nil width:12 height:13];
	authorVerifiedImageNode.margin = UIEdgeInsetsMake(4, 1, 0, 2);
	//authorVerifiedImageNode.verticalAlign = LayoutVerticalAlignBottom;
	
	//-------------status
	statusLayout = [[TweetLayout alloc] initWithFrame:CGRectMake(profileImageCellWidth, 32, docWidth - profileImageCellWidth - 14, 0) doc:self];
	//statusLayout.font = [UIFont systemFontOfSize:15];
	//statusLayout.linkFont = [UIFont boldSystemFontOfSize:15];
	//statusLayout.linkTextColor = [UIColor colorWithRed:0x23/255.0F green:0x6E/255.0F blue:0xD8/255.0F alpha:1];
	[self addLayout:statusLayout];
	[statusLayout release];
	
	//-------------retweet
	//-------------splitline
	CGRect splitLineFrame = CGRectMake(profileImageCellWidth, statusLayout.frame.origin.y + statusLayout.frame.size.height + 10
									   , docWidth - profileImageCellWidth - 26, 60);
	retweetBackgroundLayout = [[TweetLayout alloc] initWithFrame:splitLineFrame doc:self];
	[self addLayout:retweetBackgroundLayout];
	[retweetBackgroundLayout release];
	retweetBackgroundImageNode = [retweetBackgroundLayout addNodeForImageUrl:nil 
															   width:splitLineFrame.size.width 
															  height:splitLineFrame.size.height];
	
	if (!retweetBackgroundImage) {
		retweetBackgroundImage = [[[UIImage imageNamed:@"retweet_bg.png"] stretchableImageWithLeftCapWidth:32 topCapHeight:16] retain];
	}
	retweetBackgroundImageNode.defaultImage = retweetBackgroundImage;
		
	//-------------retweet
	retweetLayout = [[TweetLayout alloc]initWithFrame:CGRectMake(profileImageCellWidth, splitLineFrame.origin.y + 20, docWidth - profileImageCellWidth - 20, 0)
												  doc:self];
	//dave 
//   retweetLayout.font = [UIFont systemFontOfSize:15];
//	retweetLayout.linkFont = [UIFont boldSystemFontOfSize:15];
//	retweetLayout.linkTextColor = [UIColor colorWithRed:0x23/255.0F green:0x6E/255.0F blue:0xD8/255.0F alpha:1];
//	
    
    repostAuthorImageNode = [[retweetLayout addNodeForImageUrl:nil
															 width:16 height:16] retain];
	repostAuthorImageNode.margin = UIEdgeInsetsMake(0, 0, 0, 2);
	repostAuthorLinkNode = [[retweetLayout addNodeForLink:nil url:nil] retain];

	[self addLayout:retweetLayout];
	[retweetLayout release];
	
	//-------------repostSource
	if (!defaultRepostSourceFont) {
		defaultRepostSourceFont = [[UIFont systemFontOfSize:13] retain];
	}
	if (!defaultRepostTextColor) {
		defaultRepostTextColor = [[UIColor lightGrayColor] retain];
	}
	repostSourceLayout = [[TweetLayout alloc]initWithFrame:CGRectZero 
													   doc:self];
	repostSourceLayout.font = defaultRepostSourceFont;
	repostSourceLayout.textColor = defaultRepostTextColor;
	repostSourceNode = [repostSourceLayout addNodeForText:nil];
	[self addLayout:repostSourceLayout];
	[repostSourceLayout release];
	
	//-------------repostComments
	if (!defaultRepostCommentsFont) {
		defaultRepostCommentsFont = [[UIFont systemFontOfSize:13] retain];
	}
	if (!defaultRepostCommentsLinkFont) {
		defaultRepostCommentsLinkFont = [[UIFont systemFontOfSize:13] retain];
	}
	if (!defaultRepostCommentsTextColor) {
		defaultRepostCommentsTextColor = [[UIColor lightGrayColor] retain];
	}
	if (!defaultRepostCommentsLinkTextColor) {
		defaultRepostCommentsLinkTextColor = [[UIColor colorWithWhite:0x69/255.0F alpha:1] retain];
	}
	repostCommentsLayout = [[TweetLayout alloc]initWithFrame:CGRectZero 
														 doc:self];
	//repostCommentsLayout.horizontalAlign = LayoutHorizontalAlignRight;
	repostCommentsLayout.font = defaultRepostCommentsFont;
	repostCommentsLayout.linkFont = defaultRepostCommentsLinkFont;
	repostCommentsLayout.textColor = defaultRepostCommentsTextColor;
	repostCommentsLayout.linkTextColor = defaultRepostCommentsLinkTextColor;
	repostRetweetsLinkNode = [[repostCommentsLayout addNodeForLink:nil url:@"retweetForwards"] retain];

	//repostCommentsSplitTextNode = [repostCommentsLayout addNodeForText:@"  |  "];
	
    repostCommentsLinkNode = [[repostCommentsLayout addNodeForLink:nil url:@"retweetComments"] retain];
	[self addLayout:repostCommentsLayout];
	[repostCommentsLayout release];
	
	//-------------sourceLayout
	if (!defaultSourceFont) {
		defaultSourceFont = [[UIFont systemFontOfSize:13] retain];
	}
	if (!defaultSourceTextColor) {
		defaultSourceTextColor = [[UIColor lightGrayColor] retain];
	}
	sourceLayout = [[TweetLayout alloc]initWithFrame:CGRectZero 
												 doc:self];
	sourceLayout.font = defaultSourceFont;
	sourceLayout.textColor = defaultSourceTextColor;
	sourceNode = [sourceLayout addNodeForText:nil];
	[self addLayout:sourceLayout];
	[sourceLayout release];
	
	//-------------repostComments
	if (!defaultCommentsFont) {
		defaultCommentsFont = [[UIFont systemFontOfSize:13] retain];
	}
	if (!defaultCommentsLinkFont) {
		defaultCommentsLinkFont = [[UIFont systemFontOfSize:13] retain];
	}
	if (!defaultCommentsTextColor) {
		defaultCommentsTextColor = [[UIColor lightGrayColor] retain];
	}
	if (!defaultCommentsLinkTextColor) {
		defaultCommentsLinkTextColor = [[UIColor colorWithWhite:0x69/255.0F alpha:1] retain];
	}
	commentsLayout = [[TweetLayout alloc]initWithFrame:CGRectZero 
														 doc:self];
	commentsLayout.horizontalAlign = LayoutHorizontalAlignRight;
	commentsLayout.font = defaultCommentsFont;
	commentsLayout.linkFont = defaultCommentsLinkFont;
	commentsLayout.textColor = defaultCommentsTextColor;
	commentsLayout.linkTextColor = defaultCommentsLinkTextColor;
	retweetsLinkNode = [[commentsLayout addNodeForLink:nil url:@"forwards"] retain];
    
	commentsSplitTextNode = [commentsLayout addNodeForText:@"  |  "];
    
	commentsLinkNode = [[commentsLayout addNodeForLink:nil url:@"comments"] retain];
	[self addLayout:commentsLayout];
	[commentsLayout release];
	
	//-------------image
	CGFloat imageTop = retweetLayout.frame.origin.y + retweetLayout.frame.size.height + 10;
	imageLayout = [[TweetLayout alloc]initWithFrame:CGRectMake(profileImageCellWidth, imageTop, docWidth - profileImageCellWidth, 84)
												doc:self];
    //dave edit
	[self addLayout:imageLayout];
	[imageLayout release];
	
	imageNode = [imageLayout addNodeForImageLink:@"image" imageUrl:nil width:kPhotoWidth height:kPhotoWidth];
	imageNode.className = @"tweetImageSmall"; 
     
	//NSLog(@"%@",[NSString stringWithFormat:@"statusId:%lld",status.statusId]);
	if (!defaultTweetImage) {
		//defaultTweetImage = [[UIImage imageNamed:@"TweetImageloading.png"]retain];
        
        defaultTweetImage = [[UIImage imageNamed:@"wall_default_image.png"]retain];
	}
	imageNode.defaultImage = defaultTweetImage;
    
    
    
  

}


//- (void)setStatus:(Status *)newStatus {
//	
//	if (status != newStatus) {
//		[status release];
//		status = [newStatus retain];
//		if (status != nil) {
//			[self initContentWithStatus];
//			[self initSizeWithWidth];
//		}
//		[self setNeedsLayout];
//	}
//	
//}
-(void)setWeiBoModel:(WeiBoModel *)newWeiBoModel
{
    //NSLog(@".............>setWeiBoModel");
	if (weiBoModel != newWeiBoModel) {
		[weiBoModel release];
		weiBoModel = [newWeiBoModel retain];
		if (weiBoModel != nil) {
			[self initContentWithStatus];
			//[self initSizeWithWidth];
            [self initSizeWithWidthandStyle];
		}
		[self setNeedsLayout];
	}

}
- (void)setStatus:(WeiBoModel *)newStatus {
	//NSLog(@".............>setStatus");
	if (weiBoModel != newStatus) {
		[weiBoModel release];
		weiBoModel = [newStatus retain];
		if (weiBoModel != nil) {
			[self initContentWithStatus];
			//[self initSizeWithWidth];
             [self initSizeWithWidthandStyle];
		}
		[self setNeedsLayout];
	}
	
}


- (void)setDocWidth:(CGFloat)newWidth {
	if (docWidth != newWidth) {
		docWidth = newWidth;
		//[self initSizeWithWidth];
         [self initSizeWithWidthandStyle];
		[self setNeedsLayout];
	}
}

- (void)refresh {
   // [self initWithWeiBoModel:weiBoModel width:docWidth]
	
	//[self refreshComments];
    //[self initSizeWithWidth];
    //[self initContentWithStatus];
    [self refreshTimestamp];
    [self refreshComments];
	[self setNeedsDisplay];
    
}

- (void)refreshTimestamp {
	if (weiBoModel) {
        if (![weiBoModel.mId isEqualToString:@""]) {
            timestampNode.text = weiBoModel.timestamp;
        }
		[timestampLayout setNeedsLayout];
		[timestampNode setNeedsDisplay];
	}
}


//- (void)refreshComments {
//	if (status) {
//		if (status.commentsCount >= 0) {
//			NSString *retweetsCountText = status.retweetsCount > 0 ? [NSString stringWithFormat:@"转发(%d)", status.retweetsCount] : @"转发";
//			NSString *commentsCountText = status.commentsCount > 0 ? [NSString stringWithFormat:@"评论(%d)", status.commentsCount] : @"评论";
//			commentsLinkNode.text = commentsCountText;
//			commentsLinkNode.url = [NSString stringWithFormat:@"comment:%lld",status.statusId];
//			retweetsLinkNode.text = retweetsCountText;
//			retweetsLinkNode.url = [NSString stringWithFormat:@"retweet:%lld",status.statusId];
//			commentsSplitTextNode.text = @"  |  ";
//		}
//		else {
//			commentsSplitTextNode.text = @"";
//		}
//		[commentsLayout setNeedsLayout];
//		[commentsLinkNode setNeedsDisplay];
//		[retweetsLinkNode setNeedsDisplay];
//		
//		if (status.retweetedStatus) {
//			if (status.retweetedStatus.commentsCount >= 0) {
//				NSString *retweetedStatusRetweetsCountText = status.retweetedStatus.retweetsCount > 0 ? [NSString stringWithFormat:@"原文转发(%d)", status.retweetedStatus.retweetsCount] : @"原文转发";
//				NSString *retweetedStatusCommentsCountText = status.retweetedStatus.commentsCount > 0 ? [NSString stringWithFormat:@"原文评论(%d)", status.retweetedStatus.commentsCount] : @"原文评论";
//				repostCommentsLinkNode.text = retweetedStatusCommentsCountText;
//				repostCommentsLinkNode.url = [NSString stringWithFormat:@"repostcomment:%lld",status.statusId];
//				repostRetweetsLinkNode.text = retweetedStatusRetweetsCountText;
//				repostRetweetsLinkNode.url = [NSString stringWithFormat:@"repostretweet:%lld",status.statusId];
//				repostCommentsSplitTextNode.text = @"  |  ";
//			}
//			else {
//				repostCommentsSplitTextNode.text = @"";
//			}
//			[repostCommentsLayout setNeedsLayout];
//			[repostCommentsLinkNode setNeedsDisplay];
//			[repostRetweetsLinkNode setNeedsDisplay];
//		}
//	}
//}
//
- (void)refreshComments {
	if (weiBoModel) {
		if ([weiBoModel.total intValue] >= 0) {
			NSString *retweetsCountText = [weiBoModel._trans intValue] > 0 ? [NSString stringWithFormat:@"转发(%d)", [weiBoModel._trans intValue]] : @"转发";
			NSString *commentsCountText = [weiBoModel.total intValue] > 0 ? [NSString stringWithFormat:@"评论(%d)", [weiBoModel.total intValue]]:@"评论";
			commentsLinkNode.text = commentsCountText;
			commentsLinkNode.url = [NSString stringWithFormat:@"comment:%lld",weiBoModel.statusId];
			retweetsLinkNode.text = retweetsCountText;
			retweetsLinkNode.url = [NSString stringWithFormat:@"retweet:%lld",weiBoModel.statusId];
			commentsSplitTextNode.text = @"  |  ";
		}
		else {
			commentsSplitTextNode.text = @"";
    	}
        
        
		[commentsLayout setNeedsLayout];
		[commentsLinkNode setNeedsDisplay];
		[retweetsLinkNode setNeedsDisplay];
        
        
 //       NSLog( @"commentsLayout.mContent = %@",weiBoModel.mContent);
   //     NSLog( @"commentsLayout.frame = %@",NSStringFromCGRect(commentsLayout.frame));
//	    CGRect r = commentsLayout.frame;
//        r.origin.x = docWidth/2-kPhotoWidth/2;  
//        r.origin.y = r.origin.y + 6; 
//        r.size.width = kPhotoWidth;
//        r.size.height = kPhotoHeight;
//        imageLayout.frame = r;
//        [imageLayout setNeedsLayout];
//        [imageNode setNeedsDisplay];
        
        
//		if (weiBoModel._isForm) {
//			if ([weiBoModel._fromTotal intValue] >= 0) {
//				NSString *retweetedStatusRetweetsCountText = [weiBoModel._fromTrans intValue] > 0 ? [NSString stringWithFormat:@"原文转发(%d)", [weiBoModel._fromTrans intValue]] : @"原文转发";
//				NSString *retweetedStatusCommentsCountText = [weiBoModel._fromTotal intValue] > 0 ? [NSString stringWithFormat:@"原文评论(%d)", [weiBoModel._fromTotal intValue]] : @"原文评论";
//				repostCommentsLinkNode.text = retweetedStatusCommentsCountText;
//				repostCommentsLinkNode.url = [NSString stringWithFormat:@"repostcomment:%lld",weiBoModel.statusId];
//				repostRetweetsLinkNode.text = retweetedStatusRetweetsCountText;
//				repostRetweetsLinkNode.url = [NSString stringWithFormat:@"repostretweet:%lld",weiBoModel.statusId];
//				repostCommentsSplitTextNode.text = @"  |  ";
//			}
//			else {
//				repostCommentsSplitTextNode.text = @"";
//			}
//			[repostCommentsLayout setNeedsLayout];
//			[repostCommentsLinkNode setNeedsDisplay];
//			[repostRetweetsLinkNode setNeedsDisplay];
//    
//	   }
    }
}

- (id)initWithWeiBoModel:(WeiBoModel*)_status width:(CGFloat)width_ {
	if (self = [self init]) {
		self.weiBoModel = _status;
		self.docWidth = width_;
		
		//[self initSizeWithWidth];
         [self initSizeWithWidthandStyle];
	}
	return self;
}


@end
