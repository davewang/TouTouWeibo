//
//  ComposeViewController.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-11-23.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "ComposeViewController.h"
#import "UIDevice-hardware.h"
#import "Reachability2.h"
#import "DianmingUIViewController.h"
#import "SinoNetMBProgressHUD.h"
//#import "FriendCache.h"

static inline double radians(double degrees) {
    return degrees * M_PI / 180;
}

@implementation ComposeViewController
@synthesize closeButton, sendButton, titleItem;
@synthesize navigationBar, maskView, alertBackgroundView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
 UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
 UIViewAutoresizingFlexibleWidth        = 1 << 1,
 UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
 UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
 UIViewAutoresizingFlexibleHeight       = 1 << 4,
 UIViewAutoresizingFlexibleBottomMargin = 1 << 5
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//[FriendCache loadFromLocal];
	//self.titleItem.title = @"新微博";
    [navigationBar   setNeedsDisplay1];
//    
//    UILabel *titleView = (UILabel *)navigationBar.topItem.titleView;
//    if (!titleView) {
//        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
//        titleView.text = @"发布微博";
//        titleView.textColor = NAV_TITLE_COLOR;
//        titleView.backgroundColor = [UIColor clearColor];
//        titleView.textAlignment = UITextAlignmentCenter;
//        
//        
//        titleView.font = [UIFont systemFontOfSize:NAV_TITLE_SIZE]; 
//        [titleView setHighlighted:YES];
//        navigationBar.topItem.titleView = titleView;
//        [titleView release];
//    }else{
//        titleView.text = @"发布微博";
//    }
//    [titleView sizeToFit];
//    [self setViewControllerTitle:@"发布微博"];
    [self setViewControllerTitle:@"发布微博" withNavigationItem:navigationBar.topItem];
	if (!composeView) {
		CGRect composeViewFrame = CGRectMake(0, self.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationBar.frame.size.height);
		composeView = [[ComposeView alloc]initWithFrame:composeViewFrame];
		composeView.composeViewController = self;
		composeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth
		| UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin
		| UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
	}
	[self.view insertSubview:composeView atIndex:1];
    
     closeButton =  [self leftBtnWithNavigationItem:navigationBar.topItem withTitle:@"取消" andAction:@selector(closeButtonTouch:)];
	
     sendButton =  [self rightBtnWithNavigationItem:navigationBar.topItem withTitle:@"发布" andAction:@selector(sendButtonTouch:)];
	//alertBackgroundView.image = [UIImage imageNamed:@"alertView-bg.png"];
}

- (void)viewWillAppear:(BOOL)animated {
	[composeView checkTextView];
	composeView.canResponseEmotion = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	composeView.canResponseEmotion = NO;
	[super viewWillDisappear:animated];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return NO;
	//return YES;
}

//
- (void)postNewStatus:(Draft *)draft
{
    
//	WeiboClient *client = [[WeiboClient alloc] initWithTarget:self 
//													   action:@selector(tweetDidSucceed:obj:)];
//	client.context = [draft retain];
	draft.draftStatus = DraftStatusSending;
	draft.clientCount++;
	if (draft.attachmentImage) {
		//[client upload:draft.attachmentData status:draft.text latitude:draft.latitude longitude:draft.longitude];
          [CommonUtils sendWeiBoWithMseg:draft.text WithDianming:composeView.dianming WithFlieNameData:draft.attachmentData WithGroup:composeView.groupIds WithIsSee:composeView.isSee];
	}
	else {
		//[client post:draft.text latitude:draft.latitude longitude:draft.longitude];
        NSLog(@"draft.text = %@",draft.text);
       // [CommonUtils sendWeiBoWithMseg:draft.text WithDianming:composeView.dianming WithFlieNameData:nil WithGroup:nil ];
         [CommonUtils sendWeiBoWithMseg:draft.text WithDianming:composeView.dianming WithFlieNameData:nil WithGroup:composeView.groupIds WithIsSee:composeView.isSee];
	}
   //  [CommonUtils ShowWaitingView:NO];
    //[SinoNetMBProgressHUD hideHUDForView: composeView animated:YES];
    [self endCompress];
}

- (void)retweetOrComment:(Draft *)draft {
	if (draft.retweet) { 
//		WeiboClient *retweetClient = [[WeiboClient alloc] initWithTarget:self 
//														   action:@selector(retweetDidSucceed:obj:)];
//		retweetClient.context = [draft retain];
//		if (draft.draftType == DraftTypeReplyComment 
//			&& draft.replyToComment
//			&& draft.text.length < 140 - draft.replyToStatus.user.screenName.length - 4) {
//			draft.text = [NSString stringWithFormat:@"%@ //@%@:%@", draft.text, draft.replyToStatus.user.screenName, draft.replyToStatus.text];
//			if (draft.text.length > 140) {
//				draft.text = [draft.text substringToIndex:140];
//			}
//		}
		draft.draftStatus = DraftStatusSending;
		draft.clientCount++;
        
        [CommonUtils RetweetWeiboWithAtWeiboId:draft.replyToStatus.mId andMesg:draft.text];
		//[retweetClient repost:draft.replyToStatus.statusId tweet:draft.text isComment:draft.comment];	
       // [CommonUtils ReplyWeiboWithWeiBoId:<#(NSString *)#> andContext:<#(NSString *)#>]
	}
	else if (draft.comment) {
//		WeiboClient *commentClient = [[WeiboClient alloc] initWithTarget:self 
//																  action:@selector(commentDidSucceed:obj:)];
//		commentClient.context = [draft retain];
		draft.draftStatus = DraftStatusSending;
		draft.clientCount++;
//		long long commentId = draft.replyToComment ? draft.replyToComment.commentId : -1;
//		[commentClient comment:draft.replyToStatus.statusId 
//					 commentId:commentId
//					   comment:draft.text];		
        [CommonUtils ReplyWeiboWithWeiBoId:draft.replyToStatus.mId andContext:draft.text];
	}
//	if (draft.replyToStatus.retweetedStatus 
//		&& draft.commentToOriginalStatus) { // 同时原文评论
//		WeiboClient *commentToOriginalClient = [[WeiboClient alloc] initWithTarget:self 
//																			action:@selector(commentToOriginalDidSucceed:obj:)];
//		commentToOriginalClient.context = [draft retain];
//		draft.draftStatus = DraftStatusSending;
//		draft.clientCount++;
//		[commentToOriginalClient comment:draft.replyToStatus.retweetedStatus.statusId 
//							   commentId:-1 
//								 comment:[NSString stringWithFormat:@"%@.", draft.text]];
//	}
	//save draft;
	//[draft updateDB];
	//[draft save];
}
//
//- (void)draftPostCompleted:(Draft *)sentDraft {
//	if (sentDraft.clientCount == 0) {
//		if (sentDraft.failedClientCount > 0) {
//			//save draft;
//			[sentDraft save];
//			NSLog(@"%@", @"save draft");
//		}
//		else {
//			//delete draft;
//			[sentDraft delete];
//			NSLog(@"%@", @"delete draft");
//		}
//		[[sentDraft retain] autorelease];
//		[[NSNotificationCenter defaultCenter] postNotificationName:@"draftPostCompleted" 
//															object:sentDraft];
//	}	
//}
//
//- (void)commentDidSucceed:(WeiboClient*)sender obj:(NSObject*)obj;
//{
//	Draft *sentDraft = (Draft *)sender.context;
//	
//	sentDraft.clientCount--;   
//    if (sender.hasError) {
//        [sender alert];
//		sentDraft.draftStatus = DraftStatusSentFailt;
//		sentDraft.failedClientCount++;
//		[self draftPostCompleted:sentDraft];
//		[sender release];
//		[sentDraft release];
//        return;
//    }
//	sentDraft.comment = NO;
//    NSDictionary *dic = nil;
//    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
//        dic = (NSDictionary*)obj;    
//    }
//	
//    if (dic) {
//        Comment* comment = [Comment commentWithJsonDictionary:dic];
//		NSLog(@"comment id:%lld", comment.commentId);
//		if (comment && comment.commentId > 0) {
//			//delete draft!
//			if (sentDraft) {
//				//[sentDraft deleteFromDB];
//				[sentDraft delete];
//			}
//		}
//    }
//	[self draftPostCompleted:sentDraft];	
//	[sender release];
//	[sentDraft release];
//}
//
//
//- (void)tweetDidSucceed:(WeiboClient*)sender obj:(NSObject*)obj;
//{
//	Draft *sentDraft = (Draft *)sender.context;
//	
//    sentDraft.clientCount--;
//    if (sender.hasError) {
//        [sender alert];
//		sentDraft.draftStatus = DraftStatusSentFailt;
//		sentDraft.failedClientCount++;
// 		[self draftPostCompleted:sentDraft];
//		[sender release];
//		[sentDraft release];
//      return;
//    }
//	
//    NSDictionary *dic = nil;
//    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
//        dic = (NSDictionary*)obj;    
//    }
//	
//    if (dic) {
//        Status* sts = [Status statusWithJsonDictionary:dic];
//		NSLog(@"sts id:%lld", sts.statusId);
//		if (sts && sts.statusId > 0) {
//			//delete draft!
//			if (sentDraft) {
//				//[sentDraft deleteFromDB];
//				[sentDraft delete];
//			}
//			[[ZhiWeiboAppDelegate getAppDelegate]refresh];
//		}
//    }
//	[self draftPostCompleted:sentDraft];
//	[sender release];
//	[sentDraft release];
//}
//
//- (void)retweetDidSucceed:(WeiboClient*)sender obj:(NSObject*)obj;
//{
//	Draft *sentDraft = (Draft *)sender.context;
//	if (!sender.hasError) {
//		sentDraft.retweet = NO;
//	}
//	[self tweetDidSucceed:sender obj:obj];
//}
//
//
//- (void)commentToOriginalDidSucceed:(WeiboClient*)sender obj:(NSObject*)obj;
//{
//	Draft *sentDraft = (Draft *)sender.context;
//	if (!sender.hasError) {
//		sentDraft.commentToOriginalStatus = NO;
//	}
//	[self commentDidSucceed:sender obj:obj];
//}

- (void)close {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)closeButtonTouch:(id)sender {
	[composeView close];
    [self close];
}

- (IBAction)sendButtonTouch:(id)sender {
	Draft *draft = [composeView getDraft];
	if (!draft || draft.text.length == 0) {
		return;
	}
//	if (draft.draftType == DraftTypeNewTweet) {
//		[self postNewStatus:draft];
//	}
//	else {
//		[self retweetOrComment:draft];
//	}
     
   // [self postNewStatus:draft];
    
//   SinoNetMBProgressHUD *hub = [SinoNetMBProgressHUD showHUDAddedTo:composeView animated:YES ];
//    hub.labelText = @"发送中...";
//    [hub show:YES];
    if (draft.draftType == DraftTypeNewTweet) {
        maskLable.text =@"微博发布中...";
        [self beginCompress]; 
        [self postNewStatus:draft];
    }else{
        [self retweetOrComment:draft];
    
    }
  
   // [self performSelectorOnMainThread:@selector(postNewStatus: ) withObject:draft waitUntilDone:YES];
    //[self performSelector:@selector(postNewStatus:) withObject:draft afterDelay:0.3];
	[composeView clear];
	[composeView close];
	[self close]; 
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[composeView release];
    [super dealloc];
}

- (void)composeNewTweet {	 
    
    [self setViewControllerTitle:@"发布微博" withNavigationItem:navigationBar.topItem];
    Draft *_draft = [[Draft alloc]initWithType:DraftTypeNewTweet];
	composeView.draft = _draft;
    [_draft release];
    
//	Draft *_draft = [[Draft alloc]initWithType:DraftTypeNewTweet];
//	titleItem.title = @"新微博";
//	composeView.draft = _draft;
//	[_draft release];
//	[_draft save];
}
//
- (void)replyTweet:(WeiBoModel *)status //comment:(Comment *)comment 
{
	Draft *_draft = [[Draft alloc]initWithType:DraftTypeReplyComment];
	_draft.replyToStatus = status;
	//_draft.replyToComment = comment;
	_draft.comment = YES;
	//titleItem.title = @"发回复";
    [composeView gotoShowKeyboard];
    [self setViewControllerTitle:@"发回复" withNavigationItem:navigationBar.topItem];
	composeView.draft = _draft;
	[_draft release];	
	//[_draft save];
}

- (void)retweet:(WeiBoModel*)status {
	Draft *_draft = [[Draft alloc]initWithType:DraftTypeReTweet];
	_draft.replyToStatus = status;
	_draft.retweet = YES;
    
    [self setViewControllerTitle:@"转发微博" withNavigationItem:navigationBar.topItem];
	//titleItem.title = @"转发微博";
    //[self setViewControllerTitle:@"转发微博"];
    [composeView gotoShowKeyboard];
	composeView.draft = _draft;
	[_draft release];
	//[_draft save];
}
//
//- (void)advise {
//	Draft *_draft = [[Draft alloc]initWithType:DraftTypeNewTweet];
//	_draft.text = [NSString stringWithFormat:@"#智微博意见反馈# @智微博 #OS Version:%@# ",[UIDevice currentDevice].systemVersion];
//	titleItem.title = @"意见反馈";
//	[composeView loadDraft:_draft];
//	[_draft release];
//	[_draft save];
//}

- (void)enableSendButton:(BOOL)enabled {
	sendButton.enabled = enabled;
}

- (void)beginCompress {
	maskView.hidden = NO;
}

- (void)endCompress {
	maskView.hidden = YES;
}

- (UIImage *)fixImageOrientation:(UIImage *)img {
    CGSize size = [img size];
	
    UIImageOrientation imageOrientation = [img imageOrientation];
	
    if (imageOrientation == UIImageOrientationUp)
        return img;
	
    CGImageRef imageRef = [img CGImage];
    CGContextRef bitmap = CGBitmapContextCreate(
												NULL,
												size.width,
												size.height,
												CGImageGetBitsPerComponent(imageRef),
												4 * size.width,
												CGImageGetColorSpace(imageRef),
												CGImageGetBitmapInfo(imageRef));
	
    CGContextTranslateCTM(bitmap, size.width, size.height);
	
    switch (imageOrientation) {
        case UIImageOrientationDown:
            // rotate 180 degees CCW
            CGContextRotateCTM(bitmap, radians(180.));
            break;
        case UIImageOrientationLeft:
            // rotate 90 degrees CW
            CGContextRotateCTM(bitmap, radians(-90.));
            break;
        case UIImageOrientationRight:
            // rotate 90 degrees5 CCW
            CGContextRotateCTM(bitmap, radians(90.));
            break;
        default:
            break;
    }
	
    CGContextDrawImage(bitmap, CGRectMake(0, 0, size.width, size.height), imageRef);
	
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    CGContextRelease(bitmap);
    UIImage *oimg = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
	
    return oimg;
}

- (UIImage *)resizeImage:(UIImage *)original toSize:(MediaResize)resize {
	CGSize smallSize, mediumSize, largeSize, originalSize;
	UIImageOrientation orientation = original.imageOrientation; 
 	switch (orientation) { 
		case UIImageOrientationUp: 
		case UIImageOrientationUpMirrored:
		case UIImageOrientationDown: 
		case UIImageOrientationDownMirrored:
			smallSize = CGSizeMake(480, 320);
			mediumSize = CGSizeMake(960, 640);
			largeSize = CGSizeMake(1600, 1066);
			if([[UIDevice currentDevice] platformString] == IPHONE_4G_NAMESTRING)
				originalSize = CGSizeMake(2592, 1936);
			else if([[UIDevice currentDevice] platformString] == IPHONE_3GS_NAMESTRING)
				originalSize = CGSizeMake(2048, 1536);
			else
				originalSize = CGSizeMake(1600, 1200);
			break;
		case UIImageOrientationLeft:
		case UIImageOrientationLeftMirrored:
		case UIImageOrientationRight:
		case UIImageOrientationRightMirrored:
			smallSize = CGSizeMake(320, 480);
			mediumSize = CGSizeMake(640, 960);
			largeSize = CGSizeMake(1066, 1600);
			if([[UIDevice currentDevice] platformString] == IPHONE_4G_NAMESTRING)
				originalSize = CGSizeMake(1936, 2592);
			else if([[UIDevice currentDevice] platformString] == IPHONE_3GS_NAMESTRING)
				originalSize = CGSizeMake(1536, 2048);
			else
				originalSize = CGSizeMake(1200, 1600);
	}
	
	// Resize the image using the selected dimensions
	UIImage *resizedImage = original;
	switch (resize) {
		case kResizeSmall:
			resizedImage = [original resizedImageWithContentMode:UIViewContentModeScaleAspectFill 
														  bounds:smallSize 
											interpolationQuality:kCGInterpolationHigh];
			break;
		case kResizeMedium:
			resizedImage = [original resizedImageWithContentMode:UIViewContentModeScaleAspectFill 
														  bounds:mediumSize 
											interpolationQuality:kCGInterpolationHigh];
			break;
		case kResizeLarge:
			resizedImage = [original resizedImageWithContentMode:UIViewContentModeScaleAspectFill 
														  bounds:largeSize 
											interpolationQuality:kCGInterpolationHigh];
			break;
		case kResizeOriginal:
			resizedImage = [original resizedImageWithContentMode:UIViewContentModeScaleAspectFill 
														  bounds:originalSize 
											interpolationQuality:kCGInterpolationHigh];
			break;
	}
	return resizedImage;
}


- (void)showImagePicker:(BOOL)hasCamera
{
    UIImagePickerController *picker = [[[UIImagePickerController alloc] init] autorelease];
    //picker.composeView = self;
    picker.delegate = self;
    if (hasCamera) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentModalViewController:picker animated:YES];
}


- (void)showUserNamesSearchViewController {
	//[self presentModalViewController:userNamesSearchViewController animated:YES];
    
    DianmingUIViewController *dianming = [[DianmingUIViewController alloc] init];
    dianming.dianMingdelegate = self;
    dianming.dianmingType = DianMingTypeUserName;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dianming ];
    [dianming release];
    [self presentModalViewController:nav animated:YES];
    [nav release];
}

- (void)showTrendSearchViewController {
	//[self presentModalViewController:trendSearchViewController animated:YES];
     DianmingUIViewController *dianming = [[DianmingUIViewController alloc] init];
    dianming.dianMingdelegate = self;
    dianming.dianmingType = DianMingTypeGroupId;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dianming ];
    [dianming release];
    [self presentModalViewController:nav animated:YES];
    [nav release];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // do nothing here
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
	[self performSelectorInBackground:@selector(compressImageInBackground:) 
						   withObject:image];
	
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
	
    [self dismissModalViewControllerAnimated:true];
    maskLable.text =@"图片压缩中";
	[self beginCompress];
}


- (void) compressImageInBackground:(UIImage *)image {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	int size = kResizeMedium;
	
	NetworkStatus connectionStatus = [[Reachability2 sharedReachability] internetConnectionStatus];
	if (connectionStatus == ReachableViaWiFiNetwork) { //WIFI 大图
		size = kResizeLarge;
	}	else {
		size = kResizeMedium;
	}
	 

	UIImage *postImage = [self resizeImage:image toSize:size];
	/*
	CGFloat maxSize = 768;
	if ((maxSize < image.size.width || maxSize < image.size.height) ||
		image.imageOrientation != UIImageOrientationUp)
		postImage = [image imageScaledToSizeWithSameAspectRatio:CGSizeMake(maxSize, maxSize)];
	else {
		postImage = image;
	}
	 */
	
	[composeView setAttachmentImage:postImage];
    //[composeView setAttachmentImage:image];
    [self performSelectorOnMainThread:@selector(completeCompressingTask) withObject:nil waitUntilDone:YES];
    [pool release];
}

- (void) completeCompressingTask {
	[self endCompress];
    [composeView performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.1];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:true];
}
//
//- (void)loadDraft:(Draft *)_draft {
//	if(!_draft) return;
//	switch (_draft.draftType) {
//		case DraftTypeNewTweet:
//			titleItem.title = @"新微博";
//			break;
//		case DraftTypeReTweet:
//			titleItem.title = @"转发微博";
//			break;
//		case DraftTypeReplyComment:
//			titleItem.title = @"发评论";
//			break;
//		default:
//			break;
//	}
//	[composeView loadDraft:_draft];
//}

- (void)addTrend:(NSString *)trend {
	[composeView addTrend:trend];
}

- (void)addUserScreenName:(NSString *)userScreenName {
    [composeView clearContext];
	[composeView addUserScreenName:userScreenName];
}
-(void)isCoposeSee:(NSString *) see{
    NSRange r = [see rangeOfString:@"all"];
    if (r.location>0) {
        composeView.isSee = @"is";
    }else{
        composeView.isSee = @"no";
    }
    
    
}
-(void)addGroupIds:(NSString *)groupIds
{
    [self isCoposeSee:groupIds];
    NSMutableString *st = [[NSMutableString alloc] initWithCapacity:2];
    [st appendString:groupIds];
    [st replaceOccurrencesOfString:@"all," withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange (0, [st length]) ];
    
    NSLog(@"groupIds--%@",groupIds);
    
    NSLog(@"st--%@",st);
    
    composeView.groupIds =  st;
    [st release];
}


@end
