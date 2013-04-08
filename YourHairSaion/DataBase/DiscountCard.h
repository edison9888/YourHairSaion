//
//  DiscountCard.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ProductPricing.h"


@interface DiscountCard : NSManagedObject

@property (nonatomic, retain) NSString * cardId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSNumber * overlay;
@property (nonatomic, retain) NSString * imgLink;


@property (nonatomic, strong) ProductPricing* productPricing;

@property (nonatomic, strong) NSMutableDictionary* dicImages;


@end
