//
//  DiscountCardItem.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DiscountCardItem.h"

@implementation DiscountCardItem
@synthesize cardId, detail, type, overlay, calcValue, discountName, discountType;

- (DiscountCardItem*)initWithObject:(DiscountCard *)dc
{
    self = [super init];
    if (self)
    {
        self.name = dc.name;
        self.imgLink = dc.imgLink;
        self.cardId = dc.cardId;
        self.detail = dc.detail;
        self.type = dc.type;
        self.overlay = self.overlay;
        self.calcValue = dc.productPricing.calcValue;
        self.discountName = dc.productPricing.discountName;
        self.discountType = dc.productPricing.discountType;
    }
    return self;
}
@end
