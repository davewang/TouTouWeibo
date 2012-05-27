//
//  ShakeFrinedsViewController.m
//  TouTouWeibo
//
//  Created by oscar on 12-5-9.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "ShakeFrinedsViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ShakeFrinedsViewController
@synthesize drawer;
@synthesize upView,downView,shakeView,failLabel,activityView;
@synthesize locationView,activity2;
@synthesize shakeArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc
{
    [drawer release];
    [upView release];
    [downView release];
    [shakeView release];
    [failLabel release];
    [activityView release];
    [locationView release];
    [activity2 release];
    [super dealloc];
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"cityInfo is %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"cityInfo"]);
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 500;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    }
    else {
        UIAlertView * parseFailedAlertView = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:@"若使用摇一摇服务，请开启\"设置->定位服务\"中的相关选项" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [parseFailedAlertView show];
        [parseFailedAlertView release];
        locationState=NO;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"latitude is %f",[newLocation coordinate].latitude );
    NSLog(@"longitude is %f",[newLocation coordinate].longitude);
    [locationManager stopUpdatingLocation];
    NSString * lat = [NSString stringWithFormat:@"%f",[newLocation coordinate].latitude];
    NSString * log = [NSString stringWithFormat:@"%f",[newLocation coordinate].longitude];
    
    NSString * str =[CommonUtils saveShakePostionUserId:[GlobalInfo sharedGlobalInfo].userId WithLongitude:log WithLatitude:lat];
    NSLog(@"%@",str);
    
    locationView.hidden=YES;
    locationState=YES;
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"locate error with error info : %@",error);
    [locationManager stopUpdatingLocation];
    UIAlertView * parseFailedAlertView = [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"请开启\"设置->定位服务\"中的相关选项" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [parseFailedAlertView show];
    [parseFailedAlertView release];
    locationState=NO;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.navigationController.navigationBar setNeedsDisplay1];
    [super viewDidLoad]; 
    [self setViewControllerTitle:@"摇一摇"];   
    [self leftBackBtnWithAction:@selector(actionBack)];   
    UITableView *_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 380) style:UITableViewStylePlain];
    _tableView.tag=100;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    drawer = [[DrawerView alloc] initWithView:_tableView parentView:self.view];
    [self.view addSubview:drawer];
    
    
    UIButton * setBt = [UIButton buttonWithType:UIButtonTypeCustom];
    setBt.frame=CGRectMake(0, 0, 40, 30);
    [setBt setTitle:@"设置" forState:UIControlStateNormal];
    [setBt setImage:[CommonUtils stretchableImageFromName:@"navigationbar_button_background.png"] forState:UIControlStateNormal];
    [setBt addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:setBt];
    
    //控制导航的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavFrame:) name:@"KHIDENAV" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavFrame:) name:@"KSHOWNAV" object:nil];
    
    AccelerometerHelper * accelerometer = [AccelerometerHelper sharedInstance];
    accelerometer.delegate=self;
    
    shakeView.hidden=YES;
    failLabel.hidden=YES;
    [activityView startAnimating];
    [activity2 startAnimating];
}
-(void)set
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确认要清空历史记录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
    }else{
        //清空请求
        NSString * str = [CommonUtils deleteShakeHistoryUserId:[GlobalInfo sharedGlobalInfo].userId];
        NSLog(@"%@",str);
    }
}
-(void)changeNavFrame:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"KHIDENAV"]) {
        self.navigationController.navigationBarHidden=NO;
        
    }else if([notification.name isEqualToString:@"KSHOWNAV"]){
       self.navigationController.navigationBarHidden=YES; 
    }
}
-(void)shake
{
    failLabel.hidden=YES;
    if (locationState==YES) {
        locationView.hidden=YES;
        shakeView.hidden=NO;
        [UIView beginAnimations:@"shake" context:NULL];
        [UIView setAnimationDuration:0.8];
        upView.frame=CGRectMake(0, -70, 320, 146);
        downView.frame=CGRectMake(0, 146+70, 320, 270);
        [UIView commitAnimations];
        [self performSelector:@selector(shakePhone) withObject:nil afterDelay:0.5];
        
    }

}
-(void)shakePhone
{
    failLabel.hidden=YES;
    [UIView beginAnimations:@"shake" context:NULL];
    [UIView setAnimationDuration:0.8];
    upView.frame=CGRectMake(0, 0, 320, 146);
    downView.frame=CGRectMake(0, 146, 320, 270);
    [UIView commitAnimations];
    shakeView.hidden=NO;
    ;
    
    //发请求 获取数据
    
    ShakeListBean * shakeList=[CommonUtils loadShakePersonListBeanUserId:[GlobalInfo sharedGlobalInfo].userId];
    NSLog(@"%@",shakeList.shakeList);
    
    self.shakeArray = shakeList.shakeList;
    NSLog(@"%d",[shakeList.shakeList count]);
    NSLog(@"shake array =%d",[shakeArray count]);
    if ([shakeArray count]!=0) {
        UITableView * table = (UITableView *)[self.view viewWithTag:100];
        [table reloadData];
        [drawer shakeFinished];
    }else{
        failLabel.hidden=NO;
    }
    shakeView.hidden=YES;
}
-(void)addPerson
{
    ShakeListBean * shakeList2 = [CommonUtils shakeHistoryWithUserId:[GlobalInfo sharedGlobalInfo].userId];
    self.shakeArray=shakeList2.shakeList;
    UITableView * table = (UITableView *)[self.view viewWithTag:100];
    [table reloadData];
    
}



-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([shakeArray count]==0) {
        return nil;
    }else{
    UIButton * customeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    customeBt.backgroundColor=[UIColor grayColor];
    customeBt.frame=CGRectMake(0, 0, 320, 50);
    [customeBt setTitle:@"显示早前摇到的人" forState:UIControlStateNormal];
    [customeBt addTarget:self action:@selector(addPerson) forControlEvents:UIControlStateNormal];
    return customeBt;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shakeArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";  
    ContactCell * cell = (ContactCell*)[tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];  
    if (cell == nil)  
    {  
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactCell" owner:self options:nil] objectAtIndex:0];
    }  
        ShakeBean *bean = [shakeArray objectAtIndex:indexPath.row];
        cell.name.text = bean.userName;
    
    //    cell.className.text = bean.banji;
    //    cell.mobileNumber.text = bean.telphone;
       [cell setHeadUrl:bean.userPhoto];
    //    [cell setSex:bean.sex]; 
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //推出详情页
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

@end
