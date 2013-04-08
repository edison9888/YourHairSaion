//
//  DiscountCardItem.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "DiscountCardItem.h"

@interface DiscountCardItem ()


@end

@implementation DiscountCardItem
@synthesize cardId, detail, type, overlay, calcValue, discountName, discountType;

- (DiscountCardItem*)initWithObject:(DiscountCard *)dc
{
    self = [super init];
    if (self)
    {
        self.name = dc.name;
        //self.imgLink = [[DataAdapter shareInstance]getLocalPath:dc.imgLink];
        [self setDefalutImgLink:dc.imgLink];
        self.cardId = dc.cardId;
        self.detail = dc.detail;
        self.type = dc.type;
        self.overlay = dc.overlay;
        self.calcValue = dc.productPricing.calcValue;
        self.discountName = dc.productPricing.discountName;
        self.discountType = dc.productPricing.discountType;
        self.key = dc.cardId;
        
    }
    return self;
}
@end
