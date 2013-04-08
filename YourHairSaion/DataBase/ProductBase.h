//
//  ProductBase.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ProductAmount.h"
#import "Organization.h"
@class ProductType;


@interface ProductBase : NSManagedObject

@property (nonatomic, retain) NSNumber * allowCustomizeFlag;
@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSDate * effDate;
@property (nonatomic, retain) NSDate * expDate;
@property (nonatomic, retain) NSString * orgId;
@property (nonatomic, retain) NSString * pricingTypeId;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSString * productDetail;
@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * productState;
@property (nonatomic, retain) NSString * productType;
@property (nonatomic, retain) NSNumber * productPrice;

@property (nonatomic, strong) NSMutableArray* productTypes;
@property (nonatomic, strong) ProductAmount* productAmount;
@property (nonatomic, strong) NSMutableArray* productPricings;
@property (nonatomic, strong) NSMutableArray* productPics;
@property (nonatomic, strong) NSMutableArray* productAttrs;
@property (nonatomic, strong) Organization* org;
@property (nonatomic, strong) NSMutableDictionary* dicImages;




- (void)show;
- (void)initExt;
- (BOOL)isType:(ProductType*)type;
- (BOOL)isTypeByTypeId:(NSString*)typeId;
- (void)dropProductType:(ProductType*)type;
- (void)dropProductTypeArray:(NSArray*)types;
- (void)dropProductTypeById:(NSString*)typeId;
- (void)appendProductType:(ProductType*)type;


@end
