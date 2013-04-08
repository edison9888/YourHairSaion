//
//  LCMapKits.h
//  YourHairSaion
//
//  Created by chen loman on 13-3-8.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LCMapKits : NSObject
+ (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address;
+ (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address andCity:(NSString*)city;
+ (void)zoomToFitMapAnnotations:(MKMapView*)mapView;

@end
