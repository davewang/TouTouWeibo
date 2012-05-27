//
//  MapModeViewController.m
//  ChinaUMS
//
//  Created by 邵波 on 12-3-18.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import "MapModeViewController.h"
#import "ContactsUIViewController.h"
#import "FoundResultViewController.h"
@implementation MapModeViewController
@synthesize map;
@synthesize infromationArr;
@synthesize mapPinView;
@synthesize friendType;
@synthesize searchText;
@synthesize proviceName;
@synthesize cityName;
#define GOOGLEMAPURL @"https://maps.googleapis.com/maps/api/place/search/json?location=%@,%@&radius=%d&types=%@&sensor=false&key=AIzaSyDJ1phmkoBRxWvkP6WnMgnLJFyS4CCwhKE"

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
 
#pragma mark- Location

-(void)startLocation
{
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.delegate = self;
        locationManager.distanceFilter = 1000;
        [locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"connectForLocationWithdidFailWithError");
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
     
    
	 
	
//    lat = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
//    lon = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
//    if (lat!=nil && lat!=nil) {
//        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
//        region.center.latitude = [lat floatValue];
//        region.center.longitude = [lon floatValue];
//        region.span.latitudeDelta = 0.1f;
//        region.span.longitudeDelta = 0.1f;
//        [map setRegion:region animated:YES];
        
//        NSMutableArray * array = [[NSMutableArray alloc]init];
//        CLLocationCoordinate2D anno2;
//        anno2.latitude = [lat floatValue];
//        anno2.longitude = [lon floatValue];
//        MapAnnoData * twoAnno = [[MapAnnoData alloc]initWithCoodinate:anno2];
//        twoAnno.title = @"当前位置";
//        twoAnno.subtitle = @"Me";
       // twoAnno.image = @"image";
       // [array addObject:twoAnno];
       // [map addAnnotations:array];
       // [self connectForLocationWith:lat And:lon And:rad And:type];
         [self connectForLocation];
   // }
    //[self connectForLocationWith:lat And:lon And:rad And:type];
      
 //   [self connectForLocation];
    [locationManager stopUpdatingLocation];
}
 
-(void)connectForLocation//With:(NSString *)latStr And:(NSString *)lonStr And:(NSString *)theradius And:(NSString *)types
{
//    NSString * askStr = [NSString stringWithFormat:GOOGLEMAPURL,latStr,lonStr,theradius,types];
//    NSLog(@"askStr value is %@",askStr);
//    NSLog(@"askStr===:%@",askStr);
//    NSURL * askUrl = [NSURL URLWithString:askStr];
  //  +(MapDataList*)loadContactForMapWithUserId:(NSString*)userId andCityId:(NSString*)cityId
  //MapDataList *list = [CommonUtils loadContactForMapWithUserId:[GlobalInfo sharedGlobalInfo].userId andCityId:nil];
    MapDataList *list=[[MapDataList alloc]init];
    if (!friendType) {
        list = [CommonUtils loadContactForMapWithUserId:[GlobalInfo sharedGlobalInfo].userId andCityId:nil];
    }else if([friendType isEqualToString:@"city"]){
        
         
        
    }
    else{
        if ([friendType isEqualToString:@"name"]) {
            list = [CommonUtils loadFriendMapObjectWithFriendType:searchText cityId:nil friendType:@"0"];
        }else if([friendType isEqualToString:@"class"]){
            list = [CommonUtils loadFriendMapObjectWithFriendType:searchText cityId:nil friendType:@"1"];
        } 
    }
    

    self.infromationArr = list.mapList;
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i = 0; i<[infromationArr count]; i++) {
        MapData * info = [infromationArr objectAtIndex:i];
        CLLocationCoordinate2D anno2;
        CGFloat latF = [info.lat floatValue];
        CGFloat lonF = [info.lon floatValue];
        
        anno2.latitude = latF;
        anno2.longitude = lonF;
        MapAnnoData * anno = [[MapAnnoData alloc]initWithCoodinate:anno2];
        
        anno.title = [NSString stringWithFormat:@"%@ %@人",info.cName,[info.counts description]];//[info.counts description];
        anno.cityId = info.cId;
        [array addObject:anno];
    }
       [map addAnnotations:array];
    if ([friendType isEqualToString:@"city"]) {
      NSString * gpsstr =  [CommonUtils getGPSPointBy:self.proviceName andCName:self.cityName];
        NSArray *_array =[gpsstr  componentsSeparatedByString:@","];
        NSString *_lat = [_array objectAtIndex:2];
        NSString *_lon = [_array objectAtIndex:3];
        CLLocationCoordinate2D anno2;
        CGFloat latF = [_lat floatValue];
        CGFloat lonF = [_lon floatValue];
        anno2.latitude = latF;
        anno2.longitude = lonF;
        MapAnnoData * _anno = [[MapAnnoData alloc]initWithCoodinate:anno2];
        
        _anno.title = [NSString stringWithFormat:@"%@ %@人",self.proviceName, self.cityName];//[info.counts description];
        //anno.cityId = info.cId;
        [array addObject:_anno];
        
        [map addAnnotations:array];
        
    }

//     ASIHTTPRequest * request = [[ASIHTTPRequest alloc]initWithURL:askUrl];
//    request.delegate = self;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
//    request.secondsToCache = 3.0; 
//    [request addRequestHeader:@"Accept-Language" value:@"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3"];
//    [request startAsynchronous];
}

 
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setNeedsDisplay1];
   // self.navigationItem.title = @"地图模式";//
    
    [self setViewControllerTitle:@"地图模式"];
    infromationArr = [[NSMutableArray alloc]init];
    map = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    [map setScrollEnabled:YES];
    [map setZoomEnabled:YES];
    [map setMapType:MKMapTypeStandard];
    [map setDelegate:self];
     

//    NSMutableArray * array = [[NSMutableArray alloc]init];
//    CLLocationCoordinate2D anno2;
//    anno2.latitude = 0;
//    anno2.longitude = 0;
//    MapAnnoData * twoAnno = [[MapAnnoData alloc]initWithCoodinate:anno2];
//    twoAnno.title = @"北京";
//    twoAnno.subtitle = @"googleMap";
//    [array addObject:twoAnno];
//    [map addAnnotations:array];
    [self.view addSubview:map];
    
//    rad = @"10000";
//    type = @"food";
    
    [self performSelector:@selector(startLocation)];
    
    UIButton  *rightButtonEdit = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButtonEdit.frame = CGRectMake(0, 0, 80, 30);
    [rightButtonEdit setBackgroundImage:[CommonUtils stretchableImageFromName:@"navigationbar_button_background.png"] forState:UIControlStateNormal];
    [rightButtonEdit setTitle:@"列表模式" forState:UIControlStateNormal];
    rightButtonEdit.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButtonEdit addTarget:self action:@selector(listModel:) forControlEvents:UIControlEventTouchUpInside];
    
   
    UIBarButtonItem * Button=[[UIBarButtonItem alloc] initWithCustomView:rightButtonEdit];
    
    self.navigationItem.rightBarButtonItem =Button;
    [Button release];
    //[self rightBackBtnWithBackgroupImageName:@"navigationbar_button_background.png" withTitle:@"列表模式" andAction:@selector(listModel:)];
    
    self.navigationItem.leftBarButtonItem = nil;   
    self.navigationItem.hidesBackButton=YES;
    [self leftBackBtnWithAction:@selector(actionBack)];
   
}

-(IBAction)listModel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    NSLog(@"asdfasdfadsfasdf");
//}

#pragma mark- Map

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *_str = @"mak";
//    MKAnnotationView * _tempMap= [mapView dequeueReusableAnnotationViewWithIdentifier:_str];
//    _tempMap.image = [UIImage imageNamed:@"银联商务default.png"];//@"银联商务default";
//    UIImageView *_imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"银联商务default.png"]];
//    _imageView.frame = CGRectMake(0, 0, 50, 30);
//    _tempMap.leftCalloutAccessoryView = _imageView;
    MKPinAnnotationView *newAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:_str];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    newAnnotation.rightCalloutAccessoryView = button;
    newAnnotation.animatesDrop = YES; 
    newAnnotation.canShowCallout=YES;
    
    
        return newAnnotation;  
//    annView.pinColor = MKPinAnnotationColorGreen;
//    
//    UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    advertButton.frame = CGRectMake(0, 0, 23, 23);
//    advertButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    advertButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    
//    [advertButton setImage:[UIImage imageNamed:@"button_right.png"] forState:UIControlStateNormal];
//    [advertButton addTarget:self action:@selector(showLinks:) forControlEvents:UIControlEventTouchUpInside];
//    
//    annView.rightCalloutAccessoryView = advertButton;
//    
//    annView.animatesDrop=TRUE;
//    annView.canShowCallout = YES;
//    annView.calloutOffset = CGPointMake(-5, 5);
//    return annView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
     
    
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//
//    if ( [view.rightCalloutAccessoryView isKindOfClass:[UIButton class]]) {
//     
//        //view.annotation
//        NSLog(@"MapAnnoData%@",   view.annotation);
//        
//    }
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{ 
    if ([view.annotation isKindOfClass: [MapAnnoData class]]) {
        
        
        UIViewController *presentedViewController = [[self.navigationController viewControllers] objectAtIndex:[self.navigationController viewControllers].count-2];
        NSLog(@"presentedViewController = %@",presentedViewController);
        if ([presentedViewController isKindOfClass: [ContactsUIViewController class]]) {
            MapAnnoData *mapAn =  (MapAnnoData*)view.annotation;
            ContactsUIViewController *contacts = [[ContactsUIViewController alloc] init];
            
            contacts.cityId = mapAn.cityId;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:contacts animated:YES];
            //self.hidesBottomBarWhenPushed=NO;
            [contacts release];  
        }
        if ([presentedViewController isKindOfClass:[FoundResultViewController class]]) {
            
            FoundResultViewController *parent = (FoundResultViewController*)presentedViewController;
            if ([parent.findType isEqualToString:@"city"]) {
                [self actionBack];
                return;
            }else{
            MapAnnoData *mapAn =  (MapAnnoData*)view.annotation;
            FoundResultViewController *find = [[FoundResultViewController alloc] init];
            find.findType=parent.findType;
            find.findValues = parent.findValues;
            find.cityId = mapAn.cityId;
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:find animated:YES];
            //self.hidesBottomBarWhenPushed=NO;
            [find release];  
            }
        }
      
    }
   
}

-(void)dealloc
{
    [infromationArr release];
    [map release];
    [super dealloc];
}

-(void)actionBack{
    //[self.navigationController popViewControllerAnimated:YES];
    //[ToolLen SimpleWindowHide];
   
     
     self.hidesBottomBarWhenPushed=NO;
   
    [self.navigationController popViewControllerAnimated:YES];
     
    
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
    return YES;
}

@end
