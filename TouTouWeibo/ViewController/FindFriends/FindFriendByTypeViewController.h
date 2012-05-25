//
//  FindFriendByTypeViewController.h
//  TouTouWeibo
//
//  Created by BobbyLi on 5/9/12.
//  Copyright (c) 2012 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindFriendByTypeViewController : BaseUIViewController<UISearchBarDelegate>
{
    NSString *findType;
}
@property (nonatomic,retain) NSString *findType;

@end
