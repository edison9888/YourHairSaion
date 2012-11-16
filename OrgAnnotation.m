//
//  HotelAnnotation.m
//  AnimatedCallout
//
//  Created by Gordon on 2/14/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#import "OrgAnnotation.h"
#import "OrganizationItem.h"

@interface OrgAnnotation ()

@end


@implementation OrgAnnotation
@synthesize orgItem;


- (id)initWithLatitude:(CLLocationDegrees)theLatitude longitude:(CLLocationDegrees)theLongitude {
	if (!(self = [super initWithLatitude:theLatitude longitude:theLongitude])) {
		return nil;
	}
	
	return self;
}

- (NSString *)title {
	return [self.orgItem name];
}

@end
