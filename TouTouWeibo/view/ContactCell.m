//
//  ContactCell.m
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-21.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell
@synthesize  name,className,mobileNumber,headImageView;

static UIImage *defaultProfileImage;

static UIImage *imgMale = nil;
static UIImage *imgFemale = nil;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"initWithStyle");
        
        if (!defaultProfileImage) {
            defaultProfileImage = [[UIImage imageNamed:@"ProfilePlaceholderOverWhite.png"] retain];
        }
        downloader = [ImageDownloader downloaderWithName:@"profileImages"];
        _receiver = [[ImageDownloadReceiver alloc] init];
        _receiver.imageContainer = self;
       
    }
    return self;
}
-(void)awakeFromNib{
    NSLog(@"initWithStyle");

    
    if (!defaultProfileImage) {
        defaultProfileImage = [[UIImage imageNamed:@"ProfilePlaceholderOverWhite.png"] retain];
    }
    downloader = [ImageDownloader downloaderWithName:@"profileImages"];
    _receiver = [[ImageDownloadReceiver alloc] init];
    _receiver.imageContainer = self;
    if (!imgMale) {
        imgMale = [[UIImage imageNamed:@"profile_genderM.png"]retain];
    }
    if (!imgFemale) {
        imgFemale = [[UIImage imageNamed:@"profile_genderW.png"]retain];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setSex:(NSString *)sex
{
    if ([sex intValue]==1) {
        sexImageView.image = imgMale;
    }else{
        
        sexImageView.image = imgFemale;
    }
    
}
-(void)setHeadUrl:(NSString*)_headUrl{
    headUrl = _headUrl;
    if ( profileImage) {
         [profileImage release];
    }
   
    profileImage = [[self downloadImage] retain];
    UIImage *image = profileImage;
    if (!image) {
        image = defaultProfileImage;
    }
    headImageView.image = image;

}

- (UIImage*)processStyle:(UIImage*)_image {
	if (!_image) {
		return _image;
	}
	
	return [[TweetImageStyle sharedStyle] processWithClassName:@"profileImageMiddle"
													  forImage:_image];
}

- (UIImage *)getImageFromStyledImageCache {
	return [[TweetImageStyle sharedStyle] getImageFromCacheByClassName:@"profileImageMiddle"
                                                               withUrl:headUrl];
}

- (UIImage*)downloadImage {
	
	if (headUrl && headUrl.length > 0) {
		UIImage *cachedImage = [self getImageFromStyledImageCache];
		if (!cachedImage) {
			cachedImage = [[ImageDownloader downloaderWithName:@"profileImages"] 
						   getImage:headUrl delegate:_receiver];
			if (cachedImage) {
				//cachedImage = [self processStyle:cachedImage];
				TweetImageStyle *style = [TweetImageStyle sharedStyle];
				ImageCache *styleCache = [style getStyledImageCache:@"profileImageMiddle"];
				UIImage *styledImage = [styleCache imageForURL:headUrl];
				if (styledImage) {
					cachedImage = styledImage;
				}
				else {
					cachedImage = [self processStyle:cachedImage];
					[styleCache storeImage:cachedImage forURL:headUrl];
				}
			}
		}
		return cachedImage;
	} 
	return nil;
	
}
@end
