//
//  SayHelloViewController.h
//  TouTouWeibo
//
//  Created by 张 林 on 12-5-24.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ShakeListBean.h"
#import "ContactCell.h"
#import "ShakeBean.h"
@interface SayHelloViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * countArray;
    ContactCell * myCell;
    
}
@property (nonatomic,retain) IBOutlet UITableView * _tableView;
@property (nonatomic,retain) NSArray * countArray;
@end
