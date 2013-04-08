//
//  ProductType.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>



@interface ProductType : NSManagedObject

@property (nonatomic, retain) NSString * productType;
@property (nonatomic, retain) NSString * typeName;
@property (nonatomic, retain) NSString * typeParent;
@property (nonatomic, retain) NSString * typePricingId;


@property (nonatomic, strong) ProductType* parentType;
- (void)show;

- (BOOL)isSubType:(ProductType*)type;

@end
