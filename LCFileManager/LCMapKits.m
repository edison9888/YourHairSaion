//
//  LCMapKits.m
//  YourHairSaion
//
//  Created by chen loman on 13-3-8.
//  Copyright (c) 2013年 chen loman. All rights reserved.
//

#import "LCMapKits.h"
#import "GIKAnnotation.h"
@implementation LCMapKits
+ (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address
{
    NSLog(@"geoCodeUsingAddress for:%@", address);
    double latitude = 0, longitude = 0;
    CLLocationCoordinate2D center;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    //    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    //    NSDictionary *googleResponse = [[NSString stringWithContentsOfURL: [NSURL URLWithString: req] encoding: NSUTF8StringEncoding error: NULL] JSONValue];
    //
    NSData *result = [NSData dataWithContentsOfURL:[NSURL URLWithString:req]];
    if (result)
    {
        NSDictionary *googleResponse = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        //    if (result) {
        //        NSScanner *scanner = [NSScanner scannerWithString:result];
        //        if ([scanner scanUpToString:@"\"lat\":" intoString:nil] && [scanner scanString:@"\"lat\":" intoString:nil]) {
        //            [scanner scanDouble:&latitude]
        //            if ([scanner scanUpToString:@"\"lng\":" intoString:nil] && [scanner scanString:@"\"lng\":" intoString:nil]) {
        //                [scanner scanDouble:&longitude];
        //            }
        //        }
        //    }
        if (googleResponse)
        {
            NSString* status = [googleResponse valueForKey:@"status"];
            if (status && [status isEqualToString:@"OK"])
            {
                
                NSDictionary    *resultsDict = [googleResponse valueForKey:  @"results"];   // get the results dictionary
                if (resultsDict)
                {
                    NSDictionary   *geometryDict = [resultsDict valueForKey: @"geometry"];   // geometry dictionary within the  results dictionary
                    if (geometryDict)
                    {
                        NSDictionary   *locationDict = [geometryDict valueForKey: @"location"];   // location dictionary within the geometry dictionary
                        
                        // -- you should be able to strip the latitude & longitude from google's location information (while understanding what the json parser returns) --
                        if (locationDict)
                        {
                            NSArray *latArray = [locationDict valueForKey: @"lat"];
                            NSString *latString = [latArray lastObject];     // (one element) array entries provided by the json parser
                            NSArray *lngArray = [locationDict valueForKey: @"lng"];
                            NSString *lngString = [lngArray lastObject];     // (one element) array entries provided by the json parser
                            
                            center.latitude = [latString doubleValue];;     // the json parser uses NSArrays which don't support "doubleValue"
                            center.longitude = [lngString doubleValue];
                        }
                    }
                    
                    
                }
            }
            
        }
    }
    return center;
}


+ (CLLocationCoordinate2D) geoCodeUsingAddress:(NSString *)address andCity:(NSString *)city
{
    NSLog(@"geoCodeUsingAddress for:%@ in city:%@", address, city);
    double latitude = 0, longitude = 0;
    CLLocationCoordinate2D center;
    NSString *esc_addr =  [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *esc_city =  [city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder?address=%@&output=json&key=356a9858701a78e7ccd93ce8c8fbf204&city=%@", esc_addr, esc_city];
    NSLog(@"url=%@", req);
    //    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    //    NSDictionary *googleResponse = [[NSString stringWithContentsOfURL: [NSURL URLWithString: req] encoding: NSUTF8StringEncoding error: NULL] JSONValue];
    //
    NSData *result = [NSData dataWithContentsOfURL:[NSURL URLWithString:req]];
    if (result)
    {
        NSDictionary *googleResponse = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        //    if (result) {
        //        NSScanner *scanner = [NSScanner scannerWithString:result];
        //        if ([scanner scanUpToString:@"\"lat\":" intoString:nil] && [scanner scanString:@"\"lat\":" intoString:nil]) {
        //            [scanner scanDouble:&latitude]
        //            if ([scanner scanUpToString:@"\"lng\":" intoString:nil] && [scanner scanString:@"\"lng\":" intoString:nil]) {
        //                [scanner scanDouble:&longitude];
        //            }
        //        }
        //    }
        if (googleResponse)
        {
            NSString* status = [googleResponse valueForKey:@"status"];
            if (status && [status isEqualToString:@"OK"])
            {
                
                NSDictionary    *resultsDict = [googleResponse valueForKey:  @"result"];   // get the results dictionary
                if (resultsDict)
                {
                        NSDictionary   *locationDict = [resultsDict valueForKey: @"location"];   // location dictionary within the geometry dictionary
                        
                        // -- you should be able to strip the latitude & longitude from google's location information (while understanding what the json parser returns) --
                        if (locationDict)
                        {
                            NSString *latString = [locationDict valueForKey: @"lat"];     // (one element) array entries provided by the json parser
                            NSString *lngString = [locationDict valueForKey: @"lng"];
     // (one element) array entries provided by the json parser
                            
                            center.latitude = [latString doubleValue];;     // the json parser uses NSArrays which don't support "doubleValue"
                            center.longitude = [lngString doubleValue];
                        }
                    }
                    
                    
            }
            
        }
    }
    return center;

}
+ (void)zoomToFitMapAnnotations:(MKMapView*)mapView
{
    if([mapView.annotations count] == 0)
        return;
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    for(GIKAnnotation* annotation in mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}
@end
