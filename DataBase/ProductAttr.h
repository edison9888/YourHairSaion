//
//  ProductAttr.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ProductAttr : NSManagedObject

@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) NSString * attrName;
@property (nonatomic, retain) NSString * attrDetail;
@property (nonatomic, retain) NSString * attrValue;
@property (nonatomic, retain) NSNumber * attrState;

@end
