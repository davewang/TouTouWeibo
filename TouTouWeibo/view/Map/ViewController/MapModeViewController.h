//
//  MapModeViewController.h
//  ChinaUMS
//
//  Created by 邵波 on 12-3-18.
//  Copyright (c) 2012年 DaveDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKAnnotationView.h>
#import <MapKit/MapKit.h>
#import "MapAnnoData.h" 
#import <CoreLocation/CoreLocation.h>
#import "MapDataList.h"
//#import "MapPinView.h"

@interface MapModeViewController : BaseUIViewController<MKMapViewDelegate,ASIHTTPRequestDelegate,CLLocationManagerDelegate>
{
//    IBOutlet MKMapView * mapView;
    NSString * lat;
    NSString * lon;
    NSString * type;
    NSString * rad;
    CLLocationManager * locationManager;
     NSString * friendType;
     NSString * searchText;
     NSString *proviceName;
    NSString *cityName;
    NSString *totals;
}
@property(nonatomic,retain)MKMapView * map;
@property(nonatomic,retain)NSMutableArray * infromationArr;
//@property(nonatomic,retain)NSMutableArray * mapAnnoArr;
@property(nonatomic,retain)MKPinAnnotationView * mapPinView;

-(void)connectForLocation;//With:(NSString *)latStr And:(NSString *)lonStr And:(NSString *)radius And:(NSString *)types;
@property(nonatomic,retain)NSString * friendType;
@property(nonatomic,retain)NSString * searchText;
@property(nonatomic,retain)NSString * proviceName;
@property(nonatomic,retain)NSString * cityName;
@property(nonatomic,retain)NSString * totals;
@end
