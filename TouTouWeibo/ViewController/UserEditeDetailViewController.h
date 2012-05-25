//
//  UserEditeDetailViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-15.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
 
@protocol UserEditeDetailViewControllerDelegate<NSObject>
 
-(void)UserDidEdite:(NSString*)content;

@end

@interface UserEditeDetailViewController : BaseUIViewController 
{
    NSString *content;
    IBOutlet UITextView *texView;
    id<UserEditeDetailViewControllerDelegate> delegate;
}
@property(nonatomic,retain) NSString *content;
@property(nonatomic,assign) id<UserEditeDetailViewControllerDelegate> delegate;

@end
