//
//  Hotel.m
//  AnimatedCallout
//
//  Created by Gordon on 2/14/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#import "OrganizationItem.h"


@implementation OrganizationItem

@synthesize name, street, city, state, zip, phone, url, imgLink;
@synthesize latitude, longitude;

- (id)initWithObject:(Organization*)org
{
    self = [super init];
    if (self)
    {
        name = org.orgName;
        street = org.street;
        city = org.city;
        state = org.state;
        zip = org.zip;
        phone = org.phone;
        url = org.website;
        imgLink = org.imgLink;
        latitude = [org.latitude doubleValue];
        longitude = [org.longitude doubleValue];
    }
    return self;
}

@end
