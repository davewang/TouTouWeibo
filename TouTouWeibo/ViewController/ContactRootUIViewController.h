//
//  ContactRootUIViewController.h
//  TouTouWeibo
//
//  Created by Wang Dave on 12-5-26.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactRootUIViewController : BaseUIViewController
{
    NSArray *data;
    
    NSArray *data2;
    IBOutlet UITableView *_tableView;
    NSArray *imageNames;
    NSArray *imageNames2;
}
@property(nonatomic,retain) UITableView *tableView;
@end
