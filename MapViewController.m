//
//  AnimatedCalloutViewController.m
//  AnimatedCallout
//
//  Created by Gordon on 2/14/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#define MAGRIN 30

#import "MapViewController.h"
#import "OrganizationItem.h"
#import "OrgAnnotation.h"
#import "OrgDetailViewController.h"
#import "DataAdapter.h"

@interface MapViewController ()
@property (nonatomic, retain) NSArray *orgItems;
- (void)showAnnotations;
- (void)showOrganizations;
@end


@implementation MapViewController

@synthesize orgItems, detailOnMap;

- (id)init {
	if (!(self = [super initWithNibName:@"GIKMapView" bundle:nil])) {
		return nil;
	}
	return self;
}

#pragma mark -
#pragma mark View management

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view sizeToFit];
    
    
	
	
}


- (void)showOrganizations
{
    MKCoordinateRegion startupRegion;
	
	// Coordinates for part of downtown San Francisco - around Moscone West, no less.
	startupRegion.center = CLLocationCoordinate2DMake(23.138597, 113.323141);
	startupRegion.span = MKCoordinateSpanMake(0.105243, 0.070689);

	[self.mapView setRegion:startupRegion animated:YES];
	[self.mapView setShowsUserLocation:NO];
	
	// Our superclass needs access to the data for the custom callout without knowing implementation details.
	self.detailDataSource = self;
	
	OrgDetailViewController *controller = [[OrgDetailViewController alloc] init];//initWithNibName:@"OrgDetailTableView" bundle:nil];
	self.calloutDetailController = controller;
	
	[self showAnnotations];
}

- (void)showAnnotations {
	
    NSArray *organizations = [DataAdapter shareInstance].organizations;
    int count = [organizations count];
    NSMutableArray *orgAnnotations = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0; i < count; i++)
    {
        OrganizationItem* orgItem = [[OrganizationItem alloc]initWithObject:organizations[i]];
        OrgAnnotation *annotation = [[OrgAnnotation alloc] initWithLatitude:orgItem.latitude longitude:orgItem.longitude];
        //OrgAnnotation* annotation = [[OrgAnnotation alloc]init];
		annotation.orgItem = orgItem;
		
		[orgAnnotations addObject:annotation];
    }
	[self.mapView addAnnotations:orgAnnotations];
}


#pragma mark -
#pragma mark GIKCalloutDetailDataSource

// Data object for the detail view of the callout.
- (void)detailController:(UIViewController *)detailController detailForAnnotation:(id)annotation {
	[(OrgDetailViewController *)detailController setItem:[(OrgAnnotation *)annotation orgItem]];
    [self.detailOnMap setItem:[(OrgAnnotation *)annotation orgItem]];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showOrganizations];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,MAGRIN)];
    label1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label1];
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height-MAGRIN,self.view.frame.size.width,MAGRIN)];
    label2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label2];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,MAGRIN,self.view.frame.size.height)];
    label3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label3];
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-MAGRIN,0,MAGRIN,self.view.frame.size.height)];
    label4.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label4];
}


#pragma mark Accessors

- (NSArray *)hotels {
	if (orgItems == nil) {
		orgItems = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Hotels" ofType:@"plist"]];
	}
	return orgItems;
}
/*
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    MKCoordinateRegion   curRegin= mapView.region;
	MKMapPoint    mapPointCenter=MKMapPointForCoordinate(curRegin.center);
	CLLocationCoordinate2D  outerCoordinate=curRegin.center;
    NSLog(@"center lat=%f, log=%f", curRegin.center.latitude, curRegin.center.longitude);
	outerCoordinate.latitude+= curRegin.span.latitudeDelta/2.0;
	outerCoordinate.longitude+=curRegin.span.longitudeDelta/2.0;
	MKMapPoint   mapPointOuter=MKMapPointForCoordinate(outerCoordinate);
	NSLog(@"span lat=%f, log=%f", curRegin.span.latitudeDelta, curRegin.span.longitudeDelta);
	CLLocationDistance          double_distance= MKMetersBetweenMapPoints(mapPointCenter,mapPointOuter);
	unsigned  int    cur_distance=(unsigned  int) double_distance;
	NSLog(@"cur_distance=%d",cur_distance);

}
 */

@end
