//
//  ProductPic.h
//  YourHairSaion
//
//  Created by chen loman on 12-11-8.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ProductPic : NSManagedObject

@property (nonatomic, retain) NSString * productId;
@property (nonatomic, retain) NSNumber * picType;
@property (nonatomic, retain) NSData * picValue;
@property (nonatomic, retain) NSString * picLink;
- (void)show;
@end
