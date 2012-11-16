//
//  Organization.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-15.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Organization : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * orgDetail;
@property (nonatomic, retain) NSString * orgId;
@property (nonatomic, retain) NSString * orgName;
@property (nonatomic, retain) NSNumber * orgType;
@property (nonatomic, retain) NSString * parent;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * street;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * zip;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * imgLink;

@end
