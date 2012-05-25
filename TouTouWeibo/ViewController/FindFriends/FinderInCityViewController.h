//
//  FinderInCityViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundResultViewController.h"

@interface FinderInCityViewController : BaseUIViewController<UITableViewDelegate,UITableViewDataSource>{

       UITableView *_tableView;
       NSArray *imageNames;
       NSMutableArray *_findFriendsVCList;
     
}

@property(retain,nonatomic) NSArray *_findFriendsVCList;
@property(retain,nonatomic)IBOutlet  UITableView *tableView;

@end
