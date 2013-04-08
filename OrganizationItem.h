//
//  Hotel.h
//  AnimatedCallout
//
//  Created by Gordon on 2/14/11.
//  Copyright 2011 GeeksInKilts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DataAdapter.h"
#import "PsDataItem.h"

@interface OrganizationItem : PsDataItem
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger parent;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *zip;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) NSInteger orgId;
@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;
@property (nonatomic, strong) NSMutableDictionary *conf;

- (id)initWithObject:(Organization*)org;
- (id)initWithDic:(NSDictionary *)dic;
- (NSString*)address;
@end
