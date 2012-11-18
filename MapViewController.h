//
//  AnimatedCalloutViewController.h
//  AnimatedCallout
//
//  Created by Gordon on 2/14/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GIKMapViewController.h"
@class OrgDetailViewController;
@interface MapViewController : GIKMapViewController <GIKCalloutDetailDataSource> {
	NSArray *orgItems;
}
@property (nonatomic, strong)OrgDetailViewController* detailOnMap;
@end


