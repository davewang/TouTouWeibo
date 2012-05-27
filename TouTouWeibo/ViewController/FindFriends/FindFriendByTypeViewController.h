//
//  FindFriendByTypeViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-27.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

 

#import <UIKit/UIKit.h>

@interface FindFriendByTypeViewController : BaseUIViewController<UISearchBarDelegate>
{
    NSString *findType;
    IBOutlet UISearchBar *searchBar;
    NSString *currentSearchText;
} 
@property (nonatomic,retain) NSString *findType;
@property (nonatomic,retain) NSString *currentSearchText;

@end
