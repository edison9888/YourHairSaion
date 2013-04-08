//
//  ProductPic.m
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "ProductPic.h"


@implementation ProductPic

@dynamic productId;
@dynamic picType;
@dynamic picValue;
@dynamic picLink;

- (void)show
{
    NSLog(@"product id=%@, type=%@, value=%@, link=%@", self.productId, self.picType, self.picValue, self.picLink);
}
@end
