//
//  ProductAmount.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ProductAmount : NSManagedObject

@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) NSNumber * amount;
- (void)show;

@end
