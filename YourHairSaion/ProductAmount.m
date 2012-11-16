//
//  ProductAmount.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductAmount.h"


@implementation ProductAmount

@dynamic productId;
@dynamic amount;
- (void)show
{
    NSLog(@"product id=%@, amount=%@", self.productId, self.amount);
}

@end
