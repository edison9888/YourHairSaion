//
//  Hotel.m
//  AnimatedCallout
//
//  Created by Gordon on 2/14/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#import "OrganizationItem.h"


@implementation OrganizationItem

@synthesize street, city, state, zip, phone, url, email, detail, orgId;
@synthesize latitude, longitude;

- (id)initWithObject:(Organization*)org
{
    self = [super init];
    if (self)
    {
        self.name = org.orgName;
        street = org.street;
        city = org.city;
        state = org.state;
        zip = org.zip;
        phone = org.phone;
        url = org.website;
        detail = org.orgDetail;
        email = org.email;
        // self.imgLink = [[DataAdapter shareInstance]getLocalPath:org.imgLink];
        [self setDefalutImgLink:org.imgLink];
        latitude = [org.latitude doubleValue];
        longitude = [org.longitude doubleValue];
        //self.key = org.orgId;
    }
    return self;
}

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.name = [dic objectForKey:@"cname"];
        self.account = [dic objectForKey:@"account"];
        self.type = [[dic objectForKey:@"type"] integerValue];
        self.mobile = [dic objectForKey:@"mobile"];
        self.parent = [[dic objectForKey:@"parent"] integerValue];
        self.orgId = [[dic objectForKey:@"companyId"] integerValue];
        street = [dic objectForKey:@"street"];
        city = [dic objectForKey:@"city"];
        state = [dic objectForKey:@"state"];
        zip = [dic objectForKey:@"zip"];
        phone = [dic objectForKey:@"phone"];
        url = [dic objectForKey:@"website"];
        detail = [dic objectForKey:@"detail"];
        email = [dic objectForKey:@"email"];
        //[self setDefalutImgLink:[dic objectForKey:@"cface"]];
        latitude = [[dic objectForKey:@"latitude"] doubleValue];
        longitude = [[dic objectForKey:@"longitude"] doubleValue];
        self.key = [dic objectForKey:@"companyId"];
    }
    return self;
}

- (NSString*)address
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@",
            self.state,
            self.city,
            self.street,
            self.zip];
}

@end
