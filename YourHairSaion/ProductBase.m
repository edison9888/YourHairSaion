//
//  ProductBase.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductBase.h"


@implementation ProductBase

@dynamic allowCustomizeFlag;
@dynamic createTime;
@dynamic effDate;
@dynamic expDate;
@dynamic orgId;
@dynamic pricingTypeId;
@dynamic priority;
@dynamic productDetail;
@dynamic productId;
@dynamic productName;
@dynamic productState;
@dynamic productType;
@dynamic productPrice;

@synthesize productTypes;
@synthesize productAmount;
@synthesize productAttrs;
@synthesize productPics;
@synthesize productPricings;
@synthesize org;

- (void)show
{
    NSLog(@"product id=%@, name=%@, detail=%@, state=%@, type=%@ priority=%@, orgid=%@, flag=%@, effdate=%@, expDate=%@, createdate=%@, pricingId=%@, pric=%@", self.productId, self.productName, self.productDetail, self.productState, self.productType, self.priority, self.orgId, self.allowCustomizeFlag, self.effDate, self.expDate, self.createTime, self.pricingTypeId, self.productPrice);
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.productAttrs = [[NSMutableArray alloc]init];
        self.productPics = [[NSMutableArray alloc]init];
        self.productTypes = [[NSMutableArray alloc]init];
        self.productPricings = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)initExt
{
    self.productAttrs = [[NSMutableArray alloc]init];
    self.productPics = [[NSMutableArray alloc]init];
    self.productTypes = [[NSMutableArray alloc]init];
    self.productPricings = [[NSMutableArray alloc]init];
}

@end
