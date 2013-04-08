//
//  ProductPricing.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductPricing.h"


@implementation ProductPricing

@dynamic calcValue;
@dynamic discountName;
@dynamic discountType;
@dynamic productId;
@dynamic productType;
- (void)show
{
    NSLog(@"product id=%@, type=%@, discounttype=%@, discountname=%@, calcValue=%@", self.productId, self.productType, self.discountType, self.discountName, self.calcValue);
}
@end
