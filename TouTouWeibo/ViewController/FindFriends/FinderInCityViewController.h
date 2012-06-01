//
//  FinderInCityViewController.h
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundResultViewController.h"

@interface FinderInCityViewController : BaseUIViewController<MKReverseGeocoderDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>{

       UITableView *_tableView;
       NSArray *imageNames;
       NSMutableArray *_findFriendsVCList;
    CLLocationManager *locationManager;
    NSString * proviceName;
    NSString * cityName;
}

@property(retain,nonatomic) NSArray *_findFriendsVCList;
@property(retain,nonatomic)IBOutlet  UITableView *tableView;

@end


//
//#import <UIKit/UIKit.h>
//
//@interface FindFriendByTypeViewController : BaseUIViewController<UISearchBarDelegate>
//{
//    NSString *findType;
//} 
//@property (nonatomic,retain) NSString *findType;
//
//@end


//
//  FindFriendByTypeViewController.m
//  TouTouWeibo
//
//  Created by BobbyLi on 5/9/12.
//  Copyright (c) 2012 DaveDev. All rights reserved.
//
//
//#import "FindFriendByTypeViewController.h"
//#import "FoundResultViewController.h"
//@interface FindFriendByTypeViewController ()
//
//@end
//
//@implementation FindFriendByTypeViewController
//@synthesize findType;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) { 
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)initSearchArea {
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 5, 300,44)];
//    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
//    searchBar.delegate = self;
//    [self.view addSubview:searchBar];
//    [searchBar release];
//}
//
//- (void)setNavBar
//{
//    if ([findType isEqualToString:@"name"]) {
//        self.title=@"按名称查找";
//    }else if ([findType isEqualToString:@"class"]) {
//        self.title=@"按班级查找";
//    } else if ([findType isEqualToString:@"city"]) {
//        self.title=@"按城市查找";
//    }
//    [self setViewControllerTitle:self.title];
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];  
//	backButton.frame = CGRectMake(0.0, 0.0, 40.0, 27.0);  
//	[backButton setImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];  
//	[backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];  
//	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];  
//	temporaryBarButtonItem.style = UIBarButtonItemStylePlain;  
//	self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;  
//	[temporaryBarButtonItem release];
//}
//- (void)viewDidLoad
//{
//    
//    [super viewDidLoad];
//	// Do any additional setup after loading the view.
//    [self initSearchArea];
//    [self setNavBar];
//}
//
//- (void)backAction
//{  
//    [self.navigationController popViewControllerAnimated:YES];  
//}
//
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return NO;
//}
//
//
//#pragma mark
//#pragma mark searchbar datasource
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"type==%@",findType);
//    
//    FoundResultViewController *result= [[FoundResultViewController alloc]init];
//    self.hidesBottomBarWhenPushed = YES;
//    result.findType=findType;
//    NSArray *array=[[NSArray alloc]initWithObjects:@"景李军",@"张三",@"李四",@"王五",@"李四",@"王五",nil];
//    result._findFriendsList=array;
//    
//    [self.navigationController pushViewController:result animated:YES];
//    self.hidesBottomBarWhenPushed = NO;
//    [array release];
//    [result release];
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
//    
//    
//}
//
//@end
