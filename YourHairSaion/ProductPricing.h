//
//  ProductPricing.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-12.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ProductPricing : NSManagedObject

@property (nonatomic, retain) NSString * calcValue;
@property (nonatomic, retain) NSString * discountName;
@property (nonatomic, retain) NSNumber * discountType;
@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) NSString * productType;
- (void)show;
@end
