//
//  ImageDownloader.m
//  TweetViewDemo
//
//  Created by junmin liu on 10-10-14.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "ImageDownloader.h"
#import "ASIHTTPRequest.h"
#import "AppDelegate.h"

#define MAX_CONNECTION 1

static ImageDownloader*          gSharedDownloader = nil;
static NSMutableDictionary* gNamedDownloaders = nil;

@implementation ImageDownloader
@synthesize imageCache;

- (id)initWithImageCache:(ImageCache *)_imageCache
{
	if (self = [super init]) {
		imageCache    = _imageCache;
		pending   = [[NSMutableDictionary alloc] init];
		delegates = [[NSMutableDictionary alloc] init];
	}
    return self;
}

- (id)init {
	if (self = [self initWithImageCache:[ImageCache sharedCache]]) {
		
	}
	return self;
}

- (void)dealloc
{
    [delegates release];
    [pending release];
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (ImageDownloader*)downloaderWithName:(NSString*)name {
    
   // NSLog(@"name ------->%@",name);
	if (!gNamedDownloaders) {
		gNamedDownloaders = [[NSMutableDictionary alloc] init];
	}
	ImageDownloader* downloader = [gNamedDownloaders objectForKey:name];
	if (!downloader) {
		downloader = [[[ImageDownloader alloc] initWithImageCache:[ImageCache cacheWithName:name]] autorelease];
		if ([name isEqualToString:@"emoticons"]) {
			downloader.imageCache.disableImageCache = NO;
		}
		[gNamedDownloaders setObject:downloader forKey:name];
	}
	return downloader;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (ImageDownloader*)sharedDownloader {
	if (!gSharedDownloader) {
		gSharedDownloader = [[ImageDownloader alloc] init];
	}
	return gSharedDownloader;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)setSharedDownloader:(ImageDownloader*)downloader {
	if (gSharedDownloader != downloader) {
		[gSharedDownloader release];
		gSharedDownloader = [downloader retain];
	}
}

- (NSData*)getImageData:(NSString*)url {
	if (url == nil || !url || [url length] == 0) {
		return nil;
	}
	return [imageCache imageDataForURL:url];
} 

- (UIImage*)getImage:(NSString*)url delegate:(id)delegate
{
	if (url == nil || !url || [url length] == 0) {
		return nil;
	}
    
    UIImage *image = [imageCache imageForURL:url];
    if (image) {
        return image;
    }
  //  NSLog(@"0. image url: %@", url);
    ASIHTTPRequest *request = [pending objectForKey:url];
    if (request == nil || request.complete) {
		NSURL *uri = [NSURL URLWithString:url];
		if (!uri || uri == nil) {
			return nil;
		}
		
       // NSLog(@"1. image url: %@", url);
        request = [ASIHTTPRequest requestWithURL:uri];
		if (delegate 
			&& [delegate respondsToSelector:@selector(setMax:)]
			&& [delegate respondsToSelector:@selector(setProgress:)]) {
			[request setDownloadProgressDelegate:delegate];
		}
		[request setDelegate:self];
        [pending setObject:request forKey:url];
    }
	
	BOOL delegateExists = NO;
    NSMutableArray *arr = [delegates objectForKey:url];
    if (arr) {
		for (id del in arr) {
			if (del == delegate) {
				delegateExists = YES;
				break;
			}
		}
		if (!delegateExists) {
			[arr addObject:delegate];
		}
    }
    else {
        [delegates setObject:[NSMutableArray arrayWithObject:delegate] forKey:url];
    }
	//davewang
//    if ([pending count] <= MAX_CONNECTION) {
//		if (!request.inProgress) {
//			[request startAsynchronous];
//			[AppDelegate increaseNetworkActivityIndicator];
//		}
//    }
	
    
    return nil;
}


- (void)getPendingImage:(ASIHTTPRequest*)sender
{
	NSString *url = [sender.url absoluteString];
	if (url == nil || !url) {
		return;
	}
    [pending removeObjectForKey:url]; 
    
    NSArray *keys = [pending allKeys];
    
    for (NSString *url in keys) {
        ASIHTTPRequest *request = [pending objectForKey:url];
        if (request.inProgress) {
			continue;
		}
        NSMutableArray *arr = [delegates objectForKey:url];
        if (arr == nil) {
            [pending removeObjectForKey:url];
        }
        else if ([arr count] == 0) {
            [delegates removeObjectForKey:url];
            [pending removeObjectForKey:url];
        }
        else {
            [request startAsynchronous];
			//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
			[AppDelegate increaseNetworkActivityIndicator];
			break;
        }
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"requestFinished ---------->%@",request);
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[AppDelegate decreaseNetworkActivityIndicator];
	// Use when fetching binary data
	NSData *responseData = [request responseData];
	UIImage *image = [UIImage imageWithData:responseData];
    
    if (image && [image isKindOfClass:[UIImage class]]) {
		NSString *url = [request.url absoluteString];        
        [imageCache storeData:responseData forURL:url];
        NSMutableArray *arr = [delegates objectForKey:url];
        if (arr) {
            for (id delegate in arr) {
                if (delegate && [delegate respondsToSelector:@selector(imageDidDownload:)]) {
                    [delegate performSelector:@selector(imageDidDownload:) withObject:image];
                }
				if (delegate && [delegate respondsToSelector:@selector(imageDidDownloadWithData:)]) {
                    [delegate performSelector:@selector(imageDidDownloadWithData:) withObject:responseData];
                }
            }
            [delegates removeObjectForKey:url];
        }
    }
    
   [self getPendingImage:request];
	
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[AppDelegate decreaseNetworkActivityIndicator];
	NSError *error = [request error];
	NSString *url = [request.url absoluteString];
	NSMutableArray *arr = [delegates objectForKey:url];
	if (arr) {
		for (id delegate in arr) {
			if (delegate && [delegate respondsToSelector:@selector(imageDownloadFailed:)]) {
				[delegate performSelector:@selector(imageDownloadFailed:) withObject:error];
			}
		}
		[delegates removeObjectForKey:url];
	}
	
	[self getPendingImage:request];
}

- (void)removeDelegate:(id)delegate forURL:(NSString*)url
{
    NSMutableArray *arr = [delegates objectForKey:url];
    if (arr) {
        [arr removeObject:delegate];
        if ([arr count] == 0) {
            [delegates removeObjectForKey:url];
        }
    }
}


@end
