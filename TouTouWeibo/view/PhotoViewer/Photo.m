//
//  Photo.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-11-5.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "Photo.h"


@implementation Photo
@synthesize URL, originalURL, caption, size, image, failed;

+ (Photo*)photoWithStatus:(WeiBoModel*)status {
	Photo *photo = [[[Photo alloc]init] autorelease];
//	if (status.retweetedStatus) {
//		status = status.retweetedStatus;
//	}
//	photo.URL = status.bmiddlePic;
//	photo.originalURL = status.originalPic;
    photo.URL = status.sharePhoto.sharePhotoSmallPath;
    photo.originalURL = status.sharePhoto.sharePhotoRealPath;
	return photo;
}

+ (Photo*)photoWithURL:(NSString*)url {
	Photo *photo = [[[Photo alloc]init] autorelease];
	photo.URL = url;
	photo.originalURL = url;
	return photo;
}

- (void)dealloc {
	[URL release];
	[originalURL release];
	[caption release];
	[image release];
	[super dealloc];
}

@end
