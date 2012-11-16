//
//  HotelAnnotation.h
//  AnimatedCallout
//
//  Created by Gordon on 2/14/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#import "GIKAnnotation.h"

@class OrganizationItem;

@interface OrgAnnotation : GIKAnnotation {
	OrganizationItem *orgItem;	
}

@property (nonatomic, retain) OrganizationItem *orgItem;

@end
