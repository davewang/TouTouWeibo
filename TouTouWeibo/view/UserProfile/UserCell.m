//
//  UserCell.m
//  ZhiWeibo
//
//  Created by junmin liu on 10-12-12.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "UserCell.h"

@interface UserCell (Private)

- (UIImage*)downloadImage;

@end

static UIImage *defaultProfileImage;

@implementation UserCell
@synthesize user;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier])) {
        // Initialization code
		downloader = [ImageDownloader downloaderWithName:@"profileImages"];
		if (!defaultProfileImage) {
			defaultProfileImage = [[UIImage imageNamed:@"ProfilePlaceholderOverWhite.png"] retain];
		}
		_receiver = [[ImageDownloadReceiver alloc] init];
		_receiver.imageContainer = self;
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}



- (void)dealloc {
	_receiver.imageContainer = nil;
    [downloader removeDelegate:_receiver forURL:user.headPhoto];
    [_receiver release];
	[user release];
	[profileImage release];
	[super dealloc];
}

- (void)setUser:(AccountInfo *)value {
	if (user != value) {
		if (user)
			[downloader removeDelegate:_receiver forURL:user.headPhoto];
		[user release];
		user = [value retain];
		[profileImage release];
		profileImage = [[self downloadImage] retain];
		if (profileImage == nil) {
			self.imageView.image = defaultProfileImage;
		}
		else {
			self.imageView.image = profileImage;
		}
		self.textLabel.text = user.attOfUserName;
		self.detailTextLabel.text = @"";
	}
}


- (UIImage*)processStyle:(UIImage*)_image {
	if (!_image) {
		return _image;
	}
	
	return [[TweetImageStyle sharedStyle] processWithClassName:@"profileImageMiddle"
													  forImage:_image];
}

- (UIImage *)getImageFromStyledImageCache {
	return [[TweetImageStyle sharedStyle]getImageFromCacheByClassName:@"profileImageMiddle"
															  withUrl:user.headPhoto];
}

- (UIImage*)downloadImage {
	
	if (nil != user && user.headPhoto && user.headPhoto.length > 0) {
		UIImage *cachedImage = [self getImageFromStyledImageCache];
		if (!cachedImage) {
			cachedImage = [downloader 
						   getImage:user.headPhoto delegate:_receiver];
			if (cachedImage) {
				//cachedImage = [self processStyle:cachedImage];
				TweetImageStyle *style = [TweetImageStyle sharedStyle];
				ImageCache *styleCache = [style getStyledImageCache:@"profileImageMiddle"];
				UIImage *styledImage = [styleCache imageForURL:user.headPhoto];
				if (styledImage) {
					cachedImage = styledImage;
				}
				else {
					cachedImage = [self processStyle:cachedImage];
					[styleCache storeImage:cachedImage forURL:user.headPhoto];
				}
			}
		}
		return cachedImage;
	} 
	return nil;
	
}


- (void)updateImage:(UIImage *)image sender:(ImageDownloadReceiver *)receiver {
	profileImage = [[self processStyle:image] retain];
	self.imageView.image = profileImage;
}



@end
