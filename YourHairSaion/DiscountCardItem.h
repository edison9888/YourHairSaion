//
//  DiscountCardItem.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-26.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import "PsDataItem.h"
#import "DataAdapter.h"

@interface DiscountCardItem : PsDataItem

@property (nonatomic, strong) NSString * cardId;
@property (nonatomic, strong) NSNumber * type;
@property (nonatomic, strong) NSString * detail;
@property (nonatomic, strong) NSNumber * overlay;
@property (nonatomic, strong) NSString * calcValue;
@property (nonatomic, strong) NSString * discountName;
@property (nonatomic, strong) NSNumber * discountType;

- (DiscountCardItem*)initWithObject:(DiscountCard*)dc;
@end
