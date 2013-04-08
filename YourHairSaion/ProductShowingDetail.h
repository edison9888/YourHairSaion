//
//  ImageSource.h
//  UITest3
//
//  Created by chen loman on 12-11-11.
//  Copyright (c) 2012年 chen loman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataAdapter.h"
#import "PsDataItem.h"

@interface ProductShowingDetail : PsDataItem
@property (nonatomic, assign) long Id;
@property (nonatomic, strong) NSString* productId;
@property (nonatomic, strong) NSString* productName;
@property (nonatomic, strong) NSString* productDetail;
//@property (nonatomic, strong) UIImage* uiImg;
@property (nonatomic, strong) NSString* fileName;
@property (nonatomic, strong) NSString* fullFileName;
@property (nonatomic, strong) NSNumber* price;
@property (nonatomic, strong) NSString* productTypeName;
@property (nonatomic, strong) NSNumber* priceAfterDiscount;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger buyCount;
@property (nonatomic, strong) NSString* detail;
@property (nonatomic, assign) NSInteger orgId;
@property (nonatomic, assign) short status;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, strong) NSMutableArray* types;



+ (ProductShowingDetail*)initByIndex:(NSInteger)index;
+ (ProductShowingDetail*)initByProductBase:(ProductBase*)productBase;
+ (ProductShowingDetail*)initByDic:(NSDictionary*)dic;


@end
