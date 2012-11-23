//
//  ProductType.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductType.h"


@implementation ProductType

@dynamic productType;
@dynamic typeName;
@dynamic typeParent;
@dynamic typePricingId;

- (void)show
{
    NSLog(@"type id=%@, name=%@, parent=%@, pricingid=%@", self.productType, self.typeName, self.typeParent, self.typePricingId);
}

- (BOOL)isSubType:(ProductType *)type
{
    return [type.typeParent isEqualToString:self.productType];
}
@end
